Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267943AbUJGTZp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267943AbUJGTZp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 15:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267860AbUJGTXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 15:23:12 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:24998
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S267841AbUJGTR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 15:17:27 -0400
Date: Thu, 7 Oct 2004 12:16:23 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Valdis.Kletnieks@vt.edu
Cc: arun.sharma@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Kill a sparse warning in binfmt_elf.c
Message-Id: <20041007121623.674796d1.davem@davemloft.net>
In-Reply-To: <200410071854.i97IsvU5031703@turing-police.cc.vt.edu>
References: <4164756E.4010408@intel.com>
	<200410071811.i97IBQf0031262@turing-police.cc.vt.edu>
	<41658FB4.5090402@intel.com>
	<200410071854.i97IsvU5031703@turing-police.cc.vt.edu>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Oct 2004 14:54:57 -0400
Valdis.Kletnieks@vt.edu wrote:

> > dump_write() is a static function without a prototype.
> 
> static int dump_write(struct file *file, const char __user *addr, int nr)
> {
> 	return file->f_op->write(file, addr, nr, &file->f_pos) == nr;
> }
> 
> And then go find the callers and make sure what they're passing is a
> 'const char __user *' rather than a 'const void *'....

The caller's aren't, that is the point.  They run dump_write()
with set_fs(KERNEL_DS), which allows kernel pointers to be treated
as user ones in system call handling paths, which is why the cast
is needed somewhere.

