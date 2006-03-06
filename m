Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751676AbWCFTwu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751676AbWCFTwu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 14:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752413AbWCFTwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 14:52:50 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:27833
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751676AbWCFTwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 14:52:49 -0500
Date: Mon, 6 Mar 2006 11:52:51 -0800
From: Greg KH <greg@kroah.com>
To: Dave Peterson <dsp@llnl.gov>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org, alan@redhat.com, gregkh@kroah.com
Subject: Re: [PATCH] EDAC: core EDAC support code
Message-ID: <20060306195251.GA8777@kroah.com>
References: <200601190414.k0J4EZCV021775@hera.kernel.org> <1141553885.16388.0.camel@laptopd505.fenrus.org> <1141554625.16388.2.camel@laptopd505.fenrus.org> <200603061014.22312.dsp@llnl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603061014.22312.dsp@llnl.gov>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2006 at 10:14:22AM -0800, Dave Peterson wrote:
> On Sunday 05 March 2006 02:30, Arjan van de Ven wrote:
> > On Sun, 2006-03-05 at 11:18 +0100, Arjan van de Ven wrote:
> > > > +/* Main MC kobject release() function */
> > > > +static void edac_memctrl_master_release(struct kobject *kobj)
> > > > +{
> > > > +	debugf1("EDAC MC: " __FILE__ ": %s()\n", __func__);
> > > > +}
> > > > +
> > >
> > > ehhh how on earth can this be right?
> >
> > oh and this stuff also violates the "one value per file" rule; can we
> > fix that urgently before it becomes part of the ABI in 2.6.16??
> 
> Ok, I'll admit to being a bit clueless about this.  I'm not familiar
> with the "one value per file" rule; can someone please explain?

sysfs consists of files that only have one value per file.  Please do
not do otherwise, as it will become a maintance nightmare over time.
See the documentation file that Randy pointed you at for details.

> On Sunday 05 March 2006 07:55, Greg KH wrote:
> > Ugh.  Good catch, it isn't right.  Gotta love it when people try to
> > ignore the helpful messages the kernel gives you when you use an API
> > wrong :(
> 
> Hmm... I don't recall seeing any messages from the kernel.  What
> are you seeing?

If you do not have a release function, you will see the messages.  Just
putting a printk() in a release function is not acceptable, you really
need to free the memory from it.  If not, then your code is really
wrong...

thanks,

greg k-h
