Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268646AbUHLSK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268646AbUHLSK1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 14:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268489AbUHLSK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 14:10:26 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:11925 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S268487AbUHLSKX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 14:10:23 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Alan Cox <alan@redhat.com>
Subject: Re: IDE hackery: lock fixes and hotplug controller stuff
Date: Thu, 12 Aug 2004 19:12:35 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
References: <20040810161911.GA10565@devserv.devel.redhat.com> <200408101916.17489.bzolnier@elka.pw.edu.pl> <20040810182353.GA17364@devserv.devel.redhat.com>
In-Reply-To: <20040810182353.GA17364@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408121912.35507.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tuesday 10 August 2004 20:23, Alan Cox wrote:
> On Tue, Aug 10, 2004 at 07:16:17PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > On Tuesday 10 August 2004 18:19, Alan Cox wrote:
> > > -	Remove unsafe and essentially unfixable proc code for flipping
> > > 	between ide-cd and ide-scsi. Its no longer relevant with SG_IO.
> >
> > Shouldn't we deprecate it first...?
>
> It doesn't work now so it clearly isnt being used 8). We hold the lock
> because its a proc function and we then replace the proc functions in the
> attach method -> deadlock. It is also incredibly hard to fix without a
> major rewrite.

It is a correct analysis for /proc/ide/hdx/settings:ide-scsi but not 
for /proc/ide/hdx/driver which works just fine (modulo being racy)
and your patch removes both interfaces...

Bartlomiej
