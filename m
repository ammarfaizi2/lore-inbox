Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265126AbUFBHnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265126AbUFBHnQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 03:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265134AbUFBHnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 03:43:16 -0400
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:41052 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265126AbUFBHnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 03:43:12 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC/RFT] Raw access to serio ports (1/2)
Date: Wed, 2 Jun 2004 02:43:09 -0500
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, bilotta78@hotpop.com,
       danlee@informatik.uni-freiburg.de, vojtech@suse.cz, tuukkat@ee.oulu.fi
References: <200406020218.42979.dtor_core@ameritech.net> <20040602003626.4d754944.akpm@osdl.org>
In-Reply-To: <20040602003626.4d754944.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406020243.09560.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 June 2004 02:36 am, Andrew Morton wrote:
> Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> >
> > Hi,
> > 
> > Below is an implementation of rawdev driver.
> 
> Yes, it does appear that we need the feature, thanks.
> 
> > Comments?
> 
> They're the thingies inside /* and */.  Your patch is refreshingly free of
> them ;)
> 
> > +static ssize_t rawdev_write(struct file *file, const char *buffer, size_t count, loff_t *ppos)
> > +{
> > +	struct rawdev_list *list = file->private_data;
> > +	ssize_t written = 0;
> > +	int retval;
> > +	unsigned char c;
> > +
> > +	retval = down_interruptible(&rawdev_sem);
> > +	if (retval)
> > +		return retval;
> > +
> > +	if (!list->rawdev->serio) {
> > +		retval = -ENODEV;
> > +		goto out;
> > +	}
> 
> The return values here are mucked up - this function returns `written'.

Or an error code in negative notation - it's the standard practice for
read/write. Am I missing something?

> 
> > +	if (count > 32)
> > +		count = 32;
> 
> Why?  (Don't tell me - add a comment!)

I have no idea - taken from 2.4... My best guess would be it's an attempt not to
hog the device... I'll sprinkle some comments ;)

-- 
Dmitry
