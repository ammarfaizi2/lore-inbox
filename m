Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266832AbUHISQv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266832AbUHISQv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 14:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266816AbUHISOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 14:14:04 -0400
Received: from fw.osdl.org ([65.172.181.6]:36584 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266815AbUHISNC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 14:13:02 -0400
Date: Mon, 9 Aug 2004 10:51:13 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Hollis Blanchard <hollisb@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [RFC] Host Virtual Serial Interface driver
Message-Id: <20040809105113.4923342d.rddunlap@osdl.org>
In-Reply-To: <1091827384.31867.21.camel@localhost>
References: <1091827384.31867.21.camel@localhost>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Aug 2004 16:23:05 -0500 Hollis Blanchard wrote:

| Hi, I have a new char driver I'd like to get comments on. It is specific
| to IBM's p5 server line; I've included a description from the comments
| here:
...
| I've included the whole file below; it's pretty much self-contained. All
| comments welcome.
| 
| -- 
|  
| #include <linux/init.h>
| #include <linux/module.h>
| #include <linux/console.h>
| #include <linux/major.h>
| #include <linux/kernel.h>
| #include <linux/sysrq.h>
| #include <linux/tty.h>
| #include <linux/tty_flip.h>
| #include <linux/sched.h>
| #include <linux/kbd_kern.h>
| #include <linux/spinlock.h>
| #include <linux/ctype.h>
| #include <linux/interrupt.h>
| #include <linux/delay.h>

To the extent possible, we like to put the linux/* files in alpha
order, and same with the asm/* files.  Separately, as you have them.

| #include <asm/uaccess.h>
| #include <asm/hvconsole.h>
| #include <asm/prom.h>
| #include <asm/hvcall.h>
| #include <asm/vio.h>
| 
| #define __ALIGNED__	__attribute__((__aligned__(sizeof(long))))

You should explain this bit (__ALIGNED__).

| static inline int hdrlen(const uint8_t *packet)
| {
| 	const int lengths[] = { 4, 6, 6, 8, };
| 	struct hvsi_header *header = (struct hvsi_header *)packet;
| 
| 	return lengths[VS_DATA_PACKET_HEADER - header->type];
| }

Any chance of bad data (value) in header->type ?

| 		if (hangup) {
| 			tty_hangup(hangup);
| 		}

extra braces (style); maybe in a few other places also.

--
~Randy
