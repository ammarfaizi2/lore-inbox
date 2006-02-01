Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751276AbWBAHHl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbWBAHHl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 02:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWBAHHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 02:07:41 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:14553 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1751276AbWBAHHk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 02:07:40 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: + update-mm-acx-driver-to-version-0331.patch added to -mm tree
Date: Wed, 1 Feb 2006 09:07:00 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <200602010211.k112BVps013714@shell0.pdx.osdl.net> <1138771694.5123.3.camel@laptopd505.fenrus.org>
In-Reply-To: <1138771694.5123.3.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602010907.00368.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 February 2006 07:28, Arjan van de Ven wrote:
> 
> > -struct wlandevice {
> > +struct acx_device {
> > +	/* most frequent accesses first (dereferencing and cache line!) */
> > +
> > +	/*** Locking ***/
> > +	struct semaphore	sem;
> > +	spinlock_t		lock;
> > +#if defined(PARANOID_LOCKING) /* Lock debugging */
> > +	const char		*last_sem;
> > +	const char		*last_lock;
> > +	unsigned long		sem_time;
> > +	unsigned long		lock_time;
> > +#endif
> > +
> 
> any chance of turning this into a mutex instead?
> (and you get some of the debugging for free instead that way)

(/me is reading Ingo's docs...)

Nice :)

Yes, we will do the conversion later. For now we want our driver
usable on vanilla 2.6.10.
--
vda
