Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262873AbSJBAQA>; Tue, 1 Oct 2002 20:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262885AbSJBAQA>; Tue, 1 Oct 2002 20:16:00 -0400
Received: from netlx010.civ.utwente.nl ([130.89.1.92]:16784 "EHLO
	netlx010.civ.utwente.nl") by vger.kernel.org with ESMTP
	id <S262873AbSJBAP6>; Tue, 1 Oct 2002 20:15:58 -0400
From: caligula@cam029208.student.utwente.nl
To: linux-kernel@vger.kernel.org
Cc: Thomas Molina <tmolina@cox.net>
Subject: 2.5.40 : loadlin failure + analysys WAS : 2.5.32 bootfailure for nfsroot
Date: Wed, 02 Oct 2002 00:22:58 GMT
Reply-To: caligula@cam029208.student.utwente.nl
Message-ID: <3d9a3be8.17342037@cam029208.student.utwente.nl>
References: <200209271239.g8RCdIp09188@Port.imtp.ilyichevsk.odessa.ua> <Pine.LNX.4.44.0209271729230.26871-100000@cam029208.student.utwente.nl>
In-Reply-To: <Pine.LNX.4.44.0209271729230.26871-100000@cam029208.student.utwente.nl>
X-Mailer: Forte Free Agent 1.21/32.243
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Sep 2002 17:50:06 +0200, in linux.kernel you wrote:

>On Fri, 27 Sep 2002, Denis Vlasenko wrote:
>
>> > > The subject says it all.
>> > > 2.5.32 doesn't boot when using nfsroot.
>> > > same systems running fine with 2.4.19/2.5.31
>> > >
>> > > SYSTEMS:
>> > >    athlon with/without preempt. (flatbak)
>> > >    i586 with preempt.           (cam029205)
>> > >
>> > > The relevant configs/dmesg/lspci are on
>> > > cam029208.student.utwente.nl/~caligula.
>> > >
>> > > SYMPTOMS:
>> > > I'm using loadlin to load the kernels. I see the kernel loading,unzipping
>> > > and then...black screen followed by reboot.
>> >
>> > Small update.
>> > Still no joy with 2.5.33. Same results,same symptoms :(
>> 
>> Why do you think it is nfsroot related?
>> Does it boot off local filesystem?
>> --
>> vda
>> 
>
>
>Well, it was a guess. And a very wrong one too,it appeard later on.
>
>After I posted the message and got no reaction,I tried some different 
>kernel configs,and finally a very lean one.  No preempt,i386 only,no 
>mtrr,no ide,no nfsroot. The idea was let the kernel boot,and then 
>let it complain  it can't find a rootsystem. Even that wouldn't work.
>Same symptoms. Loadlin unzapping kernel and than whush...black screen 
>followed by reboot.
>
>A very lean kernel >2.5.32 won't boot with loadlin on my system.
>So no relation to nfsroot (my mistake).
>
>So my GUESS is,it has something to do with the interaction between loadlin 
>and the kernel.
>
>Greetz Mu
>

Ave kernel people.

I did a little bit further testing with kernel 2.5.40.  I made a very
very lean kernelconfig. No ide/scsci/preemp/nfsroot/ etc etc. With
that config the kernel can only boot,setup basic stuff   and than
complain it can't find a root filesys :) The configfile can be found
at cam029208.student.utwente.nl/~caligula/kernel along with a
lspci.txt of the test pc and a dmesg of the last working 2.5 kernel
(2.5.31) wich works with lloadlin on that test pc.

I build 3 kernels:zdisk,zImage and bzImge. All with gcc 2.95.3 and 
all with the same lean kernelconfig.

Results:
1) zdisk -->booting fine from floppy,stops when it can't find a
rootfilesystem. which is obvious since no ide/scsci
/nfsroot/ramdisk/initrd  is compiled in. So thumbs up with this setup.

2)loadin + zImage --> loadlin loads kernel from hard disk,starts
unzipping . The dots which indicate the progress keeps going,until ...
whush,black screen followed by soft reboot.

3)loadlin +bzImage -->same symptoms as loadlin+zimage.

The same setup works flawless with 2.4.x and 2.5.x <=2.5.31

So now the questions. What did change from .31 to .32 wich could have
influenced the interaction of loadin with the kernel? And how can I
debug this?  I'm no coder but turning on debugging code with #defines
is in my reach.

Greetz Mu

