Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268266AbUHQOhq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268266AbUHQOhq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 10:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268257AbUHQOhk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 10:37:40 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:37251 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S268248AbUHQOhW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 10:37:22 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Alan Cox <alan@redhat.com>
Subject: Re: PATCH: straighten out the IDE layer locking and add hotplug
Date: Tue, 17 Aug 2004 16:35:41 +0200
User-Agent: KMail/1.6.2
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
References: <20040815151346.GA13761@devserv.devel.redhat.com> <200408171612.37898.bzolnier@elka.pw.edu.pl> <20040817141837.GA14738@devserv.devel.redhat.com>
In-Reply-To: <20040817141837.GA14738@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408171635.41282.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 August 2004 16:18, Alan Cox wrote:
> On Tue, Aug 17, 2004 at 04:12:37PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > this is dubious for many non PCI drivers which use ide_register_hw() to
> > only claim/fill ide_hwifs[] entry but actual probing is done later by
> > ide-generic driver - we end up with hwif->present == 0 and
> > hwif->configured == 1 and if ide_register_hw() will try to unregister
> > such hwif it will possibly crash (because we now check for ->configured
> > not ->present in
> > ide_unregister_hwif) - you've correctly noticed in the FIXMEs that we
>
> We check present as well as we free the various parts.  The problem we have
> is interfaces exist in "allocated by someone but not present" cases. Right
> now the lack of hotplug hides the fact this is totally broken. The
> unregister code tries to be smart about this and unregisters only certain
> bits of the object if its configured & !present. Thats why I save and use
> the present value on entry.

OK, I hope it is smart enough, will double check later.

> I've not looked at how it affects SCAN_HWIF but the other seemed ok.
>
> Alan
