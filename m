Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932421AbWE3TFE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421AbWE3TFE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 15:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932395AbWE3TFE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 15:05:04 -0400
Received: from smtp1.xs4all.be ([195.144.64.135]:61165 "EHLO smtp1.xs4all.be")
	by vger.kernel.org with ESMTP id S932421AbWE3TFC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 15:05:02 -0400
Date: Tue, 30 May 2006 21:04:24 +0200
From: Frank Gevaerts <frank.gevaerts@fks.be>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Frank Gevaerts <frank.gevaerts@fks.be>, lcapitulino@mandriva.com.br,
       linux-kernel@vger.kernel.org, gregkh@suse.de,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: usb-serial ipaq kernel problem
Message-ID: <20060530190424.GA1010@fks.be>
References: <20060529141110.6d149e21@doriath.conectiva> <20060529194334.GA32440@fks.be> <20060529172410.63dffa72@doriath.conectiva> <20060529204724.GA22250@fks.be> <20060529193330.3c51f3ba@home.brethil> <20060530082141.GA26517@fks.be> <20060530113801.22c71afe@doriath.conectiva> <20060530115329.30184aa0@doriath.conectiva> <20060530174821.GA15969@fks.be> <20060530113327.297aceb7.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060530113327.297aceb7.zaitcev@redhat.com>
User-Agent: Mutt/1.5.9i
X-FKS-MailScanner: Found to be clean
X-FKS-MailScanner-SpamCheck: geen spam, SpamAssassin (score=-105.815,
	vereist 5, autolearn=not spam, ALL_TRUSTED -3.30, AWL 0.08,
	BAYES_00 -2.60, USER_IN_WHITELIST -100.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2006 at 11:33:27AM -0700, Pete Zaitcev wrote:
> On Tue, 30 May 2006 19:48:21 +0200, Frank Gevaerts <frank.gevaerts@fks.be> wrote:
> +0100
> > +++ linux-2.6.17-rc4.test/drivers/usb/serial/ipaq.c	2006-05-30 19:41:19.000000000 +0200
> > @@ -692,6 +694,7 @@ static void ipaq_close(struct usb_serial
> >  	struct ipaq_private	*priv = usb_get_serial_port_data(port);
> >  
> >  	dbg("%s - port %d", __FUNCTION__, port->number);
> > +
> >  			 
> >  	/*
> >  	 * shut down bulk read and write
> 
> Please get rid of the above.

OK. I missed one while cleaning up.

> > @@ -967,3 +971,6 @@ MODULE_PARM_DESC(vendor, "User specified
> >  
> >  module_param(product, ushort, 0);
> >  MODULE_PARM_DESC(product, "User specified USB idProduct");
> > +
> > +module_param(connect_retries, int, KP_RETRIES);
> > +MODULE_PARM_DESC(product, "Maximum number of connect retries (100ms each)");
> 
> Personally, I'm not keen on adding knobs.

As far as I can see, the alternatives are that either it does not work
without patches for scenarios where the ipaq is rebooted while connected
(like we do), since these need a large number of retries (up to 3500 in
our tests today, about 6 minutes), or the default value is much higher
than the current 100 (which gives a 10 seconds timeout).

I'm not sure what the best solution is.

Frank

> 
> -- Pete

-- 
Frank Gevaerts                                 frank.gevaerts@fks.be
fks bvba - Formal and Knowledge Systems        http://www.fks.be/
Stationsstraat 108                             Tel:  ++32-(0)11-21 49 11
B-3570 ALKEN                                   Fax:  ++32-(0)11-22 04 19
