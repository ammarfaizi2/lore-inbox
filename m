Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268807AbUIHETl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268807AbUIHETl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 00:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268861AbUIHETk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 00:19:40 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:38596
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S268807AbUIHET3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 00:19:29 -0400
Date: Tue, 7 Sep 2004 21:16:37 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: jonsmirl@gmail.com, willy@debian.org, linux-kernel@vger.kernel.org
Subject: Re: multi-domain PCI and sysfs
Message-Id: <20040907211637.20de06f4.davem@davemloft.net>
In-Reply-To: <200409072115.09856.jbarnes@engr.sgi.com>
References: <9e4733910409041300139dabe0@mail.gmail.com>
	<9e47339104090715585fa4f8af@mail.gmail.com>
	<20040907161140.29fbfccc.davem@davemloft.net>
	<200409072115.09856.jbarnes@engr.sgi.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Sep 2004 21:15:09 -0700
Jesse Barnes <jbarnes@engr.sgi.com> wrote:

> On Tuesday, September 7, 2004 4:11 pm, David S. Miller wrote:
> > This is a real touchy area btw, because if there is no
> > VGA card, such I/O port accesses are going to trap and
> > we need to have a common way to handle that somehow.
> 
> So I take it your platform won't soft fail the accesses and return all 1s?

Nope, you get a machine check trap.  We have to catch these when doing
PCI config space accesses in the kernel too.  Grep for pci_poke_* in
arch/sparc64/kernel/*.c

> A potentially cleaner option which Ben and I would prefer is to use
> the vga device Jon is creating to do legacy I/O with explicit
> read/write or ioctl calls.

Definitely.  Note that xfree86 already has a signal handler for this
stuff, ppc generates traps like sparc64 too.
