Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316598AbSGGViZ>; Sun, 7 Jul 2002 17:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316599AbSGGViY>; Sun, 7 Jul 2002 17:38:24 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:35240 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S316598AbSGGViX>; Sun, 7 Jul 2002 17:38:23 -0400
Message-ID: <3D28B423.9060903@us.ibm.com>
Date: Sun, 07 Jul 2002 14:35:31 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>,
       kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: BKL removal
References: <Pine.LNX.4.44L.0207061306440.8346-100000@imladris.surriel.com> <3D27390E.5060208@us.ibm.com> <20020707205543.GA18298@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
>>It is not just a matter of scalability, but maintainability.  I find 
>>it hard to read and understand code which uses the BKL.  As Greg said 
>>in his OLS coding style talk, I want you to be able to read my code to 
>>find _my_ mistakes.  Your ability to do that will be impaired by every 
>>bad indentation, typedef, and BKL use.
> 
> Excuse me, but please do NOT compare coding style with using the BKL!  I
> can use the BKL in my code just fine, and it does not impare your
> ability to use, modify, or understand my code.  As long as I comment why
> I am using the BKL.

If it was easy to modify, I wouldn't be making such a mess of things, 
right? (this assumes I'm _not_ a blundering idiot, which hasn't been 
proven)

  "As long as I comment [and understand] why I am using the BKL." 
would be a bit more accurate.  How many places in the kernel have you 
seen comments about what the BKL is actually doing?  Could you point 
me to some of your comments where _you_ are using the BKL?  Once you 
fully understand why it is there, the extra step of removal is usually 
very small.

>>A lock with a single purpose, guarding relatively small amounts of 
>>data is much easier to understand than one such as the BKL.  Would you 
>>want a simple VM operation to take 1 second as the TTY layer and ext3 
>>take their sweet time with the BKL?
> 
> If ext3 is spinning on the BKL, then try to fix that, as it seems like a
> worthwhile task (like the ext2 changes proved.)  If you want to remove
> the BKL from the tty layer, be my guest, that will involve rewriting
> that whole subsystem :)

All that I'm saying is that there can be unintended consequences.  By 
having it in your code, you open the possibility of these strange 
interactions and a drop in _your_ code's reliability.

I'm staying well away from the TTY layer, it is just a well known 
example.

>>I would mind the BKL a lot less if it was as well understood 
>>everywhere as it is in VFS.  The funny part is that a lock like the 
>>BKL would not last very long if it were well understood or documented 
>>everywhere it was used.
> 
> I would mind it a whole lot less if when you try to remove the BKL, you
> do it correctly.  So far it seems like you enjoy doing "hit and run"
> patches, without even fully understanding or testing your patches out
> (the driverfs and input layer patches are proof of that.)  This does
> nothing but aggravate the developers who have to go clean up after you.

Like it or not, the only way to get maintainers to pay any attention 
at all is to give them code.  Is there more likely to be progress if I 
just say, "Hey Greg, why don't you take the BKL out of USB", or if I 
send you a crappy patch which has the beginning of a valid approach? 
Code gets people thinking.

> Also, stay away from instances of it's use WHERE IT DOES NOT MATTER for
> performance.  If I grab the BKL on insertion or removal of a USB device,
> who cares?  I know you are trying to remove it entirely out of the
> kernel, but please focus on places where it actually helps, and leave
> the other instances alone.

You're sorely mistaken because I'm not trying to remove it entirely 
from the kernel.  I wouldn't cry if that happened tomorrow, but I 
don't have any delusions about it happening any time soon.

Call me "Ike", but I'm a domino theorist.  One instance of the BKL 
spawns many more over time, because they tend to proliferate for no 
other reason than "just to be safe".  The hardest ones to remove are 
those that shouldn't have been there in the first place.

-- 
Dave Hansen
haveblue@us.ibm.com

