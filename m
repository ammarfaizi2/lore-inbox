Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287148AbSAURvZ>; Mon, 21 Jan 2002 12:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287625AbSAURvP>; Mon, 21 Jan 2002 12:51:15 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:34575 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S287148AbSAURu7>; Mon, 21 Jan 2002 12:50:59 -0500
Message-ID: <3C4C5414.2090104@namesys.com>
Date: Mon, 21 Jan 2002 20:47:00 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: Rik van Riel <riel@conectiva.com.br>, Shawn Starr <spstarr@sh0n.net>,
        linux-kernel@vger.kernel.org
Subject: Re: Possible Idea with filesystem buffering.
In-Reply-To: <Pine.LNX.4.33L.0201211153110.32617-100000@imladris.surriel.com> <3C4C20A2.9040009@namesys.com> <1780530000.1011633710@tiny>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason wrote:

>
>On Monday, January 21, 2002 05:07:30 PM +0300 Hans Reiser
><reiser@namesys.com> wrote:
>
>>Rik van Riel wrote:
>>
>>>On Mon, 21 Jan 2002, Hans Reiser wrote:
>>>
>>>>Pressure received is not equal to pages yielded. ... The number of
>>>>pages yielded should depend on the interplay of pressure received and
>>>>accesses made.
>>>>
>
>Ah, once the FS starts counting accesses, we get in trouble.  The FS should
>strive to know only these 3 things:
>
>How to read useful data into a page
>How to flush a dirty page
>How to free a pinned page
>
You say this with the all the dogma of someone working with code that 
currently does things a particular way.  You provide no reasons though.

>
>
>The VM records everything else, including how often a page is accessed, and
>which pages should be freed in response to memory pressure.  Of course, the
>FS might have details on many more things such as write clustering, delayed
>allocations, or which pinned pages require tons of extra work to write out.
>This fools us into thinking the FS might be the best place to decide how to
>react under memory pressure, leading to a little VM in each FS.
>
>Everything gets cleaner if we push this info up to the VM in a generic
>fashion, instead of trying to push bits of the VM down into each
>filesystem. 
>The FS should have no idea of what memory pressure is, down that path lies
>pain, suffering, and deadlocks against the journal ;-)
>
>If the VM is telling the FS to write a pinned page when there are unpinned
>pages that can be written with less cost, then we need to give the VM
>better hints about the actual cost of writing the pinned page.
>

Oh, this means a much more complicated interface, and it means that the 
VM must take into account the optimizations of each and every 
filesystem.  Are you sure this isn't an unmaintainable centralized hell? 
In practice, will it really mean that optimizations specific to a 
particular filesystem will get ignored, because there will be too many 
of them to keep up with, and they will clutter each other up if 
implemented in one piece of code?  Will programmers really be able to 
experiment?

>
>
>For periodic group flushes (delayed allocation, journal commits, etc), we
>need better throttling on dirty pages instead of just dirty buffers like we
>do now.
>
>I'm not delusional enough to think this will make all the vm<->journal
>nastiness go away, but it hopefully should be less painful than adding
>extra VM intelligence into each FS.
>
>-chris
>
>
>
Say more about what you mean by better throttling on dirty pages, and 
how that meets the needs of slum squeezing, transaction committing, 
write clustering, etc.  Last I remember, the generic write clustering 
code in VM didn't even understand packing localities.;-)

Hans


