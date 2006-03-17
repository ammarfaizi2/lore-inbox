Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752518AbWCQF4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752518AbWCQF4M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 00:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752494AbWCQF4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 00:56:12 -0500
Received: from smtp.osdl.org ([65.172.181.4]:56516 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751425AbWCQF4L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 00:56:11 -0500
Date: Thu, 16 Mar 2006 21:53:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: NeilBrown <neilb@suse.de>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 005 of 13] md: Allow stripes to be expanded in
 preparation for expanding an array.
Message-Id: <20060316215323.0ae5c7bb.akpm@osdl.org>
In-Reply-To: <1060317044745.16072@suse.de>
References: <20060317154017.15880.patches@notabene>
	<1060317044745.16072@suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NeilBrown <neilb@suse.de> wrote:
>
> +		wait_event_lock_irq(conf->wait_for_stripe,
>  +				    !list_empty(&conf->inactive_list),
>  +				    conf->device_lock,
>  +				    unplug_slaves(conf->mddev);
>  +			);

Boy, that's an ugly-looking thing, isn't it?

__wait_event_lock_irq() already puts a semicolon after `cmd' so I think the
one here isn't needed, which would make it a bit less of a surprise to look
at.

