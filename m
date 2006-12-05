Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031561AbWLEVVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031561AbWLEVVM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 16:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031560AbWLEVVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 16:21:12 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:63026 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031549AbWLEVVK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 16:21:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:from;
        b=ZgCrMsteGI7x0DKvPI9LDTqXYQBb5oMYhoWBcoUbT1ocJeUYCI1elksWblhozf9KIujIWIgDnFj/+t2yeFk9J7vHOgRLiU2WEILsslzD6pagmOe2hyYLuOQ4J+sQ60O5KnT6WUCr3A8NGHOhY4LPiMSvhhBAfyowIcYJHkHe+B0=
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC] rfkill - Add support for input key to control wireless radio
Date: Tue, 5 Dec 2006 22:21:06 +0100
User-Agent: KMail/1.9.5
Cc: Dmitry Torokhov <dtor@insightbb.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, John Linville <linville@tuxdriver.com>,
       Jiri Benc <jbenc@suse.cz>, Lennart Poettering <lennart@poettering.net>,
       Johannes Berg <johannes@sipsolutions.net>,
       Larry Finger <Larry.Finger@lwfinger.net>
References: <200612031936.34343.IvDoorn@gmail.com> <20061205103239.GA10312@infradead.org>
In-Reply-To: <20061205103239.GA10312@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612052221.07229.IvDoorn@gmail.com>
From: Ivo van Doorn <ivdoorn@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 December 2006 11:32, Christoph Hellwig wrote:
> > +/*
> > + * Function called by the key driver when the rfkill structure
> > + * needs to be registered.
> > + */
> > +int rfkill_register_key(struct rfkill *rfkill, int init_status)
> > +{
> > +	struct rfkill_type *type = &master->type[rfkill->key_type];
> > +	struct rfkill_key *key;
> > +	int status;
> > +
> > +	if (!rfkill)
> > +		return -EINVAL;	
> > +
> > +	if (rfkill->key_type >= KEY_TYPE_MAX)
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * Increase module use count to prevent this
> > +	 * module to be unloaded while there are still
> > +	 * registered keys.
> > +	 */
> > +	if (!try_module_get(THIS_MODULE))
> > +		return -EBUSY;
> 
> This is obviously broken.  Please add a "struct module *owner;"
> field to struct rfkill instead.

Thanks, will fix this asap.

Ivo
