Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265038AbUFVX7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265038AbUFVX7L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 19:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265098AbUFVX7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 19:59:11 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:50558 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S265038AbUFVX7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 19:59:09 -0400
To: long <tlnguyen@snoqualmie.dp.intel.com>
Cc: ak@muc.de, akpm@osdl.org, greg@kroah.com, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, tom.l.nguyen@intel.com,
       zwane@linuxpower.ca, eli@mellanox.co.il
Subject: Re: [PATCH]2.6.7 MSI-X Update
X-Message-Flag: Warning: May contain useful information
References: <200406222148.i5MLmA4Y001949@snoqualmie.dp.intel.com>
From: Roland Dreier <roland@topspin.com>
Date: Tue, 22 Jun 2004 16:57:05 -0700
In-Reply-To: <200406222148.i5MLmA4Y001949@snoqualmie.dp.intel.com> (long's
 message of "Tue, 22 Jun 2004 14:48:10 -0700")
Message-ID: <52n02vkuy6.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 22 Jun 2004 23:57:05.0872 (UTC) FILETIME=[9F08AD00:01C458B4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This looks good, a definite improvement over what's currently in the
kernel.  I do have one question about the whole msi.c file (and this
applies to the code that's already in the tree, too).  Why is config
space being accessed via calls like

	dev->bus->ops->read(dev->bus, dev->devfn, ... )

instead of just calling

        pci_read_config_word(dev, ... )

The only difference seems to be that MSI is bypassing the locking in
access.c.  Is there some reason for this?

Thanks,
  Roland
