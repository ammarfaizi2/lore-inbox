Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288374AbSBDE3h>; Sun, 3 Feb 2002 23:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288384AbSBDE31>; Sun, 3 Feb 2002 23:29:27 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:19204 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S288374AbSBDE3P>;
	Sun, 3 Feb 2002 23:29:15 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] x86 ELF bootable kernels/Linux booting Linux/LinuxBIOS 
In-Reply-To: Your message of "03 Feb 2002 11:43:08 PDT."
             <m1y9ia76f7.fsf@frodo.biederman.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 04 Feb 2002 15:29:01 +1100
Message-ID: <18006.1012796941@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 03 Feb 2002 11:43:08 -0700, 
ebiederm@xmission.com (Eric W. Biederman) wrote:
>O.k. I have been thinking about this some more, and I have come up with a couple
>alternate of solutions....
>My final and favorite is to take an ELF image, define a couple of ELF
>note types, and add a bunch those notes saying which pieces are
>hardware dependent.  So a smart ELF loader can prune the image as it
>is loaded, and a stupid one will just attempt to load everything.  And
>with the setup for this not being bootloader specific it will probably
>encourage device pruning loaders.

That is not an ELF loader, it is an ELF *linker*.  The vmlinux image
has had all the relocations fixed up, you no longer have the data
required to discard sections.  To prune hardware dependent pieces means
moving data around and adjusting relocation entries.  you have to go
back one stage, to the individual objects, and that means linking.

Dynamically linking the kernel is hard.  You just reinvented insmod,
look at all the arch dependent linking code that has to cope with.

I suppose that you could put each hardware dependent piece in its own
section and ensure that the rest of the kernel did not refer to those
sections directly.  The rest of the kernel would have to access the
hardware dependent code via a table that was fixed up by the loader.
In addition the optional sections would have to be position independent
code because it would not be known at kbuild time where the code would
finally be loaded and run.  Seems like an awful lot of work.

