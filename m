Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130146AbQJ0MFz>; Fri, 27 Oct 2000 08:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130299AbQJ0MFl>; Fri, 27 Oct 2000 08:05:41 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:33298 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S130146AbQJ0MFa>; Fri, 27 Oct 2000 08:05:30 -0400
From: bart@etpmod.phys.tue.nl
Message-Id: <200010271205.OAA31607@gum04.etpnet.phys.tue.nl>
Date: Fri, 27 Oct 2000 14:04:58 +0200 (CEST)
Reply-To: bart@etpmod.phys.tue.nl
Subject: Re: Possible critical VIA vt82c686a chip bug (private question)
To: linux-kernel@vger.kernel.org
cc: vojtech@suse.cz
In-Reply-To: <20001026173244.B8290@suse.cz>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Oct, Vojtech Pavlik wrote:
> On Thu, Oct 26, 2000 at 04:42:31PM +0200, Yoann Vandoorselaere wrote:
> 
>> > On Thu, Oct 26, 2000 at 04:20:43PM +0200, Yoann Vandoorselaere wrote:
>> > 
>> > > ...
>> > > 
>> > > Have you any idea what is the relation between time and this chip ?
>> > > 
>> > > Also, I'm experiencing the problem for several month on my 
>> > > workstation and I never could find where it was comming from...
>> > > how did you do ?
>> > 
>> > Well, it integrates both the i8253 PIT and the vt82c586 IDE controller.
>> > 
>> > I first located the wrong time was coming from gettimeofday() and not
>> > from the other sources of time the kernel provides. And then I was
>> > tracking the problem (which actually is an underflow - the chip bug
>> > causes some time offset variables go negative - 0xffffffff microseconds
>> > is about 1:20 hours). And this way I got to the spot where the patch
>> > cures the problem.
>> 
>> Ok, here is what I experienced :
>> 
>> First what is strange is that :
>> - I'm using SCSI
>> - I just have an IDE disk for mp3.
>> The IDE subsystem is never used heavilly...
>> 
>> I've experienced the problem after some time of 
>> heavy scsi IO, my screen under X was going black (like with dpms)
>> When I was moving the mouse, the image was coming back
>> for < 1 seconds, then black screen...
>> 
>> The only fix was to kill X then to reboot.
>> 
>> Anyway, thanks for your explaination...
>> I'll do a feedback for this patch ASAP.
> 
> Interesting. If it's caused by SCSI as well (might be), then it's not
> caused by heavy IDE activity but rather than that it could be heavy
> BusMastering activity instead (The IDE chip does BM as well).
> 
> I'm still wondering if it could be a Linux kernel bug (bad/concurrent
> accesses to the i8253 registers), this has to be checked.
> 

How sure are you that the chip is actually buggy? I ran into something
similar a while ago, when I mixed the two arguments to an outb in a driver, 
and ended up writing MYPORT into the timer instead of 0x40 into MYPORT.

Bart
-- 
Bart Hartgers - TUE Eindhoven 
Get my GPG key at http://etpmod.phys.tue.nl/bart/pubkey.gpg 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
