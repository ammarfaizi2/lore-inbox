Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932466AbVKGJU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932466AbVKGJU1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 04:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932467AbVKGJU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 04:20:27 -0500
Received: from mail.dvmed.net ([216.237.124.58]:34253 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932466AbVKGJU1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 04:20:27 -0500
Message-ID: <436F1C57.7080900@pobox.com>
Date: Mon, 07 Nov 2005 04:20:23 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: akpm@osdl.org
Subject: Re: [PATCH] move pm_register/etc. to CONFIG_PM_LEGACY, pm_legacy.h
References: <20051107091313.GA15128@havoc.gtf.org>
In-Reply-To: <20051107091313.GA15128@havoc.gtf.org>
Content-Type: multipart/mixed;
 boundary="------------000407060005040109030200"
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000407060005040109030200
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jeff Garzik wrote:
> Since few people need the support anymore, this moves the legacy
> pm_xxx functions to CONFIG_PM_LEGACY, and include/linux/pm_legacy.h.

Whoops.  You'll need include/linux/pm_legacy.h too (attached).

	Jeff



--------------000407060005040109030200
Content-Type: text/plain;
 name="pm_legacy.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pm_legacy.h"

#ifndef __LINUX_PM_LEGACY_H__
#define __LINUX_PM_LEGACY_H__

#include <linux/config.h>

#ifdef CONFIG_PM_LEGACY

extern int pm_active;

#define PM_IS_ACTIVE() (pm_active != 0)

/*
 * Register a device with power management
 */
struct pm_dev __deprecated *
pm_register(pm_dev_t type, unsigned long id, pm_callback callback);

/*
 * Unregister a device with power management
 */
void __deprecated pm_unregister(struct pm_dev *dev);

/*
 * Unregister all devices with matching callback
 */
void __deprecated pm_unregister_all(pm_callback callback);

/*
 * Send a request to all devices
 */
int __deprecated pm_send_all(pm_request_t rqst, void *data);

#else /* CONFIG_PM_LEGACY */

#define PM_IS_ACTIVE() 0

static inline struct pm_dev *pm_register(pm_dev_t type,
					 unsigned long id,
					 pm_callback callback)
{
	return NULL;
}

static inline void pm_unregister(struct pm_dev *dev) {}

static inline void pm_unregister_all(pm_callback callback) {}

static inline int pm_send_all(pm_request_t rqst, void *data)
{
	return 0;
}

#endif /* CONFIG_PM_LEGACY */

#endif /* __LINUX_PM_LEGACY_H__ */

--------------000407060005040109030200--
