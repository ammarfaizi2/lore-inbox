Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262954AbVBCQLP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262954AbVBCQLP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 11:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263474AbVBCQLO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 11:11:14 -0500
Received: from fw-us-hou19.bmc.com ([198.207.223.240]:15680 "EHLO
	creeper.bmc.com") by vger.kernel.org with ESMTP id S263327AbVBCQHZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 11:07:25 -0500
Message-ID: <1107446835.7087.8.camel@levlinux.boston.bmc.com>
From: "Makhlis, Lev" <Lev_Makhlis@bmc.com>
To: nacc@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 19/34]: include/jiffies: add usecs_to_jiffies() functi
	on
Date: Thu, 3 Feb 2005 10:07:15 -0600 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nishanth Aravamudan <nacc@us.ibm.com> wrote:

> +static inline unsigned long usecs_to_jiffies(const unsigned int u)
> +{
> +	if (u > jiffies_to_usecs(MAX_JIFFY_OFFSET))
> +		return MAX_JIFFY_OFFSET;
> +#if HZ <= 1000 && !(1000 % HZ)
> +	return (u + (1000000 / HZ) - 1000) / (1000000 / HZ);
> +#elif HZ > 1000 && !(HZ % 1000)
> +	return u * (HZ / 1000000);
> +#else
> +	return (u * HZ + 999999) / 1000000;
> +#endif
> +}

Shouldn't this use 1000000 instead of 1000 everywhere?
It returns 0 if HZ=10000.
