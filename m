Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264750AbTIJILv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 04:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264754AbTIJILv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 04:11:51 -0400
Received: from ns.suse.de ([195.135.220.2]:64985 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264750AbTIJILq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 04:11:46 -0400
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 2/3] netpoll: netconsole
References: <20030910074256.GD4489@waste.org.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 10 Sep 2003 10:11:42 +0200
In-Reply-To: <20030910074256.GD4489@waste.org.suse.lists.linux.kernel>
Message-ID: <p73znhdhxkx.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> writes:

> This patch uses the netpoll API to transmit kernel printks over UDP
> for uses similar to serial console.

One common problem I saw with the original netconsole patches
was that the low level drivers' poll function was grabbing the 
driver spinlock, but the driver would otherwere do printk
with the spinlock hold (->easy deadlock) 

Does your patchkit handle that?

I worked around it in some drivers by not grabbing the lock
in the direct access poll path, but it's a bit ugly. 

-Andi

P.S.: Also what would be really nice for netconsole
would be "kernel ifconfig" similar to what the nfsroot code does. 
With that it would be actually possible to use it as a full console 
replacement.
