Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbUC1AE7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 19:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261979AbUC1AE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 19:04:59 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:46253 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261969AbUC1AE4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 19:04:56 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] speed up SATA
Date: Sun, 28 Mar 2004 01:13:58 +0100
User-Agent: KMail/1.5.3
Cc: Stefan Smietanowski <stesmi@stesmi.com>, linux-ide@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <4066021A.20308@pobox.com> <40660FEC.8080703@pobox.com> <406610EA.4010607@pobox.com>
In-Reply-To: <406610EA.4010607@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403280113.58555.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 28 of March 2004 00:40, Jeff Garzik wrote:
> Jeff Garzik wrote:
> > That's the main limitation on request size right now...  libata limits
> > S/G table entries to 128[1], so a perfectly aligned, fully merged
>
>     ...
>
> [1] because even though the block layer properly splits on segment
> boundaries, pci_map_sg() may violate those boundaries (James B and
> others are working on fixing this).  So...  for right now the driver
> must check the s/g entry boundaries after DMA mapping, and split them
> (again) if necessary.  IDE does this in ide_build_dmatable().

You are right but small clarification is needed: code in ide_build_dmatable()
predates segment boundary support in block layer (IDE never relied on it).

