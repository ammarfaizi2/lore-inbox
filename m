Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030276AbVLFWAk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030276AbVLFWAk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 17:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030274AbVLFWAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 17:00:40 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:34974 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1030270AbVLFWAj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 17:00:39 -0500
Date: Tue, 6 Dec 2005 22:56:19 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Mark Brown <broonie@sirena.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tim Hockin <thockin@hockin.org>,
       Harald Welte <laforge@gnumonks.org>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] natsemi: NAPI support
Message-ID: <20051206215619.GB3425@electric-eye.fr.zoreil.com>
References: <20051204224734.GA12962@sirena.org.uk> <20051204231209.GA28949@electric-eye.fr.zoreil.com> <20051205232301.GA4551@sirena.org.uk> <20051206001934.GA18329@electric-eye.fr.zoreil.com> <20051206211729.GB3709@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051206211729.GB3709@sirena.org.uk>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Brown <broonie@sirena.org.uk> :
[...]
> Prior to waiting dev_close() clears __LINK_STATE_START which will cause
> netif_rx_schedule_prep() to return false.
> As far as I can see that should prevent the interrupt handler scheduling
> any further poll() calls?

netif_rx_schedule_prep return netif_running(dev) &&
dev_close              clear_bit(__LINK_STATE_START, &dev->state);
dev_close              smp_mb__after_clear_bit(); /* Commit netif_running(). */
dev_close              while (test_bit(__LINK_STATE_RX_SCHED, &dev->state)) {
dev_close                      /* No hurry. */
dev_close                      msleep(1);
dev_close              }
dev_close              
netif_rx_schedule_prep !test_and_set_bit(__LINK_STATE_RX_SCHED, &dev->state);

--
Ueimor
