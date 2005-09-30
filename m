Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932247AbVI3SLQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbVI3SLQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 14:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932556AbVI3SLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 14:11:16 -0400
Received: from qproxy.gmail.com ([72.14.204.196]:57801 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932247AbVI3SLQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 14:11:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=pz3sOTMD8wN3xMFQmPQ4gWC+RTVoq4+O8OWf+4o0OIuqU58CFYT9UTTWk/lyXkE9AqpSD26nndUXdubYLE8waoxZsJSOG+aOIJVWcXvm2rtUPGx1sauSWE+F/YA1aOXlWE9fGuWWVzop9/kjIbOjruUziKq1gq9pl/0AxOfNIvg=
Message-ID: <7f45d9390509301111u40b8ad31u@mail.gmail.com>
Date: Fri, 30 Sep 2005 12:11:14 -0600
From: Shaun Jackman <sjackman@gmail.com>
Reply-To: Shaun Jackman <sjackman@gmail.com>
To: debian-amd64@lists.debian.org, lkml <linux-kernel@vger.kernel.org>
Subject: Building a 64-bit module on i386
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm running the Debian i386 architecture on a amd64-k8 running an
amd64-k8 Linux kernel. I'm trying to compile a module (fuse
inicdentally) for my 64-bit kernel. I'm compiling the module using
ARCH=x86_64 CC='gcc-3.4 -m64'. This method compiles all the object
files, but modpost fails:
  Building modules, stage 2.
  scripts/mod/modpost -i
/usr/src/kernel-headers-2.6.11-9-amd64-k8/Module.symvers
/home/sjackman/src/modules/usr_src/modules/fuse/kernel/fuse.o
modpost: /home/sjackman/src/modules/usr_src/modules/fuse/kernel/fuse.o
no symtab?

Some debugging of modpost shows that in parse_elf, hdr->e_shnum is 0,
whereas readelf says that it is 20. Any suggestions?

Please cc me in your reply. Cheers,
Shaun

$ uname -a
Linux jinx.pathway.internal 2.6.11-9-amd64-k8 #1 Mon Jun 27 22:07:27
MDT 2005 x86_64 GNU/Linux
$ readelf -h fuse.o
ELF Header:
  Magic:   7f 45 4c 46 02 01 01 00 00 00 00 00 00 00 00 00
  Class:                             ELF64
  Data:                              2's complement, little endian
  Version:                           1 (current)
  OS/ABI:                            UNIX - System V
  ABI Version:                       0
  Type:                              REL (Relocatable file)
  Machine:                           Advanced Micro Devices X86-64
  Version:                           0x1
  Entry point address:               0x0
  Start of program headers:          0 (bytes into file)
  Start of section headers:          23432 (bytes into file)
  Flags:                             0x0
  Size of this header:               64 (bytes)
  Size of program headers:           0 (bytes)
  Number of program headers:         0
  Size of section headers:           64 (bytes)
  Number of section headers:         20
  Section header string table index: 17
