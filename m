Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbVBJTJO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbVBJTJO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 14:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261342AbVBJTJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 14:09:13 -0500
Received: from mx1.redhat.com ([66.187.233.31]:32735 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261349AbVBJTHu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 14:07:50 -0500
Date: Thu, 10 Feb 2005 11:07:46 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix ALPS sync loss
Message-ID: <20050210110746.1c779ffd@localhost.localdomain>
In-Reply-To: <mailman.1107906420.26313.linux-kernel2news@redhat.com>
References: <mailman.1107906420.26313.linux-kernel2news@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.14; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Feb 2005 18:40:12 -0500, Dmitry Torokhov <dtor_core@ameritech.net> wrote:

> Here is the promised patch. It turns out protocol validation code was
> a bit (or rather a byte ;) ) off.

> +++ b/drivers/input/mouse/alps.c	2005-02-08 18:16:27 -05:00
> @@ -198,8 +198,8 @@
>  		return PSMOUSE_BAD_DATA;
>  
>  	/* Bytes 2 - 6 should have 0 in the highest bit */
> -	if (psmouse->pktcnt > 1 && psmouse->pktcnt <= 6 &&
> -	    (psmouse->packet[psmouse->pktcnt] & 0x80))
> +	if (psmouse->pktcnt >= 2 && psmouse->pktcnt <= 6 &&
> +	    (psmouse->packet[psmouse->pktcnt - 1] & 0x80))
>  		return PSMOUSE_BAD_DATA;

This seems to work here, no more dead pad.

-- Pete
