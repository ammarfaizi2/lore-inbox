Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267617AbTAQRjk>; Fri, 17 Jan 2003 12:39:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267618AbTAQRjk>; Fri, 17 Jan 2003 12:39:40 -0500
Received: from poup.poupinou.org ([195.101.94.96]:7197 "EHLO poup.poupinou.org")
	by vger.kernel.org with ESMTP id <S267617AbTAQRjj>;
	Fri, 17 Jan 2003 12:39:39 -0500
Date: Fri, 17 Jan 2003 18:48:34 +0100
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: eepro100 - 802.1q - mtu size
Message-ID: <20030117174834.GF12522@poup.poupinou.org>
References: <20030117145357.GA1139@paradigm.rfc822.org> <20030117160840.GR12676@stingr.net> <20030117162818.GA1074@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030117162818.GA1074@gtf.org>
User-Agent: Mutt/1.4i
From: Ducrot Bruno <poup@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

On Fri, Jan 17, 2003 at 11:28:18AM -0500, Jeff Garzik wrote:
> On Fri, Jan 17, 2003 at 07:08:40PM +0300, Paul P Komkoff Jr wrote:
> > Replying to Florian Lohoff:
> > > Why is this patch not integerated yet ?
> > 
> > Because newer and better e100 driver, which accepts tagged frames and
> > handles it properly, already in the tree
> 
> Regardless, people still use eepro100, so I would still like to get
> eepro100 doing VLAN.
> 
> The reason why the patch was not accepted is that it changes one magic
> number to another magic number, and without chipset docs, I had no idea
> what either magic number really meant.
> 
> Now that Intel has released chipset docs, this is an excellent time to
> re-evaluate those eepro100 VLAN changes.  I still refuse to accept a
> "change the magic numbers" patch... any change will need to define
> a constant that describes the bits we wish to set/clear.
> 
> Download the e100 documentation from the e1000 sourceforge site:
> http://sourceforge.net/projects/e1000
> ["8255x Developer Manual"]
> 
> 	Jeff

BTW, it look like i82557_config_cmd is never used...



--- linux-2.4/drivers/net/eepro100.c	2003/01/17 17:33:41	1.1
+++ linux-2.4/drivers/net/eepro100.c	2003/01/17 17:34:32
@@ -499,11 +499,13 @@
 /* The parameters for a CmdConfigure operation.
    There are so many options that it would be difficult to document each bit.
    We mostly use the default or recommended settings. */
+#if 0
 static const char i82557_config_cmd[CONFIG_DATA_SIZE] = {
 	22, 0x08, 0, 0,  0, 0, 0x32, 0x03,  1, /* 1=Use MII  0=Use AUI */
 	0, 0x2E, 0,  0x60, 0,
 	0xf2, 0x48,   0, 0x40, 0xf2, 0x80, 		/* 0x40=Force full-duplex */
 	0x3f, 0x05, };
+#endif
 static const char i82558_config_cmd[CONFIG_DATA_SIZE] = {
 	22, 0x08, 0, 1,  0, 0, 0x22, 0x03,  1, /* 1=Use MII  0=Use AUI */
 	0, 0x2E, 0,  0x60, 0x08, 0x88,


-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page
