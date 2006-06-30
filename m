Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbWF3Hie@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbWF3Hie (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 03:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbWF3Hie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 03:38:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:11216 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750705AbWF3Hie (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 03:38:34 -0400
Date: Fri, 30 Jun 2006 00:38:16 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Eric Sesterhenn <snakebyte@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch] Off by one in drivers/block/floppy.c
Message-Id: <20060630003816.a7217c81.zaitcev@redhat.com>
In-Reply-To: <mailman.1151538660.27595.linux-kernel2news@redhat.com>
References: <mailman.1151538660.27595.linux-kernel2news@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.17; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jun 2006 23:57:49 +0200, Eric Sesterhenn <snakebyte@gmx.de> wrote:

> +++ linux-2.6.17-git11/drivers/block/floppy.c	2006-06-27 23:49:40.000000000 +0200
> @@ -684,7 +684,7 @@ static void __reschedule_timeout(int dri
>  	if (drive == current_reqD)
>  		drive = current_drive;
>  	del_timer(&fd_timeout);
> -	if (drive < 0 || drive > N_DRIVE) {
> +	if (drive < 0 || drive > N_DRIVE-1) {
>  		fd_timeout.expires = jiffies + 20UL * HZ;

Looks ok, although the idiom is "drive >= N_DRIVE".

-- Pete
