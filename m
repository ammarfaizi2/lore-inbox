Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314589AbSDTJlK>; Sat, 20 Apr 2002 05:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314598AbSDTJlK>; Sat, 20 Apr 2002 05:41:10 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:1287 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S314589AbSDTJlJ>;
	Sat, 20 Apr 2002 05:41:09 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] 2.5.8 sort kernel tables 
In-Reply-To: Your message of "Sat, 20 Apr 2002 09:50:53 +0100."
             <E16yqa5-0000Qs-00@the-village.bc.nu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 20 Apr 2002 19:40:57 +1000
Message-ID: <16993.1019295657@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Apr 2002 09:50:53 +0100 (BST), 
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> It requires extra storage which is unacceptable.  The kernel tables
>> must be sorted before any code that might take an exception is used.
>> The sort must be done very early, before kernel memory management is
>> setup.  In addition, the kernel stack has a limited size.
>
>Why not sort them after linking and before you boot the kernel. This sounds
>like a job for libbfd after link. I hadn't realised you planned to do the 
>sort every boot

I considered that option but decided it was easier to sort the tables
at boot time.

Which tables to sort, where they are, the size of each entry, the size
and offset of the key in each table are all arch specific.  The top
level makefile would have to make tmp_vmlinux then ask each arch
Makefile to do whatever it needed to convert tmp_vmlinux to vmlinux,
using a target specific program.

IA64 used to sort its unwind table at boot (ld was buggy at the time)
and the overhead was not noticable.  PPC already sorts at boot time, I
doubt that they notice it.  Either option would work but IMHO sorting
at boot time is easier to code and maintain.

