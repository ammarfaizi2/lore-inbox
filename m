Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263660AbTKKRds (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 12:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263661AbTKKRds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 12:33:48 -0500
Received: from fw.osdl.org ([65.172.181.6]:27857 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263660AbTKKRdq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 12:33:46 -0500
Date: Tue, 11 Nov 2003 09:29:31 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Erik Jacobson <erikj@subway.americas.sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 /proc/interrupts fails on systems with many CPUs
Message-Id: <20031111092931.7b6d1d91.rddunlap@osdl.org>
In-Reply-To: <Pine.SGI.4.53.0311111116440.360387@subway.americas.sgi.com>
References: <Pine.SGI.4.53.0311111116440.360387@subway.americas.sgi.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Nov 2003 11:21:01 -0600 Erik Jacobson <erikj@subway.americas.sgi.com> wrote:

| Howdy.
| 
| On systems with lots of processors (512 for example), catting /proc/interrupts
| fails with a "not enough memory" error.
| 
| This was observed in 2.6.0-test8
| 
| I tracked this down to this in proc_misc.c:
| 
| static int interrupts_open(struct inode *inode, struct file *file)
| {
|    unsigned size = 4096 * (1 + num_online_cpus() / 8);
|    char *buf = kmalloc(size, GFP_KERNEL);
| 
| The kmalloc fails here.
| 
| I'm looking for suggestions on how to fix this.  I came up with one fix
| that seems to work OK for ia64.  I have attached it to this message.
| I'm looking for advice on what should be proposed for the real fix.

An alternative is to limit 'size' to a maximum of 128 KB (or whatever
the max. kmalloc() on ia64 is) and continue to use kmalloc().
Does that work for you?

Another alternative is to convert show_interrupts to use a seq_file
iterator.

--
~Randy
MOTD:  Always include version info.
