Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266379AbRGBGWI>; Mon, 2 Jul 2001 02:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266383AbRGBGV6>; Mon, 2 Jul 2001 02:21:58 -0400
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:787 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S266379AbRGBGVs>; Mon, 2 Jul 2001 02:21:48 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, rhw@MemAlpha.CX,
        rmk@arm.linux.org.uk
Subject: Re: [PATCH] Re: 2.4.6p6: dep_{bool,tristate} $CONFIG_ARCH_xxx bugs 
In-Reply-To: Your message of "Sun, 01 Jul 2001 22:52:04 MST."
             <200107020552.WAA02457@adam.yggdrasil.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 02 Jul 2001 16:21:25 +1000
Message-ID: <25244.994054885@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Jul 2001 22:52:04 -0700, 
"Adam J. Richter" <adam@yggdrasil.com> wrote:
>	In linux-2.4.6-pre8, there are only three configuration variables
>that are defined with an indented 'define_bool' statement
>(CONFIG_BLK_DEV_IDE{DMA,PCI}, and CONFIG_PCI), and the conditional
>code execute by all "if" statements in all of the config.in files
>appears to be indented (or at least the first statement in the block
>is indented).  None of these three variables has the semantics that
>I think you you described above.

A conditioned define_bool is not the only possibility, that was just
one example.  Undefined variables can be created by any of the ask,
define, dependent or choice statements listed in
Documentation/kbuild/config-language.txt, when that statement is not
executed.  The reason for not being executed can be an 'if' statement
or the code can be in a file that is not read, either the 'source'
statement is bypassed or it is for another architecture.  Also the
unset statement changes variables to undefined values.

Identifying where variables can have unset values cannot be done by a
grep of the files.  You have to follow every branch of the condition
tree, including source statements, eliminate those variables where
every branch assigns a value before it is used then flag the
remainder as "may be used while uninitialized".

