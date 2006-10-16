Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161232AbWJPIzP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161232AbWJPIzP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 04:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161233AbWJPIzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 04:55:15 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:61180 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP
	id S1161232AbWJPIzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 04:55:13 -0400
Date: Mon, 16 Oct 2006 10:55:47 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] cpu topology: consider sysfs_create_group return value
Message-ID: <20061016105547.3b184e78@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <20061016073126.GA9409@osiris.ibm.com>
References: <20061016073126.GA9409@osiris.ibm.com>
X-Mailer: Sylpheed-Claws 2.5.5 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2006 09:31:26 +0200,
Heiko Carstens <heiko.carstens@de.ibm.com> wrote:

> From: Heiko Carstens <heiko.carstens@de.ibm.com>
> 
> [patch] cpu topology: consider sysfs_create_group return value.
> 
> Take return value of sysfs_create_group() into account. That function got
> called in case of CPU_ONLINE notification. Since callbacks are not allowed
> to fail on CPU_ONLINE notification do the sysfs group creation on
> CPU_UP_PREPARE notification.
> Also remember if creation succeeded in a bitmask. So it's possible to know
> wether it's legal to call sysfs_remove_group or not.
> 
> In addition some other minor stuff:
> 
> - since CPU_UP_PREPARE might fail add CPU_UP_CANCELED handling as well.
> - use hotcpu_notifier instead of register_hotcpu_notifier.
> - #ifdef code that isn't needed in the !CONFIG_HOTPLUG_CPU case.
> 
> Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> ---
> 
>  drivers/base/topology.c |   56 +++++++++++++++++++++++++++---------------------
>  1 file changed, 32 insertions(+), 24 deletions(-)

Looks good.

Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
