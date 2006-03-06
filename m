Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752415AbWCFTxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752415AbWCFTxo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 14:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752419AbWCFTxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 14:53:44 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:29625
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1752415AbWCFTxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 14:53:42 -0500
Date: Mon, 6 Mar 2006 11:53:48 -0800
From: Greg KH <greg@kroah.com>
To: Dave Peterson <dsp@llnl.gov>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] EDAC: core EDAC support code
Message-ID: <20060306195348.GB8777@kroah.com>
References: <200601190414.k0J4EZCV021775@hera.kernel.org> <1141553885.16388.0.camel@laptopd505.fenrus.org> <20060305155503.GA18580@kroah.com> <200603061052.57188.dsp@llnl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603061052.57188.dsp@llnl.gov>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2006 at 10:52:57AM -0800, Dave Peterson wrote:
> On Sunday 05 March 2006 07:55, Greg KH wrote:
> > On Sun, Mar 05, 2006 at 11:18:04AM +0100, Arjan van de Ven wrote:
> > > > +/* Main MC kobject release() function */
> > > > +static void edac_memctrl_master_release(struct kobject *kobj)
> > > > +{
> > > > +	debugf1("EDAC MC: " __FILE__ ": %s()\n", __func__);
> > > > +}
> > > > +
> > >
> > > ehhh how on earth can this be right?
> >
> > Ugh.  Good catch, it isn't right.  Gotta love it when people try to
> > ignore the helpful messages the kernel gives you when you use an API
> > wrong :(
> 
> Is the concern here that EDAC is not waiting for the reference count
> on the kobject to reach 0, therefore creating the possibility of the
> module unloading while the kobject (declared statically within the
> module) is still in use?

Eeek, don't statically create a kobject :(

Anyway, yes, that is a problem, if it is static, then you need to know
it is safe to unload.  Even if it is dynamic that is also true...

thanks,

greg k-h
