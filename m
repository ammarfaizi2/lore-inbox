Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263762AbUDVAuw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263762AbUDVAuw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 20:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263759AbUDVAuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 20:50:52 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:15540 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263429AbUDVAuu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 20:50:50 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: andersen@codepoet.org
Subject: Re: [PATCH] prevent module unloading for legacy IDE chipset drivers
Date: Thu, 22 Apr 2004 02:50:15 +0200
User-Agent: KMail/1.5.3
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <200404212219.24622.bzolnier@elka.pw.edu.pl> <20040422004104.GA19969@codepoet.org>
In-Reply-To: <20040422004104.GA19969@codepoet.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404220250.15078.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 of April 2004 02:41, Erik Andersen wrote:
> On Wed Apr 21, 2004 at 10:19:24PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > It is unsafe thing to do (no locking, no reference counting etc).
> > Just remove module_exit() as it was done for IDE PCI drivers.
>
> Out of curiosity, what would be needed to make it safe to unload
> all ide modules from a system with a scsi rootfs?

It doesn't matter - you still may end up unloading modules which are in use.
Plus unregistering IDE interfaces leave mess in _static_ ide_hwifs[] table.

