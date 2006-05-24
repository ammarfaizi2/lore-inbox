Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932215AbWEXUGL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbWEXUGL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 16:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbWEXUGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 16:06:11 -0400
Received: from nz-out-0102.google.com ([64.233.162.195]:3561 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751270AbWEXUGJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 16:06:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WUQwtkd01FWg4CE+WCm94sX68Gf+pw9dhQLo9DDl59yxBIKwSLdhhtY4ULERCRt7SS4WPKpR7jrPyHulQYxCTkrC0yLa2s39CxE2dRx8hFRhseGa5fv0vKBKIPf4dz/vh9KRy/cgoDwzjTTaf2P9zy9ykgGATjXC/c/HcZAw8VM=
Message-ID: <3faf05680605241306t64f63225i4d25af3e92a9d9f9@mail.gmail.com>
Date: Thu, 25 May 2006 01:36:08 +0530
From: "vamsi krishna" <vamsi.krishnak@gmail.com>
To: "vamsi krishna" <vamsi.krishnak@gmail.com>, linux-kernel@vger.kernel.org,
       dan@debian.org
Subject: Re: Program to convert core file to executable.
In-Reply-To: <20060524173821.GA1292@nevyn.them.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3faf05680605241018q302d5c0em6844765f81669498@mail.gmail.com>
	 <20060524173821.GA1292@nevyn.them.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Daniel,

> Look at the program headers.  Many of them probably have a file size of

I checked the PHDRS (readelf --segments) the following are the PHDRS
of the core.exe

===============<BEGIN>==================
Elf file type is EXEC (Executable file)
Entry point 0x8048364
There are 11 program headers, starting at offset 52

Program Headers:
  Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
  NOTE           0x000194 0x00000000 0x00000000 0x00a48 0x00000     0
  **LOAD           0x001000 0x08048000 0x00000000 0x00000 0x01000 R E 0x1000

  LOAD           0x001000 0x08049000 0x00000000 0x01000 0x01000 RWE 0x1000
  LOAD           0x002000 0xf649b000 0x00000000 0x01000 0x01000 RWE 0x1000
  **LOAD           0x003000 0xf649c000 0x00000000 0x00000 0x132000 R E 0x1000
  LOAD           0x003000 0xf65ce000 0x00000000 0x03000 0x03000 RWE 0x1000
  LOAD           0x006000 0xf65d1000 0x00000000 0x03000 0x03000 RWE 0x1000
  LOAD           0x009000 0xf65e8000 0x00000000 0x01000 0x01000 RWE 0x1000
  **LOAD           0x00a000 0xf65e9000 0x00000000 0x00000 0x15000 R E 0x1000
  LOAD           0x00a000 0xf65fe000 0x00000000 0x01000 0x01000 RWE 0x1000
  LOAD           0x00b000 0xfeffe000 0x00000000 0x02000 0x02000 RWE 0x1000
======================<END>=============

o As you said I see some of the PHDRS are having FileSiz as zero, the
first (1st **ed ) PHDR which is having virtual address 0x08048000
(this is obviously) the start of the text of the program, and its not
having any memory in the core file.

o Does the other PHDRS for which FileSiz is zero correspond to the
dynamic shared objects (.so) text ?? example in the above we see (2
**ed ) PHDR with VirtAddr as 0xf649c000 , so this means the text of
some shared .so has been mapped here right?

o I have question about the memory mapping with permissions r--s or
r--p (gconv used by glibc gets mapped like this some time) , so does
the core file contains this information of the memory mappings?

o Is there a way I can findout the standard which the OS follows to
write the core file?

o Rather than depending on the OS core file, hows your opinion on
writing out all the mappings form /proc/<pid>/maps as PT_LOAD into a
elf formatted file of type ET_EXEC, do you think this works? rather
than converting core file to exe?

>
> Of course, the kernel shouldn't crash!  It sounds like a bug.
>

Yes I can reproduce this , is there a bugzilla for kernel? (or should
we report this at the buzilla of the distribution?)

Thank you,
Vamsi
