Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268762AbUIQNpY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268762AbUIQNpY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 09:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268756AbUIQNpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 09:45:24 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:22290 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S268760AbUIQNoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 09:44:30 -0400
Message-ID: <414AEB5E.30803@hist.no>
Date: Fri, 17 Sep 2004 15:49:18 +0200
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040830)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@novell.com>
CC: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, an.li.wang@intel.com
Subject: Re: truncate shows non zero data beyond the end of the inode with
 MAP_SHARED
References: <20040915122920.GA4454@dualathlon.random> <20040915210106.GX9106@holomorphy.com> <20040915145524.079a8694.akpm@osdl.org> <20040915220016.GC9106@holomorphy.com> <20040915220819.GF15426@dualathlon.random> <4149539D.9070001@hist.no> <20040916142638.GW15426@dualathlon.random>
In-Reply-To: <20040916142638.GW15426@dualathlon.random>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:

>On Thu, Sep 16, 2004 at 10:49:33AM +0200, Helge Hafting wrote:
>  
>
>>Could this "garbage" possibly be confidential data?
>>    
>>
>
>I don't buy much in this theory.
>
>  
>
>>I.e. one user repeatedly makes and mmaps a 1-byte file,
>>extends it to 4k, and looks at the 4095 bytes of "garbage".
>>Maybe he finds some "interesting stuff" when someone else's
>>confidential file just got dropped from pagecache
>>so he could mmap this 1-byte file?
>>    
>>
>
>the old data got flushed below the i_size anyways, it sounds very
>strange that confidential data is present only over the i_size and not
>below the i_size, and if this guy has confidential data below the i_size
>then it'd better memset the whole page. And in theory nobody should touch
>the data over the i_size even if mmap allows to map it.
>  
>
I am not talking about someone  accidentally stumbling onto
something.  I was worried about someone deliberately
trying to exploit this - such people look at data above i_size
_because they can_, hoping to find something interesting there.
Something they cannot get at normally.

I am assuming that the "garbage" between i_size and the
page boundary is stuff left over from whatever that
memory page was used for earlier?  If so, it could be
4095 bytes out of the 4096 that was used to cache some
other file earlier.  Possibly someone else's confidential file. 
Or a piece of some network package that was processed a while ago.

Helge Hafting


