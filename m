Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbUAFLKp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 06:10:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbUAFLKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 06:10:45 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:51629 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261872AbUAFLKn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 06:10:43 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Davin McCall <davmac@ozonline.com.au>
Subject: Re: [PATCH] fix issues with loading PCI ide drivers as modules (linux 2.6.0)
Date: Tue, 6 Jan 2004 12:13:39 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
References: <20040103152802.6e27f5c5.davmac@ozonline.com.au> <200401051516.03364.bzolnier@elka.pw.edu.pl> <20040106135155.66535c13.davmac@ozonline.com.au>
In-Reply-To: <20040106135155.66535c13.davmac@ozonline.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401061213.39843.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 06 of January 2004 03:51, Davin McCall wrote:
> Ok - fourth try! Hopefully I'm getting better.
>
> On Mon, 5 Jan 2004 15:16:03 +0100
>
> Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> wrote:
> > You don't need to export "initializing" variable from ide.c,
> > just use "pre_init" variable from setup-pci.c :-).
>
> Yes - of course.
>
> But actually I have found an even better solution - "hwif->present" tells
> us if the hwif is currently being controlled by some chipset driver (that's
> what it's there for!) so I check that instead.

This is wrong, driver owns hwif before probing for drives
(when at least one drive is found hwif->present is set to one),
so hwif entries can be modified even with hwif->present equal to zero.

--bart

