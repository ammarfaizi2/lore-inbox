Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264571AbUIIN6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264571AbUIIN6z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 09:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264147AbUIIN4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 09:56:52 -0400
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:35289 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S264261AbUIINz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 09:55:57 -0400
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch][9/9] block: remove bio walking
Date: Thu, 9 Sep 2004 15:53:13 +0200
User-Agent: KMail/1.6.2
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>
References: <200409082127.04331.bzolnier@elka.pw.edu.pl> <20040909090314.A24950@flint.arm.linux.org.uk>
In-Reply-To: <20040909090314.A24950@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409091553.13918.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 09 September 2004 10:03, Russell King wrote:
> On Wed, Sep 08, 2004 at 09:27:04PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > [patch] block: remove bio walking
> > 
> > IDE driver was the only user of bio walking code.

was in -bk10 :-(

> The MMC driver also uses this.  Please don't remove.

OK I'll just drop this patch but can't we also use scatterlists in MMC?

The point is that I now think bio walking was a mistake and accessing
bios directly from low-level drivers is a layering violation (thus
all the added complexity). Moreover with fixed IDE PIO and without
bio walking code it should be possible to shrink struct request by
removing all "current" entries.

Bartlomiej
