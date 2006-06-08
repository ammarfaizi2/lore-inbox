Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964789AbWFHH6L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964789AbWFHH6L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 03:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964793AbWFHH6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 03:58:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6831 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964789AbWFHH6J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 03:58:09 -0400
Date: Thu, 8 Jun 2006 00:54:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: Steve Wise <swise@opengridcomputing.com>
Cc: rdreier@cisco.com, mshefty@ichips.intel.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH v2 1/2] iWARP Connection Manager.
Message-Id: <20060608005452.087b34db.akpm@osdl.org>
In-Reply-To: <20060607200605.9003.25830.stgit@stevo-desktop>
References: <20060607200600.9003.56328.stgit@stevo-desktop>
	<20060607200605.9003.25830.stgit@stevo-desktop>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Jun 2006 15:06:05 -0500
Steve Wise <swise@opengridcomputing.com> wrote:

> 
> This patch provides the new files implementing the iWARP Connection
> Manager.
> 
> Review Changes:
> 
> - sizeof -> sizeof()
> 
> - removed printks
> 
> - removed TT debug code
> 
> - cleaned up lock/unlock around switch statements.
> 
> - waitqueue -> completion for destroy path.
>
> ...
>
> +/* 
> + * This function is called on interrupt context. Schedule events on
> + * the iwcm_wq thread to allow callback functions to downcall into
> + * the CM and/or block.  Events are queued to a per-CM_ID
> + * work_list. If this is the first event on the work_list, the work
> + * element is also queued on the iwcm_wq thread.
> + *
> + * Each event holds a reference on the cm_id. Until the last posted
> + * event has been delivered and processed, the cm_id cannot be
> + * deleted. 
> + */
> +static void cm_event_handler(struct iw_cm_id *cm_id,
> +			     struct iw_cm_event *iw_event) 
> +{
> +	struct iwcm_work *work;
> +	struct iwcm_id_private *cm_id_priv;
> +	unsigned long flags;
> +
> +	work = kmalloc(sizeof(*work), GFP_ATOMIC);
> +	if (!work)
> +		return;

This allocation _will_ fail sometimes.  The driver must recover from it. 
Will it do so?

> +EXPORT_SYMBOL(iw_cm_init_qp_attr);

This file exports a ton of symbols.  It's usual to provide some justifying
commentary in the changelog when this happens.

> +/*
> + * Copyright (c) 2005 Network Appliance, Inc. All rights reserved.
> + * Copyright (c) 2005 Open Grid Computing, Inc. All rights reserved.
> + *
> + * This software is available to you under a choice of one of two
> + * licenses.  You may choose to be licensed under the terms of the GNU
> + * General Public License (GPL) Version 2, available from the file
> + * COPYING in the main directory of this source tree, or the
> + * OpenIB.org BSD license below:
> + *
> + *     Redistribution and use in source and binary forms, with or
> + *     without modification, are permitted provided that the following
> + *     conditions are met:
> + *
> + *      - Redistributions of source code must retain the above
> + *        copyright notice, this list of conditions and the following
> + *        disclaimer.
> + *
> + *      - Redistributions in binary form must reproduce the above
> + *        copyright notice, this list of conditions and the following
> + *        disclaimer in the documentation and/or other materials
> + *        provided with the distribution.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> + * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> + * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
> + * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
> + * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
> + * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
> + * SOFTWARE.
> + */
> +#if !defined(IW_CM_PRIVATE_H)
> +#define IW_CM_PRIVATE_H

We normally use #ifndef here.


