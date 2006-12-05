Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937495AbWLEKcq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937495AbWLEKcq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 05:32:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937450AbWLEKcp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 05:32:45 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:44991 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937423AbWLEKco (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 05:32:44 -0500
Date: Tue, 5 Dec 2006 10:32:39 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Ivo van Doorn <ivdoorn@gmail.com>
Cc: Dmitry Torokhov <dtor@insightbb.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, John Linville <linville@tuxdriver.com>,
       Jiri Benc <jbenc@suse.cz>, Lennart Poettering <lennart@poettering.net>,
       Johannes Berg <johannes@sipsolutions.net>,
       Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [RFC] rfkill - Add support for input key to control wireless radio
Message-ID: <20061205103239.GA10312@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ivo van Doorn <ivdoorn@gmail.com>,
	Dmitry Torokhov <dtor@insightbb.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, John Linville <linville@tuxdriver.com>,
	Jiri Benc <jbenc@suse.cz>,
	Lennart Poettering <lennart@poettering.net>,
	Johannes Berg <johannes@sipsolutions.net>,
	Larry Finger <Larry.Finger@lwfinger.net>
References: <200612031936.34343.IvDoorn@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612031936.34343.IvDoorn@gmail.com>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +/*
> + * Function called by the key driver when the rfkill structure
> + * needs to be registered.
> + */
> +int rfkill_register_key(struct rfkill *rfkill, int init_status)
> +{
> +	struct rfkill_type *type = &master->type[rfkill->key_type];
> +	struct rfkill_key *key;
> +	int status;
> +
> +	if (!rfkill)
> +		return -EINVAL;	
> +
> +	if (rfkill->key_type >= KEY_TYPE_MAX)
> +		return -EINVAL;
> +
> +	/*
> +	 * Increase module use count to prevent this
> +	 * module to be unloaded while there are still
> +	 * registered keys.
> +	 */
> +	if (!try_module_get(THIS_MODULE))
> +		return -EBUSY;

This is obviously broken.  Please add a "struct module *owner;"
field to struct rfkill instead.

