Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263258AbUC3Fy5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 00:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263240AbUC3Fy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 00:54:57 -0500
Received: from 80-169-17-66.mesanetworks.net ([66.17.169.80]:61623 "EHLO
	mail.bounceswoosh.org") by vger.kernel.org with ESMTP
	id S261681AbUC3Fyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 00:54:52 -0500
Date: Mon, 29 Mar 2004 22:55:32 -0700
From: "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>
To: Pavel Machek <pavel@suse.cz>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
Message-ID: <20040330055532.GA21154@bounceswoosh.org>
Mail-Followup-To: Pavel Machek <pavel@suse.cz>,
	Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <4066021A.20308@pobox.com> <20040329113641.GE1453@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20040329113641.GE1453@openzaurus.ucw.cz>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29 at 13:36, Pavel Machek wrote:
>32MB is one second if everything goes okay... That will be horrible for latency, right?

It'll be somewhere between half a second and 1.5 seconds, depending on
how old your hard drive is, all other things being removed from the
equation.  The media rate of modern IDE drives is about 60MB/s right
now, and going up slightly soon.  The top SCSI drives are around
85MB/s if I remember correctly.

On average, 1s is about right.

It becomes a tradeoff between a big hit now and a lot of little hits
over time.  If you don't expect to have any idle time soon, you're
probably better off flushing as big a chunk as possible to free RAM
for the upcoming/continuous workload.  If you think you might have
idle time, the lower MB/s of smaller requests will keep you more
granular and improve latency, even though overall work completed per
unit time will be slightly lower.

For a bursty access pattern, you're probably best off with small
requests that fit within the drive's cache, but I don't have any sort
of measurable data on this.

Most of the OS testing that we're subjected to doesn't attempt large
requests.

--eric

-- 
Eric D. Mudama
edmudama@mail.bounceswoosh.org

