Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266453AbUHQAbw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266453AbUHQAbw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 20:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266458AbUHQAbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 20:31:51 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:28584 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S266453AbUHQAbq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 20:31:46 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Alan Cox <alan@redhat.com>
Subject: Re: PATCH: switch ide-proc to use the ide_key functionality
Date: Tue, 17 Aug 2004 02:31:25 +0200
User-Agent: KMail/1.6.2
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
References: <20040815150414.GA12181@devserv.devel.redhat.com> <200408170135.11465.bzolnier@elka.pw.edu.pl> <20040817001336.GA25753@devserv.devel.redhat.com>
In-Reply-To: <20040817001336.GA25753@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408170231.25725.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 August 2004 02:13, Alan Cox wrote:
> On Tue, Aug 17, 2004 at 01:35:11AM +0200, Bartlomiej Zolnierkiewicz wrote:
> > Alan, 'ide_key' protection misses driver specfiic /proc/entries.
>
> Ok need to fix that
>
> > It is also still racy for some drivers because ide_register_hw() ->
> > init_hwif_data() sets hwif->key to zero - you must set hwif->hold to 1.
>
> ide_register_hw holds ide_setting_sem. I think that should be ok ?

ide_setting_sem doesn't help situation when hwif is unregistered and some 
other driver is loaded later and takes this hwif using ide_register_hw().

Highly unlikely but possible.

> > Can't we solve the problem in simpler way by covering affected /proc
> > handlers with ide_setting_sem?
>
> You'd need to refcount the ide objects because the 'data' value is long
> lived. I did consider this but it seemed more complex. It also leaves end
> users able to open an ide file and prevent unloading although I'm not
> sure it is a big issue.

Yep. :/
