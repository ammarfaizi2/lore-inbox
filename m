Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271189AbTGWRyL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 13:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271187AbTGWRyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 13:54:11 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:52986 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S271185AbTGWRyJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 13:54:09 -0400
Subject: Re: [PATCH 2.5] fixes for airo.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Daniel Ritz <daniel.ritz@gmx.ch>
Cc: Javier Achirica <achirica@telefonica.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-net <linux-net@vger.kernel.org>
In-Reply-To: <200307231956.58656.daniel.ritz@gmx.ch>
References: <Pine.SOL.4.30.0307231219020.12179-100000@tudela.mad.ttd.net>
	 <200307231956.58656.daniel.ritz@gmx.ch>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058983403.5516.101.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Jul 2003 19:03:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-07-23 at 18:56, Daniel Ritz wrote:
> > You cannot use down() in xmit, as it may be called in interrupt context. I
> > know it slows things down, but that's the only way I figured out of
> > handling a transmission while the card is processing a long command.
> 
> hu? no. you can do a down() as xmit is never called from interrupt context. and
> the dev->hard_start_xmit() calls are serialized with the dev->xmit_lock. the
> serialization is broken by the schedule_work() thing.

If you are about to start a long command why not mark the device busy
for transmit before starting ?
