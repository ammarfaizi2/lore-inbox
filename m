Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261846AbTD2VWF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 17:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261847AbTD2VWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 17:22:05 -0400
Received: from Mail1.KONTENT.De ([81.88.34.36]:1153 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S261846AbTD2VWD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 17:22:03 -0400
From: Oliver Neukum <oliver@neukum.org>
Reply-To: oliver@neukum.name
To: Greg KH <greg@kroah.com>, Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [Bluetooth] HCI USB driver update. Support for SCO over HCI USB.
Date: Tue, 29 Apr 2003 23:34:19 +0200
User-Agent: KMail/1.5
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
References: <200304290317.h3T3HOdA027579@hera.kernel.org> <5.1.0.14.2.20030429131303.10d7f330@unixmail.qualcomm.com> <20030429211550.GA8669@kroah.com>
In-Reply-To: <20030429211550.GA8669@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304292334.19447.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> +int usb_init_urb(struct urb *urb)
> +{
> +	if (!urb)
> +		return -EINVAL;
> +	memset(urb, 0, sizeof(*urb));
> +	urb->count = (atomic_t)ATOMIC_INIT(1);
> +	spin_lock_init(&urb->lock);
> +
> +	return 0;
> +}

Greg, please don't do it this way. Somebody will
try to free this urb. If the urb is part of a structure
this must not lead to a kfree. Please init it to some
insanely high dummy value in this case.

	Regards
		Oliver

