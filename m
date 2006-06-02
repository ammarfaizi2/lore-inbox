Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751393AbWFBNLO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbWFBNLO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 09:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbWFBNLO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 09:11:14 -0400
Received: from smtp1.xs4all.be ([195.144.64.135]:32716 "EHLO smtp1.xs4all.be")
	by vger.kernel.org with ESMTP id S1751393AbWFBNLN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 09:11:13 -0400
Date: Fri, 2 Jun 2006 15:10:34 +0200
From: Frank Gevaerts <frank.gevaerts@fks.be>
To: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Cc: Frank Gevaerts <frank.gevaerts@fks.be>,
       linux-usb-devel@lists.sourceforge.net, Greg KH <gregkh@suse.de>,
       Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] [PATCH] ipaq.c bugfixes
Message-ID: <20060602131034.GA28802@fks.be>
References: <20060530082141.GA26517@fks.be> <20060530113801.22c71afe@doriath.conectiva> <20060530115329.30184aa0@doriath.conectiva> <20060530174821.GA15969@fks.be> <20060530113327.297aceb7.zaitcev@redhat.com> <20060531213828.GA17711@fks.be> <20060531215523.GA13745@suse.de> <20060531224245.GB17711@fks.be> <20060601191654.GA1757@fks.be> <20060602095935.65257a1b@doriath.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060602095935.65257a1b@doriath.conectiva>
User-Agent: Mutt/1.5.9i
X-FKS-MailScanner: Found to be clean
X-FKS-MailScanner-SpamCheck: geen spam, SpamAssassin (score=-105.817,
	vereist 5, autolearn=not spam, ALL_TRUSTED -3.30, AWL 0.08,
	BAYES_00 -2.60, USER_IN_WHITELIST -100.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2006 at 09:59:35AM -0300, Luiz Fernando N. Capitulino wrote:
> On Thu, 1 Jun 2006 21:16:54 +0200
> Frank Gevaerts <frank.gevaerts@fks.be> wrote:
> 
> | When I changed te ipaq_open code to only submit the read urb after the
> | control message succeeds, these disappear.
> | 
> | Whenever the usb_control_msg returns with ETIMEDOUT (-110), in both code
> | variants, when the device is disconnected we get:
> 
>  Did you mean that it happens even if you send the read urb after the
> control message?

Yes.

> | This seems to be 100% reproducible. I noticed that serial_open (in
> | usb-serial.c) sets port->tty = tty and tty->driver_data = port, but
> | doesn't set them back to NULL if the type->open() fails. Is that correct
> | ?
> 
>  I don't think it would cause the problem you're getting. 'port' is
> valid even if the driver's open() function fails.

We are currently trying a version where these are both set to NULL on
failure, and it does seem to help.

> | Also, we have discovered that the slow response of the ipaq on connect
> | is actually largely caused by the control message retries, so we have
> | added a sleep at the start of ipaq_open.
> | 
> | The current patch we are testing (not yet ready for inclusion, since
> | it doesn't work correctly yet and it produces some output that is not
> | useful in general) is :
> 
>  Well, I'm afraid that every new patch leads to a new problem..
> Maybe it's something else..

I'm not sure it's a new problem every time. Some of the earlier bugs
could have been the same as this one (the stack trace was the same)

Frank

> -- 
> Luiz Fernando N. Capitulino

-- 
Frank Gevaerts                                 frank.gevaerts@fks.be
fks bvba - Formal and Knowledge Systems        http://www.fks.be/
Stationsstraat 108                             Tel:  ++32-(0)11-21 49 11
B-3570 ALKEN                                   Fax:  ++32-(0)11-22 04 19
