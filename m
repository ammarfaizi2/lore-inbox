Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278364AbRJWWu3>; Tue, 23 Oct 2001 18:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278365AbRJWWuT>; Tue, 23 Oct 2001 18:50:19 -0400
Received: from jalon.able.es ([212.97.163.2]:3290 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S278364AbRJWWuG>;
	Tue, 23 Oct 2001 18:50:06 -0400
Date: Wed, 24 Oct 2001 00:51:07 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Josh McKinney <forming@home.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.13-pre6 breaks Nvidia's kernel module
Message-ID: <20011024005107.A3988@werewolf.able.es>
In-Reply-To: <200110221846.f9MIkE416013@riker.skynet.be> <3BD532EC.6080803@eisenstein.dk> <20011023130756.A742@cy599856-a.home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20011023130756.A742@cy599856-a.home.com>; from forming@home.com on Tue, Oct 23, 2001 at 20:07:56 +0200
X-Mailer: Balsa 1.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20011023 Josh McKinney wrote:
>On approximately Tue, Oct 23, 2001 at 11:05:48AM +0200, Jesper Juhl wrote:
>> 
>> I use the same version of the driver with my Geforce3 and I am also 
>> running 2.4.13-pre6 and it works just fine so I don't agree with you 
>> that it breaks...
>> You do know that there are a few files that need to be recompiled every 
>> time you build a new kernel - right?
>> 
>
>I have replied to this person personally a when this thread started with what I
>think is the fix to his problem.  I have seen this error on my machine before.
>The problem arose when I compiled the running kernel with gcc-3.0.  At first I
>thought it was just gcc-3 breaking the kernel.  Then I realized that the nvidia
>modules use `cc` to compile.  The symlink to cc was gcc-2.95.  Changing the
>symlink to gcc-3.0 made the problem go away.
>

The first thing I did was to kach the horrible nVidia's Makefile. For example,
it had the bad intention of compiling and installing against the running kernel
(guess kernel with uname -r). So when you update the kernel, you have to reboot
and make nVidia drivers. I changed it to:

+KREL:=`grep UTS_RELEASE /usr/src/linux/include/linux/version.h | cut -d\" -f2`
-KERNDIR:=/lib/modules/$(shell uname -r)
+KERNDIR:=/lib/modules/$(KREL)

so it builds against a built but not-running kernel.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.12-ac6-beo #1 SMP Tue Oct 23 21:24:30 CEST 2001 i686
