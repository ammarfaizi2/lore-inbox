Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129408AbRCHRgp>; Thu, 8 Mar 2001 12:36:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129409AbRCHRgf>; Thu, 8 Mar 2001 12:36:35 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:49676 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S129408AbRCHRg1>;
	Thu, 8 Mar 2001 12:36:27 -0500
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linux Knernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev@oss.sgi.com
Subject: Re: [PATCH] RFC: fix ethernet device initialization
In-Reply-To: <3AA6A570.57FF2D36@mandrakesoft.com>
From: Jes Sorensen <jes@linuxcare.com>
Date: 08 Mar 2001 18:35:54 +0100
In-Reply-To: Jeff Garzik's message of "Wed, 07 Mar 2001 16:17:36 -0500"
Message-ID: <d3ofvcyxhh.fsf@lxplus012.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jeff" == Jeff Garzik <jgarzik@mandrakesoft.com> writes:

Jeff> People from time to time point out a wart in ethernet
Jeff> initialization: The net_device is allocated and registered to
Jeff> the system in init_etherdev, which is usually one of the first
Jeff> things an ethernet driver probe function does.  The net_device's
Jeff> final members are setup at some time between then and the exit
Jeff> of the probe function.  There is never a clear point where the
Jeff> net device is available to the system for use.

I don't like the way you declare all the code in obscure macros in
there.

+#define DECLARE_CHG_MTU(suffix,low,high) \
+	static int suffix##_change_mtu(struct net_device *dev, int new_mtu) \
......

All it does is to make the code harder to read and debug for little/no
gain.

Jes
