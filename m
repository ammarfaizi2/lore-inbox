Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262337AbUFBHtS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262337AbUFBHtS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 03:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265136AbUFBHtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 03:49:18 -0400
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:44987 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262337AbUFBHtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 03:49:12 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC/RFT] Raw access to serio ports (1/2)
Date: Wed, 2 Jun 2004 02:49:07 -0500
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, bilotta78@hotpop.com,
       danlee@informatik.uni-freiburg.de, vojtech@suse.cz, tuukkat@ee.oulu.fi
References: <200406020218.42979.dtor_core@ameritech.net> <20040602003626.4d754944.akpm@osdl.org> <200406020243.09560.dtor_core@ameritech.net>
In-Reply-To: <200406020243.09560.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406020249.07651.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 June 2004 02:43 am, Dmitry Torokhov wrote:
> On Wednesday 02 June 2004 02:36 am, Andrew Morton wrote:
> > Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> > >
> > > Hi,
> > > 
> > > Below is an implementation of rawdev driver.
> > 
> > Yes, it does appear that we need the feature, thanks.
> > 
> > > Comments?
> > 
> > They're the thingies inside /* and */.  Your patch is refreshingly free of
> > them ;)
> > 
> > > +static ssize_t rawdev_write(struct file *file, const char *buffer, size_t count, loff_t *ppos)
> > > +{
> > > +	struct rawdev_list *list = file->private_data;
> > > +	ssize_t written = 0;
> > > +	int retval;
> > > +	unsigned char c;
> > > +
> > > +	retval = down_interruptible(&rawdev_sem);
> > > +	if (retval)
> > > +		return retval;
> > > +
> > > +	if (!list->rawdev->serio) {
> > > +		retval = -ENODEV;
> > > +		goto out;
> > > +	}
> > 
> > The return values here are mucked up - this function returns `written'.
> 
> Or an error code in negative notation - it's the standard practice for
> read/write. Am I missing something?
> 
Oh, yes, I am... Sorry, will fix tomorrow.

-- 
Dmitry
