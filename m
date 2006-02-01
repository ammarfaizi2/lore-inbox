Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030397AbWBAF2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030397AbWBAF2S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 00:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030388AbWBAF2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 00:28:18 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:40411 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030397AbWBAF2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 00:28:17 -0500
Subject: Re: + update-mm-acx-driver-to-version-0331.patch added to -mm tree
From: Arjan van de Ven <arjan@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: vda@ilport.com.ua, akpm@osdl.org
In-Reply-To: <200602010211.k112BVps013714@shell0.pdx.osdl.net>
References: <200602010211.k112BVps013714@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Wed, 01 Feb 2006 06:28:13 +0100
Message-Id: <1138771694.5123.3.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> -struct wlandevice {
> +struct acx_device {
> +	/* most frequent accesses first (dereferencing and cache line!) */
> +
> +	/*** Locking ***/
> +	struct semaphore	sem;
> +	spinlock_t		lock;
> +#if defined(PARANOID_LOCKING) /* Lock debugging */
> +	const char		*last_sem;
> +	const char		*last_lock;
> +	unsigned long		sem_time;
> +	unsigned long		lock_time;
> +#endif
> +

any chance of turning this into a mutex instead?
(and you get some of the debugging for free instead that way)

