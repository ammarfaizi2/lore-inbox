Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932221AbWCFSxZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbWCFSxZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 13:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbWCFSxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 13:53:25 -0500
Received: from smtp-4.llnl.gov ([128.115.41.84]:13774 "EHLO smtp-4.llnl.gov")
	by vger.kernel.org with ESMTP id S932221AbWCFSxY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 13:53:24 -0500
From: Dave Peterson <dsp@llnl.gov>
To: Greg KH <greg@kroah.com>, Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] EDAC: core EDAC support code
Date: Mon, 6 Mar 2006 10:52:57 -0800
User-Agent: KMail/1.5.3
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200601190414.k0J4EZCV021775@hera.kernel.org> <1141553885.16388.0.camel@laptopd505.fenrus.org> <20060305155503.GA18580@kroah.com>
In-Reply-To: <20060305155503.GA18580@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603061052.57188.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 05 March 2006 07:55, Greg KH wrote:
> On Sun, Mar 05, 2006 at 11:18:04AM +0100, Arjan van de Ven wrote:
> > > +/* Main MC kobject release() function */
> > > +static void edac_memctrl_master_release(struct kobject *kobj)
> > > +{
> > > +	debugf1("EDAC MC: " __FILE__ ": %s()\n", __func__);
> > > +}
> > > +
> >
> > ehhh how on earth can this be right?
>
> Ugh.  Good catch, it isn't right.  Gotta love it when people try to
> ignore the helpful messages the kernel gives you when you use an API
> wrong :(

Is the concern here that EDAC is not waiting for the reference count
on the kobject to reach 0, therefore creating the possibility of the
module unloading while the kobject (declared statically within the
module) is still in use?
