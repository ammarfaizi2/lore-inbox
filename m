Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292613AbSBPXus>; Sat, 16 Feb 2002 18:50:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292618AbSBPXuj>; Sat, 16 Feb 2002 18:50:39 -0500
Received: from holomorphy.com ([216.36.33.161]:22146 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S292613AbSBPXua>;
	Sat, 16 Feb 2002 18:50:30 -0500
Date: Sat, 16 Feb 2002 15:50:18 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Dave Jones <davej@suse.de>, Rik van Riel <riel@conectiva.com.br>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] shrink struct page for 2.5
Message-ID: <20020216235018.GB3511@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dave Jones <davej@suse.de>, Rik van Riel <riel@conectiva.com.br>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <Pine.LNX.4.33L.0202161804330.1930-100000@imladris.surriel.com> <20020216212327.C4777@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020216212327.C4777@suse.de>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 16, 2002 at 09:23:27PM +0100, Dave Jones wrote:
>  Anton Blanchard did some nice benchmarks of this work a while
>  ago, and noticed that with one of the features (I think the
>  I forget which its in the l-k archives somewhere) there
>  seemed to be a noticable performance degradation.
>  Of course, this was a dbench test, so how reflective this is
>  of real world is another story..

I've discussed this with him.

The performance degradation was real and it was the result of
poor code generation for the address calculation of the page address.
Apparently this toolchain performance issue made driver calls that use
page_address() within it very expensive. The size reduction won't
provide as significant of benefits on 64-bit machines as it does on
32-bit machines with highmem (36-bit stuff like PAE), so it makes sense
(perhaps like 64-bit SPARC) that there may be 64-bit architectures that
will not care to use it. On the other hand, I suspect there are similar
issues on other 64-bit architectures that are the true culprit with
respect to this.

On Sat, Feb 16, 2002 at 09:23:27PM +0100, Dave Jones wrote:
>  Maybe Randy Hron can throw it in with the next round of
>  kernel tests he does ?

He is unlikely to see these detrimental effects on i386. It's
possible waitqueue collisions could happen in highly threaded
tests, but that is a different issues.

On Sat, Feb 16, 2002 at 09:23:27PM +0100, Dave Jones wrote:
>> Unfortunately I haven't managed to make 2.5.5-pre2 to boot on
>> my machine, so I haven't been able to test this port of the
>> patch to 2.5.

On Sat, Feb 16, 2002 at 09:23:27PM +0100, Dave Jones wrote:
>  Just a complete lock up ? oops ? anything ?

Triplefault well prior to console output being visible to the naked eye.


Cheers,
Bill
