Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031544AbWLEVU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031544AbWLEVU4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 16:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031531AbWLEVUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 16:20:55 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:63127 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031543AbWLEVUy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 16:20:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:from;
        b=FdHW8IdzzBwPrEq7i/yt4adkIlz47jCTr76U4wFm+g+bTbn6u35MNrTGcFf/V6nP8HtXcCEVfnZGRoUXQPfyOfQjTYh0Bqw6x05m2HxTen7e2ks7FEFWP9iL2Zu19AzuukjoB0mmBuA18DQehQWEpug+uCR+gfqdzjsVS7UQ/fQ=
To: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [RFC] rfkill - Add support for input key to control wireless radio
Date: Tue, 5 Dec 2006 22:20:47 +0100
User-Agent: KMail/1.9.5
Cc: Arjan van de Ven <arjan@infradead.org>,
       Dmitry Torokhov <dtor@insightbb.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, John Linville <linville@tuxdriver.com>,
       Jiri Benc <jbenc@suse.cz>, Lennart Poettering <lennart@poettering.net>,
       Johannes Berg <johannes@sipsolutions.net>,
       Larry Finger <Larry.Finger@lwfinger.net>
References: <200612031936.34343.IvDoorn@gmail.com> <200612032328.12093.IvDoorn@gmail.com> <20061204161842.a8673e6e.randy.dunlap@oracle.com>
In-Reply-To: <20061204161842.a8673e6e.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612052220.47816.IvDoorn@gmail.com>
From: Ivo van Doorn <ivdoorn@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[snip]
 
> > +/*
> > + * Function called by the key driver to report the new status
> > + * of the key.
> > + */
> > +void rfkill_report_event(struct rfkill *rfkill, int new_status)
> > +{
> > +	mutex_lock(&master->mutex);
> > +
> > +	if (rfkill_check_key(rfkill->key, new_status))
> > +		schedule_work(&master->toggle_work);
> > +
> > +	mutex_unlock(&master->mutex);
> > +}
> > +EXPORT_SYMBOL_GPL(rfkill_report_event);
> 
> Please use kernel-doc notation for non-static functions.
> See Documentation/kernel-doc-nano-HOWTO.txt for more info.

All kernel-doc notations were placed in the rfkill.h header.
I'll move them to the rfkill.c file.


[snip]

> > + * @rfkill: rfkill structure to be deregistered
> > + * @init_status: initial status of the key at the time this function is called
> > + *
> > + * This function should be called by the key driver when the rfkill structure
> > + * needs to be registered. Immediately from registration the key driver
> > + * should be able to receive calls through the poll, enable_radio and
> > + * disable_radio handlers if those were registered.
> > + */
> > +int rfkill_register_key(struct rfkill *rfkill, int init_status);
> > +
> > +/**
> > + * rfkill_deregister_key - Deregister a previously registered rfkill structre.
> 
> "structure"

Thanks for the pointers. I'll fix them asap.

Ivo
