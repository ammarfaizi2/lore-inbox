Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268041AbUHQAQi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268041AbUHQAQi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 20:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268036AbUHQAQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 20:16:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15286 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268038AbUHQAOb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 20:14:31 -0400
Date: Mon, 16 Aug 2004 20:13:36 -0400
From: Alan Cox <alan@redhat.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Alan Cox <alan@redhat.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: PATCH: switch ide-proc to use the ide_key functionality
Message-ID: <20040817001336.GA25753@devserv.devel.redhat.com>
References: <20040815150414.GA12181@devserv.devel.redhat.com> <200408170135.11465.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408170135.11465.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2004 at 01:35:11AM +0200, Bartlomiej Zolnierkiewicz wrote:
> Alan, 'ide_key' protection misses driver specfiic /proc/entries.

Ok need to fix that

> It is also still racy for some drivers because ide_register_hw() -> 
> init_hwif_data() sets hwif->key to zero - you must set hwif->hold to 1.

ide_register_hw holds ide_setting_sem. I think that should be ok ?

> Can't we solve the problem in simpler way by covering affected /proc
> handlers with ide_setting_sem?

You'd need to refcount the ide objects because the 'data' value is long
lived. I did consider this but it seemed more complex. It also leaves end
users able to open an ide file and prevent unloading although I'm not
sure it is a big issue.

