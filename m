Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964848AbVHIQIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964848AbVHIQIM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 12:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964849AbVHIQIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 12:08:12 -0400
Received: from mail-red.bigfish.com ([216.148.222.61]:41321 "EHLO
	mail24-red-R.bigfish.com") by vger.kernel.org with ESMTP
	id S964848AbVHIQIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 12:08:10 -0400
X-BigFish: V
Message-ID: <42F8D4C5.2090800@am.sony.com>
Date: Tue, 09 Aug 2005 09:07:33 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Todd Poynor <tpoynor@mvista.com>
CC: linux-kernel@vger.kernel.org, linux-pm@lists.osdl.org,
       cpufreq@lists.linux.org.uk
Subject: Re: [linux-pm] PowerOP 1/3: PowerOP core
References: <20050809025157.GB25064@slurryseal.ddns.mvista.com>
In-Reply-To: <20050809025157.GB25064@slurryseal.ddns.mvista.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Todd Poynor wrote:
...
> ===================================================================
> --- linux-2.6.12.orig/include/linux/powerop.h	1970-01-01
> 00:00:00.000000000 +0000
> +++ linux-2.6.12/include/linux/powerop.h	2005-08-03
> 01:10:55.000000000 +0000
> @@ -0,0 +1,36 @@
> +/*
> + * PowerOP core definitions
> + *
> + * Author: Todd Poynor <tpoynor@mvista.com>
> + *
> + * 2005 (c) MontaVista Software, Inc. This file is licensed under
> + * the terms of the GNU General Public License version 2. This program
> + * is licensed "as is" without any warranty of any kind, whether
> express
> + * or implied.
> + */
> +
> +#ifndef __POWEROP_H__
> +#define __POWEROP_H__
> +
> +#include <linux/kobject.h>
> +#include <asm/powerop.h>
> +
> +struct powerop_point {
> +	int param[POWEROP_DRIVER_MAX_PARAMS];
> +};

I'm wondering if anything could be gained by having the whole 
struct powerop_point defined in asm/powerop.h, and treat it as an 
opaque structure at this level.  That way, things other than just 
ints could be passed between the policy manager and the backend, 
although I guess that breaks the beauty of the simplicity and would 
complicate the sys-fs interface, etc.  I'm interested to hear your 
comments.

Another point is that a policy manager would need to poll the system 
and/or get events and then act.  Your powerop work here only provides 
a (one way) piece of the final action.  Any comments regarding a more 
general interface?

-Geoff


