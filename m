Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbTIKURO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 16:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbTIKURO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 16:17:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30402 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261500AbTIKURK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 16:17:10 -0400
Message-ID: <3F60D83A.9060506@pobox.com>
Date: Thu, 11 Sep 2003 16:16:58 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
CC: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 (6/7): network drivers.
References: <20030911171747.GG5637@mschwid3.boeblingen.de.ibm.com>
In-Reply-To: <20030911171747.GG5637@mschwid3.boeblingen.de.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schwidefsky wrote:

> -	spin_lock_init(&card->wait_q_lock);
> +	/* setup net_device stuff */
> +	card->dev->priv = card;
> +
> +	strncpy(card->dev->name, card->dev_name, IFNAMSIZ);

what's this about?  Why avoid the net stack's dev->name assignment?



> +	QETH_DBF_TEXT3(0, trace, "alloccrd");
> +	card = (struct qeth_card *) vmalloc(sizeof (struct qeth_card));
> +	if (!card)
> +		return NULL;

Is the card's private info really so large that you need vmalloc() ?

Most of the patch looks ok to me, except for these minor niggles.

	Jeff





