Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129465AbQL2QMJ>; Fri, 29 Dec 2000 11:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130092AbQL2QL7>; Fri, 29 Dec 2000 11:11:59 -0500
Received: from exit1.i-55.com ([204.27.97.1]:28107 "EHLO exit1.i-55.com")
	by vger.kernel.org with ESMTP id <S130072AbQL2QLx>;
	Fri, 29 Dec 2000 11:11:53 -0500
Message-ID: <3A4CAF32.4CCF6E36@mailhost.cs.rose-hulman.edu>
Date: Fri, 29 Dec 2000 09:35:14 -0600
From: Leslie Donaldson <donaldlf@hermes.cs.rose-hulman.edu>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test11 alpha)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx 2.4.0 test12 hang
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>   While I am in the code I also want to go digging around and see if I
>> can find a 
>> way to turn of the in memory buffering that Linux does for block devices
>> as this
>> would make my fscking a LOT shorter, (18 gigs is slow),
>
>No, because you need to do the ordering too. You could drop reiserfs on the
>disk if you are feeling adventurous as that will cut your fsck time right
>down. 

Good point, sigh , I will look into reserfs but my adventurous nature is
getting a good beat down lately.


>> >          i've read about similar hangs on an alpha on this list (same kind of controller)
>> >          any solution there ...
>
>AIC7xxx makes invalid uses of 32bit values for set_bit() and friends so it
>may be that for the Alpha and the like problems

A CLUE!

Cool I will dig into this weekend. 

Thanks a lot
Leslie Donaldson



This was also sent to me

>> would make my fscking a LOT shorter, (18 gigs is slow),
>
>18G is small by today's standards.  so I suspect the problem is 
>actually that you have sub-4K blocks, and or haven't enabled 
>sparse superblocks.  both fairly dramatically speed up fsck.


True 18 gigs is small and yes I don't have those two options
turned on , but my problem is this crash occures while Writing
to the drive not reading. So, Out of an estimated 24 crashes every
last one of them have caused me to enter single user mode manually
run e2fsck on the partition and hold down th y key for a few
minutes. Then after booting I have to go and clean out the directory
which (1-3) times results in another crash. Rexecute loop.

What I was thinking about is if I could remove the buffer layer
then I would have a lot less damage on the disk and maybe it could
just reboot on it's own. sigh



-- 
/----------------------------\ Current Contractor: None
|    Leslie F. Donaldson     | Current Customer  : None
|    Computer Contractor     | Skills:
Unix/OS9/VMS/Linux/SUN-OS/C/C++/assembly
| Have Computer will travel. | WWW  :
http://www.cs.rose-hulman.edu/~donaldlf
\----------------------------/ Email: mail://donaldlf@cs.rose-hulman.edu
Goth Code V1.1: GoCS$$ TYg(T6,T9) B11Bk!^1 C6b-- P0(1,7) M+ a24 n---
b++:+
                H6'11" g m---- w+ r+++ D--~!% h+ s10 k+++ R-- Ssw
LusCA++
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
