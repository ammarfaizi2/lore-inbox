Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265079AbUD3GA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265079AbUD3GA4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 02:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265080AbUD3GA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 02:00:56 -0400
Received: from smtp016.mail.yahoo.com ([216.136.174.113]:10112 "HELO
	smtp016.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265079AbUD3GAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 02:00:55 -0400
Message-ID: <4091EB92.9030105@yahoo.com.au>
Date: Fri, 30 Apr 2004 16:00:50 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andy Isaacson <adi@hexapodia.org>
CC: Paul Jackson <pj@sgi.com>, Andrew Morton <akpm@osdl.org>,
       vonbrand@inf.utfsm.cl, jgarzik@pobox.com, brettspamacct@fastclick.com,
       linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
References: <40904A84.2030307@yahoo.com.au> <200404292001.i3TK1BYe005147@eeyore.valparaiso.cl> <20040429133613.791f9f9b.pj@sgi.com> <20040429141947.1ff81104.akpm@osdl.org> <20040429143403.35a7a550.pj@sgi.com> <20040429145725.267ea7b8.akpm@osdl.org> <20040430000408.GA29096@hexapodia.org> <20040429173223.3ea4d0c5.akpm@osdl.org> <20040429175442.4059b57f.pj@sgi.com> <20040430053835.GA32479@hexapodia.org>
In-Reply-To: <20040430053835.GA32479@hexapodia.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Isaacson wrote:
> On Thu, Apr 29, 2004 at 05:54:42PM -0700, Paul Jackson wrote:
> 
>>Andrew wrote:
>>
>>>fadvise(POSIX_FADV_DONTNEED) is ideal for this.
>>
>>Perhaps ... perhaps not.
>>
>>Just as the knobs "only reclaim pagecache" and "reclaim vfs caches
>>harder" had too big a scope (system-wide), using fadvise might have too
>>small a scope (currently cached pages of current task only).
>>
>>If his background daemon is some shell script, say, that uses 'cat' to
>>generate the i/o to the other spindle, then he probably wants to be
>>marking that daemon job "don't let this entire job eat my pagecache",
>>not rebuilding a hacked up cat command with added POSIX_FADV_DONTNEED
>>calls every megabyte.
> 
> 
> Well, in this case it's bespoke C code so adding the fadvise isn't
> terribly difficult.  (The structure of the code doesn't lend itself to
> "do this every 10 MB" but I'm sure I can hack something up.)
> 
> It would be nicer if the kernel would do the right thing without needing
> to have its hand held, but the fadvise will solve my immediate need.
> (Assuming it works on 2.4.)

Right for one thing will always be wrong for another.
If you want some specific behaviour then you might
have to hold hands. That is just the way it goes.
