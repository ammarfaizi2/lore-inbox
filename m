Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261194AbUJ3QQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbUJ3QQx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 12:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbUJ3QQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 12:16:53 -0400
Received: from mail.kroah.org ([69.55.234.183]:59544 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261212AbUJ3P3m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 11:29:42 -0400
Date: Fri, 29 Oct 2004 20:49:20 -0700
From: Greg KH <greg@kroah.com>
To: Paul Fulghum <paulkf@microgate.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Oleksiy <Oleksiy@kharkiv.com.ua>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: pl2303/usb-serial driver problem in 2.4.27-pre6
Message-ID: <20041030034920.GA1501@kroah.com>
References: <416A6CF8.5050106@kharkiv.com.ua> <20041012171004.GB11750@kroah.com> <20041023180625.GA12113@logos.cnet> <1098572412.5996.6.camel@at2.pipehead.org> <1098576844.5996.27.camel@at2.pipehead.org> <1098908206.2856.17.camel@deimos.microgate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098908206.2856.17.camel@deimos.microgate.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2004 at 03:16:46PM -0500, Paul Fulghum wrote:
> On Sat, 2004-10-23 at 19:14, Paul Fulghum wrote:
> > This change fits the reported symptom (loss of receive data).
> > 
> > The change preserves line status errors
> > across multiple read interrupt callbacks until the error
> > can be applied to the contents of the next read bulk callback.
> > 
> > What looks wrong to me is that the line status error,
> > which should be associated with an individual character,
> > is applied to the entire contents of the next bulk read.
> > Wouldn't this potentially invalidate good data?
> > 
> > I'm not familiar with the operation of USB-serial converters,
> > so I don't know exactly how the flow of read interrupt and
> > read bulk callbacks are implemented to handle character errors.
> > 
> > If I was to guess, before the change, errors were lost
> > (overwritten by the next read interrupt callback)
> > so the mask was added to preserve the error.
> > But the error is applied to more data than it should,
> > causing loss of valid receive data.
> 
> USB CDC 1.1 does not specify how these error indications
> relate to subsequent bulk data packets. I could not find
> manufacturer info that helps. BSD drivers don't do
> error processing at all.
> 
> Here is a patch that applies the error only to the
> next receive byte instead of all bytes in the
> next read bulk packet.
> 
> Greg: Any comment?

Your patch looks sane, thanks.

> Oleksiy: Can you try this patch?

Let us know if this works or not.  If so, Paul, care to resend this for
2.6 also?

thanks,

greg k-h
