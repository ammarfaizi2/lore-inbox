Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262625AbSJTHCO>; Sun, 20 Oct 2002 03:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262662AbSJTHCO>; Sun, 20 Oct 2002 03:02:14 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:35852 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S262625AbSJTHCN>;
	Sun, 20 Oct 2002 03:02:13 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipv4: only produce one record in fib_seq_show 
In-reply-to: Your message of "Sun, 20 Oct 2002 02:08:49 -0300."
             <20021020050849.GD15254@conectiva.com.br> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 20 Oct 2002 17:08:05 +1000
Message-ID: <22353.1035097685@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Oct 2002 02:08:49 -0300, 
Arnaldo Carvalho de Melo <acme@conectiva.com.br> wrote:
>CONFIG_PROC_FS=y
>[acme@oops net-2.5]$ l net/ipv4/built-in.o
>-rw-rw-r--    1 acme     acme       328783 Out 20 01:44 net/ipv4/built-in.o
>
>CONFIG_PROC_FS=n
>[acme@oops net-2.5]$ l net/ipv4/built-in.o
>-rw-rw-r--    1 acme     acme       320708 Out 20 02:03 net/ipv4/built-in.o

The size of an object on disk is misleading, it contains comments,
notes, relocations, debug sections etc. which are discarded when
vmlinux is built, as well as init sections which are reused after the
kernel has booted.  Also the on disk size completely excludes bss, the
bss area is created and zeroed at load time.  ls -l on a kernel object
is not a good test, use size -A instead.  On a 2.4.19 system :-

# ls -l net/ipv4/ipv4.o
-rw-r--r--    1 kaos     ocs        338885 Sep 29 13:59 net/ipv4/ipv4.o

# size -A net/ipv4/ipv4.o 
net/ipv4/ipv4.o  :
section                     size   addr
.text                     216368      0
.text.init                  2784      0   reused after boot
.fixup                       411      0
.rodata                     1442      0
.rodata.str1.32            13280      0
.rodata.str1.1              2992      0
__ex_table                   288      0
.data                      11024      0
.data.cacheline_aligned      192      0
.initcall.init                 4      0   reused after boot
.bss                       46464      0   not on disk, but occupies kernel space
.comment                    1815      0   not loaded into the kernel
.note                        660      0   not loaded into the kernel
Total                     297724          misleading!

