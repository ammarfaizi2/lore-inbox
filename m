Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290054AbSAKSZH>; Fri, 11 Jan 2002 13:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290055AbSAKSY4>; Fri, 11 Jan 2002 13:24:56 -0500
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:13959 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S290054AbSAKSYo>; Fri, 11 Jan 2002 13:24:44 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Q] Looking for an emulation for CMOV* instructions.
In-Reply-To: <E16Opxl-00066O-00@the-village.bc.nu>
From: Ronald Wahl <Ronald.Wahl@informatik.tu-chemnitz.de>
Date: 11 Jan 2002 19:24:42 +0100
Message-ID: <m2g05cn3th.fsf@goliath.csn.tu-chemnitz.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Civil Service)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jan 2002 00:54:29 +0000 (GMT), Alan Cox wrote:

>> The compiler doesn't know, where the binary runs later. Or do you mean,
>> that it has to insert some code that checks for the existance of these
>> instructions during program start? Ok that would be a solution, but how
>> do you do this for libraries that are not run in itself?

> It means the compiler for -m686 shouldn't have assumed cmov was
> available

It's not the compiler that is responsible for it. At least in my case.
The problem is that if you compile the glibc than some assembler code
gets included into glibc.  So the problem here is glibc and not gcc.
Ok, the way to go for me now will be to make a new glibc without this
instructions. But I still think it would be a step to more fault
tolerance (or tolerance to goofy admins ;-) if we could have an
emulation of this. If I find some time I will do this...

>> but the costs of automatically catching such errors are little in
>> respect of the benefit you get. A running system is always better than
>> a unusable one even if it was the admins fault.

> Then while you are it you can make the kernel magically recover from rm -rf /
> or rm * in /lib...

Let the FS driver copy all modified sectors into a hidden log on the
disk (fixed or dynamic in size or as a ringbuffer). Then e.g during
kernel startup in case you removed most of the system you might be asked
to recover from some point. Such concepts are used by software like
HDD-Sheriff but one level below (disc sector level). On filesystem level
it makes more sense since you may recover partially. All that will bloat
the kernel but it would be possible. This case is one that has (very)
high costs. Not that I want this but I want to show that there _are_
ways to do it.

ron

-- 
/\/\  Dipl.-Inf. Ronald Wahl                /\/\        C S N         /\/\
\/\/  ronald.wahl@informatik.tu-chemnitz.de \/\/  ------------------  \/\/
/\/\  http://www.tu-chemnitz.de/~row/       /\/\  network and system  /\/\
\/\/  GnuPG/PGP key available               \/\/    administration    \/\/
