Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266302AbRGBAjw>; Sun, 1 Jul 2001 20:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266305AbRGBAjl>; Sun, 1 Jul 2001 20:39:41 -0400
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:23561 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S266302AbRGBAja>; Sun, 1 Jul 2001 20:39:30 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Riley Williams <rhw@MemAlpha.CX>
cc: Russell King <rmk@arm.linux.org.uk>, Adam J Richter <adam@yggdrasil.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: 2.4.6p6: dep_{bool,tristate} $CONFIG_ARCH_xxx bugs 
In-Reply-To: Your message of "Mon, 02 Jul 2001 00:04:22 +0100."
             <Pine.LNX.4.33.0107012309340.18977-101000@infradead.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 02 Jul 2001 10:39:04 +1000
Message-ID: <21374.994034344@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Jul 2001 00:04:22 +0100 (BST), 
Riley Williams <rhw@MemAlpha.CX> wrote:
>Can I suggest you re-read your comment and the points you quoted and
>said are correct. As a DIRECT logical consequence of "(1) and (3) are
>correct" (as you phrased it), we get the conclusion that any config
>lines that depend on "if some arch is set" (as you phrased it) are in
>the architecture-specific config files. This leads DIRECTLY to the
>conclusion that ANY lines dependant on a particular architecture that
>are not in the architecture-specific config files are a bug in the
>kernel config scripts.

No.  We want network drivers to be in the network menu, SCSI drivers in
the SCSI menu etc.  Some of those drivers are restricted to some
architectures but putting them in the arch config splits the logical
flow of selection and duplicates text.  Look at the repeated SCSI code
in some of the arch configs.

> 2. dep_arch_tristate CONFIG_var CONFIG_arch [CONFIG_other_var...]

dep_arch_tristate '  AM79C961A support' CONFIG_ARM_AM79C961A $CONFIG_ARCH_ACORN $CONFIG_NET_ETHERNET

fails your code.  $CONFIG_ARCH_ACORN is undefined, $CONFIG_NET_ETHERNET
is 'y'.  dep_arch_tristate is invoked with 3 (not 4 parameters), text,
CONFIG_ARM_AM79C961A and 'y'.  The intervening undefined variable
disappears in shell scripts.

