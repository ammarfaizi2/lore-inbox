Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbTILIqG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 04:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbTILIqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 04:46:06 -0400
Received: from d12lmsgate-2.de.ibm.com ([194.196.100.235]:5248 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S261296AbTILIqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 04:46:04 -0400
Subject: Re: [PATCH] s390 (6/7): network drivers.
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
X-Mailer: Lotus Notes Release 5.0.12   February 13, 2003
Message-ID: <OFDC922B9A.0B98E8E8-ONC1256D9F.002F35CF-C1256D9F.00301854@de.ibm.com>
From: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date: Fri, 12 Sep 2003 10:45:19 +0200
X-MIMETrack: Serialize by Router on D12ML016/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 12/09/2003 10:45:53
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Jeff,

> > -        spin_lock_init(&card->wait_q_lock);
> > +        /* setup net_device stuff */
> > +        card->dev->priv = card;
> > +
> > +        strncpy(card->dev->name, card->dev_name, IFNAMSIZ);
>
> what's this about?  Why avoid the net stack's dev->name assignment?
This is indeed strange, because in qeth_init_netdev the name is copied
from the net_device to the card structure. Seems like the card->dev_name
is superflous. I'll ask our networking guys.


> > +        QETH_DBF_TEXT3(0, trace, "alloccrd");
> > +        card = (struct qeth_card *) vmalloc(sizeof (struct qeth_card));
> > +        if (!card)
> > +                    return NULL;
>
> Is the card's private info really so large that you need vmalloc() ?
For 31 bit struct qeth_card has 55808 bytes for 64 bit 64256. We could
allocate it with kmalloc but overall the qeth driver allocates a LOT of
memory with vmalloc. The inbound/outbound queues are quite big and the
qeth_card structure is almost neglectable...

blue skies,
   Martin


