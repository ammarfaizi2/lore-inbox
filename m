Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264141AbUACVlR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 16:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264254AbUACVlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 16:41:16 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:4104 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S264141AbUACVlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 16:41:15 -0500
Date: Sun, 4 Jan 2004 00:41:07 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: John Goerzen <jgoerzen@complete.org>, linux-kernel@vger.kernel.org
Cc: James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: 2.6.1rc1 fails to build on Alpha
Message-ID: <20040104004107.A20261@den.park.msu.ru>
References: <slrnbvd1ci.2mp.jgoerzen@christoph.complete.org> <20040103184904.A3321@Marvin.DL8BCU.ampr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040103184904.A3321@Marvin.DL8BCU.ampr.org>; from dl8bcu@dl8bcu.de on Sat, Jan 03, 2004 at 06:49:04PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 03, 2004 at 06:49:04PM +0000, Thorsten Kranzkowski wrote:
> I was able to eliminate these with 'Support for hot-pluggable devices'.
> 
> >From what I understand there must be hiding some errorneous declaration
> somewhere, i.e. a pointer to something that is thrown away at link time.

Precisely.

> Didn't find it yet, though :)

That was recent change to sym53c8xx_2 driver:
now sym2_probe() marked as __devinit calls sym_detach() from
[discarded] .exit.text section...

Ivan.

--- rc1/drivers/scsi/sym53c8xx_2/sym_glue.c	Sat Jan  3 22:49:31 2004
+++ linux/drivers/scsi/sym53c8xx_2/sym_glue.c	Sat Jan  3 23:35:54 2004
@@ -2173,11 +2173,10 @@ sym53c8xx_pci_init(struct pci_dev *pdev,
 
 
 /*
- *  Called before unloading the module.
  *  Detach the host.
  *  We have to free resources and halt the NCR chip.
  */
-static int __devexit sym_detach(struct sym_hcb *np)
+static int sym_detach(struct sym_hcb *np)
 {
 	printk("%s: detaching ...\n", sym_name(np));
 
