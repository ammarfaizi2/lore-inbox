Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264542AbUD2Nz0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264542AbUD2Nz0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 09:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264546AbUD2Nz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 09:55:26 -0400
Received: from gonzo.one-2-one.net ([217.115.142.69]:4794 "EHLO
	gonzo.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S264542AbUD2NzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 09:55:18 -0400
Envelope-to: linux-kernel@vger.kernel.org
Date: Thu, 29 Apr 2004 15:55:00 +0200
From: stefan.eletzhofer@eletztrick.de
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>,
       Ian Campbell <icampbell@arcom.com>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH] 2.6 I2C epson 8564 RTC chip
Message-ID: <20040429135500.GA23468@gonzo.local>
Reply-To: stefan.eletzhofer@eletztrick.de
Mail-Followup-To: stefan.eletzhofer@eletztrick.de,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Ian Campbell <icampbell@arcom.com>, Greg KH <greg@kroah.com>
References: <20040429120250.GD10867@gonzo.local> <1083243580.26762.38.camel@icampbell-debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1083243580.26762.38.camel@icampbell-debian>
User-Agent: Mutt/1.3.27i
Organization: Eletztrick Computing
X-HE-MXrcvd: no
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2004 at 01:59:40PM +0100, Ian Campbell wrote:
> On Thu, 2004-04-29 at 13:02, stefan.eletzhofer@eletztrick.de wrote:
> > This driver only does the low-level I2C stuff, the rtc misc device
> > driver is a separate driver module which I will send a patch for soon.
> 
> By the way -- I notice you have said you need i2c_get_client for your
> RTC driver to locate the i2c chip it wants to work with. 

Correct. I'll send a patch which re-adds this call to 2.6.6-rcx.

> 
> Just a thought -- perhaps it would make sense to reverse the roles and
> for the rtc driver to export a 'register_rtc_device' type call which the
> specific i2c chip driver could then call to hook itself up to /dev/rtc

The problem with this approach is IHMO that you need the i2c_client struct in
I2C chrip driver as well (to call the i2c access primitives). You'd need to
store the pointer to the client somewhere in the driver itself. What if we have
more than one client per driver?

IMHO the call i2c_get_client() is nice and clean. One could wish another call like
  int i2c_command( struct i2c_client *c, long cmd, void *arg );
whcih does a
  client->driver->command( client, cmd, arg );
internally.

> 
> Ian.
> 
> -- 
> Ian Campbell, Senior Design Engineer
>                                         Web: http://www.arcom.com
> Arcom, Clifton Road, 			Direct: +44 (0)1223 403 465
> Cambridge CB1 7EA, United Kingdom	Phone:  +44 (0)1223 411 200
> 
> 
> _____________________________________________________________________
> The message in this transmission is sent in confidence for the attention of the addressee only and should not be disclosed to any other party. Unauthorised recipients are requested to preserve this confidentiality. Please advise the sender if the addressee is not resident at the receiving end.  Email to and from Arcom is automatically monitored for operational and lawful business reasons.
> 
> This message has been virus scanned by MessageLabs.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Eletztrick Computing - Customized Linux Development
Stefan Eletzhofer, Marktstrasse 43, DE-88214 Ravensburg
http://www.eletztrick.de
