Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265362AbRFVHol>; Fri, 22 Jun 2001 03:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265363AbRFVHoc>; Fri, 22 Jun 2001 03:44:32 -0400
Received: from d12lmsgate-3.de.ibm.com ([195.212.91.201]:18064 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S265362AbRFVHoZ>; Fri, 22 Jun 2001 03:44:25 -0400
From: Stefan.Bader@de.ibm.com
X-Lotus-FromDomain: IBMDE
To: Chris Mason <mason@suse.com>, Andrea Arcangeli <andrea@suse.de>,
        Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Message-ID: <C1256A73.002A798E.00@d12mta05.de.ibm.com>
Date: Fri, 22 Jun 2001 09:43:54 +0200
Subject: Re: correction: fs/buffer.c underlocking async pages
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Chris Mason <mason@suse.com>
06/21/01 08:20 PM
Please respond to Chris Mason


        To:     Andrea Arcangeli <andrea@suse.de>, Linus Torvalds
<torvalds@transmeta.com>
        cc:     Stefan Bader/Germany/IBM@IBMDE,
linux-kernel@vger.kernel.org
        Subject:        Re: correction: fs/buffer.c underlocking async
pages







On Thursday, June 21, 2001 07:15:22 PM +0200 Andrea Arcangeli
<andrea@suse.de> wrote:

>> On Thu, Jun 21, 2001 at 09:56:04AM -0700, Linus Torvalds wrote:
>>  What's the problem with the existing code, and why do people want to
add
>> a
>>> (unnecessary) new bit?
>>
>> there's no problem with the existing code, what I understood is that
>> they cannot overwrite the ->b_end_io callback in the lowlevel blkdev
>> layer or the page will be unlocked too early.

>Just to be more explicit, the big problem is mixing different async
>callbacks on the same page.  The patch would also allow things like this:
>
>fs_specific_end_io() {
>    do something special
>    end_buffer_io_async()
>}
>
>-chris

Yes, that was exactly the thing I tried to do. In my case some sort of
bookkeeping
how many IO's where mapped (to a certain path) and how many came back.
My assumption first was, if I am restoring the old pointers before I call
the original
function it should work.
After running into problems this patch was just my quick hack to try out
whether this
was the only place that I did not think of. I wouldn't insist on the exact
way to do it,
but since it worked for me, I thought it might be worth to discuss (or
even be useful
for other people... ;-)).

- Stefan

Linux for eServer development
Stefan.Bader@de.ibm.com
Phone: +49 (7031) 16-2472
----------------------------------------------------------------------------------

  When all other means of communication fail, try words.



