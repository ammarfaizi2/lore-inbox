Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264980AbUEYRUw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264980AbUEYRUw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 13:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264986AbUEYRUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 13:20:52 -0400
Received: from mail-relay-2.tiscali.it ([212.123.84.92]:6123 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S264980AbUEYRUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 13:20:48 -0400
Date: Tue, 25 May 2004 19:21:02 +0200
From: Kronos <kronos@kronoz.cjb.net>
To: linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@attila.bofh.it>, willy@w.ods.org
Subject: Re: i486 emu in mainline?
Message-ID: <20040525172102.GA3743@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040522234059.GA3735@infradead.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@lst.de> ha scritto:
> --- kernel-source-2.6.6/arch/i386/Kconfig     2004-05-10 19:47:45.000000000 +1000
> +++ kernel-source-2.6.6-1/arch/i386/Kconfig   2004-05-10 22:21:08.000000000 +1000
> @@ -330,6 +330,41 @@
>         This is really intended for distributors who need more
>         generic optimizations.
>
> +config X86_EMU486
> +       bool "486 emulation"
> +       help

Hi,
what about adding an explicit dependancy from M386/M486? A kernel
compiled for 486 or higher won't boot on 386 anyway so the emulation
code would be useless.

diff -Nru a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig	2004-05-25 19:07:16.000000000 +0200
+++ b/arch/i386/Kconfig	2004-05-25 19:10:59.000000000 +0200
@@ -332,6 +332,7 @@
 
 config X86_EMU486
        bool "486 emulation"
+       depends on M386 || M486
        help
           When used on a 386, Linux can emulate 3 instructions from the 486
           set.  This allows user space programs compiled for 486 to run on a


Signed-off-by: Luca Tettamanti <kronos@kronoz.cjb.net>
(just in case ;) )

Luca
-- 
Home: http://kronoz.cjb.net
Windows /win'dohz/ n. : thirty-two  bit extension and graphical shell to
a sixteen  bit patch to an  eight bit operating system  originally coded
for a  four bit microprocessor  which was  written by a  two-bit company
that can't stand a bit of competition.
