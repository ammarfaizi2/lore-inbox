Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268281AbUHQPHO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268281AbUHQPHO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 11:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268277AbUHQPHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 11:07:13 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:64903 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S268281AbUHQPGk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 11:06:40 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Alan Cox <alan@redhat.com>
Subject: Re: PATCH: straighten out the IDE layer locking and add hotplug
Date: Tue, 17 Aug 2004 17:05:43 +0200
User-Agent: KMail/1.6.2
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
References: <20040815151346.GA13761@devserv.devel.redhat.com> <200408171630.07979.bzolnier@elka.pw.edu.pl> <20040817144604.GA30778@devserv.devel.redhat.com>
In-Reply-To: <20040817144604.GA30778@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408171705.43974.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 August 2004 16:46, Alan Cox wrote:
> > ide_match_hwif() checks for hwif->chipset - ordering will not be the same
> > i.e. you load driver for some IDE PCI controller which doesn't have
> > drives attached to it, unload it, load some other driver - hwifs will be
> > reused - some sequence in 2.4 will possibly leave you with different
> > ordering because hwif->chipset will stay as ide_pci not ide_unknown
>
> You can't unload them in 2.4.

Really?  That would simplify a lot of considerations...

> > Yep, please tell me how are you going to support drive hot plug?
>
> We can do it the 2.4-ac way - that works with the locking I think. What

if you are talking about abusing HDIO_SCAN_HWIF then HELL NO

> might be nicer if it works out is to follow the shutdown/suspend code
> approach so that we actually queue the "unplug" into the command stream.

and we are back to lack of sysfs integration
