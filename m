Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279652AbRJYATJ>; Wed, 24 Oct 2001 20:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279653AbRJYAS7>; Wed, 24 Oct 2001 20:18:59 -0400
Received: from jalon.able.es ([212.97.163.2]:38068 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S279652AbRJYASp>;
	Wed, 24 Oct 2001 20:18:45 -0400
Date: Thu, 25 Oct 2001 02:19:14 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Reid Hekman <reid.hekman@ndsu.nodak.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.13-pre6 breaks Nvidia's kernel module
Message-ID: <20011025021914.C2928@werewolf.able.es>
In-Reply-To: <200110221846.f9MIkE416013@riker.skynet.be> <3BD532EC.6080803@eisenstein.dk> <20011023130756.A742@cy599856-a.home.com> <20011024005107.A3988@werewolf.able.es> <3BD72D5C.30604@ndsu.nodak.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3BD72D5C.30604@ndsu.nodak.edu>; from reid.hekman@ndsu.nodak.edu on Wed, Oct 24, 2001 at 23:06:36 +0200
X-Mailer: Balsa 1.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20011024 Reid Hekman wrote:
>J . A . Magallon wrote:
>
>> The first thing I did was to kach the horrible nVidia's Makefile. For example,
>> it had the bad intention of compiling and installing against the running kernel
>> (guess kernel with uname -r). So when you update the kernel, you have to reboot
>> and make nVidia drivers. I changed it to:
>> 
>> +KREL:=`grep UTS_RELEASE /usr/src/linux/include/linux/version.h | cut -d\" -f2`
>> -KERNDIR:=/lib/modules/$(shell uname -r)
>> +KERNDIR:=/lib/modules/$(KREL)
>> 
>> so it builds against a built but not-running kernel.
>> 
>> 
>
>I thought use of /usr/src/linux was not recommended anymore. On my 
>distro, that file would point to the original kernel, the one that 
>glibc, et al. is compiled with, not my current running kernel or ones 
>I've not yet booted with. Perhaps a `uname -r` with command-line 
>override would be more appropriate?
>

As I see it, that is exactly what should not be done. Lets suppose you are
running 2.4.12. You want to upgrade. So you unpack 2.4.13 and build it.
If you go now to build nVidia drivers, with the shipped Makefile they
still build and install against 2.4.12. Sou you have to reboot in runlevel
3 to have 2.4.13 running witoht X, and then install the driver. *grrr*
With the above change, you build your kernel, then you go to the nVidia
sources, build the driver and install on the proper 2.4.13 dir under
/lib/modules, and just reboot in X again.

About /usr/src/linux, what is not recommended is to symlink
/usr/include/asm -> /usr/src/linux/include/asm
/usr/include/linux -> /usr/src/linux/include/linux
but instead have a separate header package that installs under /usr/include.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.13-beo #2 SMP Thu Oct 25 00:59:08 CEST 2001 i686
