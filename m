Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbTEQEkh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 00:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbTEQEkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 00:40:37 -0400
Received: from dp.samba.org ([66.70.73.150]:51921 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261216AbTEQEkg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 00:40:36 -0400
Date: Sat, 17 May 2003 14:47:44 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg KH <greg@kroah.com>
Cc: Manuel Estrada Sainz <ranty@debian.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Simon Kelley <simon@thekelleys.org.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Downing, Thomas" <Thomas.Downing@ipc.com>, jt@hpl.hp.com,
       Pavel Roskin <proski@gnu.org>
Subject: Re: request_firmware() hotplug interface, third round.
Message-ID: <20030517044744.GC13827@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Greg KH <greg@kroah.com>, Manuel Estrada Sainz <ranty@debian.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Simon Kelley <simon@thekelleys.org.uk>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"Downing, Thomas" <Thomas.Downing@ipc.com>, jt@hpl.hp.com,
	Pavel Roskin <proski@gnu.org>
References: <20030516233751.GA2045@ranty.ddts.net> <20030516235958.GA17439@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030516235958.GA17439@kroah.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 16, 2003 at 04:59:58PM -0700, Greg Kroah-Hartman wrote:
> On Sat, May 17, 2003 at 01:37:52AM +0200, Manuel Estrada Sainz wrote:
> > > > 	- Driver calls request_firmware()
> > > 
> > > Yeah, I agree with your comment in the code, I think a struct device *
> > > should be passed here.  Or at least somewhere...
> > 
> >  To make compatibility with 2.4 kernel easier, I think that I'll add a
> >  new 'struct device *' parameter to request_firmware(). On 2.4 kernels
> >  it can be an unused 'void *'. Does that sound too ugly?
> 
> Yeah, don't use void * if you can ever help it.  As there will be two
> different versions for two different kernels, just don't have that
> paramater, or make it a char * like you have now for 2.4.  That seems to
> make sense for 2.4 where you don't have a struct device.
> 
> > > > 	- 'hotplug firmware' gets called with ACCTION=add
> > > 
> > > I don't see why you need to add a new environment variable in your
> > > firmware_class_hotplug() call.  What is the FIRMWARE variable for, if we
> > > already have a device symlink back to the device that is asking for the
> > > firmware?  Oh, you don't have that :)
> > 
> >  The same device can ask for different firmware images.
> 
> Ah, that makes more sense now.  Ok, I have no problem with it.

Given this, would it be better to make the sysfs node name depend on
which firmware we're loading - rather than "data" always.  I realise
we could just require firmware requests for a particular device
instance to be serialised, however my instinct says using different
nodes would be more robust: it will be easier to figure out what's
gone wrong if a script error or a kernel bug has resulted in
attempting to load two images at once.

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
