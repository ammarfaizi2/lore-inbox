Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161191AbWKEHQA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161191AbWKEHQA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 02:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161196AbWKEHQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 02:16:00 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:10825 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161191AbWKEHP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 02:15:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=DCfaG4jnA52ivzdbXX9AAksWAuV/ArBOaK6pFWGJgkXbYpk3cMtiv7nWWOQCkdcLaLiWAaRXt9U7txo7MQqpYC+QthrYkpdkRV6EonKUmL0kd82GeGq9Xxu0Uw6A8ybiztWgyYLZzAqf1UQoB8V4jL8mkwJFE0R2Z3Ijgumkf1g=
Message-ID: <86802c440611042315m2c923fccmeec6b3fa1448780a@mail.gmail.com>
Date: Sat, 4 Nov 2006 23:15:57 -0800
From: "Yinghai Lu" <yinghai.lu@amd.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 32/33] x86_64: Relocatable kernel support
Cc: "Andi Kleen" <ak@suse.de>, Horms <horms@verge.net.au>,
       "Jan Kratochvil" <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, "Magnus Damm" <magnus.damm@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <m1zmb6per0.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
	 <11544302483667-git-send-email-ebiederm@xmission.com>
	 <p73d5bk1dat.fsf@verdi.suse.de>
	 <m1vepbx4aj.fsf@ebiederm.dsl.xmission.com>
	 <86802c440611042202l703de80i26931090f2809e74@mail.gmail.com>
	 <m1zmb6per0.fsf@ebiederm.dsl.xmission.com>
X-Google-Sender-Auth: d752e676889b1228
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
> If you are booting a vmlinux you read the ELF header.  The ELF header
> only describes the native mode.  Therefore no 32bit entry makes much sense.
>
Yes, but if you keep the startup_32 and it will be at 0x200000, and
startup_64 will be 0x200100. and entry point in ELF header is
0x200100.
by removing startup_32, startup_64 will be 0x200000. and entry point
in ehdr is 0x200000.
So I assume entry_point in elf_header could be used by 64bit
bootloader and phdr[1].p_addr could be used by 32bit boot loader.

YH


ELF Header:
  Magic:   7f 45 4c 46 02 01 01 00 00 00 00 00 00 00 00 00
  Class:                             ELF64
  Data:                              2's complement, little endian
  Version:                           1 (current)
  OS/ABI:                            UNIX - System V
  ABI Version:                       0
  Type:                              EXEC (Executable file)
  Machine:                           Advanced Micro Devices X86-64
  Version:                           0x1
  Entry point address:               0x200100
  Start of program headers:          64 (bytes into file)
  Start of section headers:          7192496 (bytes into file)
  Flags:                             0x0
  Size of this header:               64 (bytes)
  Size of program headers:           56 (bytes)
  Number of program headers:         5
  Size of section headers:           64 (bytes)
  Number of section headers:         42
  Section header string table index: 39

Program Headers:
  Type           Offset             VirtAddr           PhysAddr
                 FileSiz            MemSiz              Flags  Align
  LOAD           0x0000000000100000 0xffffffff80200000 0x0000000000200000
                 0x000000000032f508 0x000000000032f508  R E    100000
  LOAD           0x0000000000430000 0xffffffff80530000 0x0000000000530000
                 0x0000000000148ec8 0x0000000000148ec8  RWE    100000
  LOAD           0x0000000000600000 0xffffffffff600000 0x0000000000679000
                 0x0000000000000c08 0x0000000000000c08  RWE    100000
  LOAD           0x000000000067a000 0xffffffff8067a000 0x000000000067a000
                 0x000000000005dd68 0x00000000000e91c8  RWE    100000
  NOTE           0x0000000000000000 0x0000000000000000 0x0000000000000000
                 0x0000000000000000 0x0000000000000000  R      8
