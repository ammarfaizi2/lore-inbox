Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262329AbUKDRqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262329AbUKDRqJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 12:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262327AbUKDRou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 12:44:50 -0500
Received: from mail.kroah.org ([69.55.234.183]:24722 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262317AbUKDRnD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 12:43:03 -0500
Date: Thu, 4 Nov 2004 09:39:19 -0800
From: Greg KH <greg@kroah.com>
To: "Kilau, Scott" <Scott_Kilau@digi.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Germano <germano.barreiro@cyclades.com>, linux-kernel@vger.kernel.org
Subject: Re: patch for sysfs in the cyclades driver
Message-ID: <20041104173918.GB16389@kroah.com>
References: <71A17D6448EC0140B44BCEB8CD0DA36E04B9D824@minimail.digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71A17D6448EC0140B44BCEB8CD0DA36E04B9D824@minimail.digi.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2004 at 10:40:26AM -0600, Kilau, Scott wrote:
> > From: Marcelo Tosatti
> > The problem was class_simple only contains the "dev" attribute. You
> can't
> > add other attributes to it.
> 
> Ah, that changes everything.

No, you can add attributes to it, I just don't think the pointer is
accessable for a tty driver to be able to find the thing.  Need to go
look at the code again to verify this or not.

> The entire reason Germano and I were chasing down this option,
> was so we could export various "tty" statistic files out to below
> each respective tty name in /sys/class/tty 
> 
> If its currently not possible to add more attributes to the simple
> class,
> then we are probably going down the wrong avenue here, at least for now.

No, that's the proper way to go.

> Greg,
> I know you are a very busy person...
> Is making a "tty class" even in the cards for 2.6, or is it scheduled
> for 2.7+ ?

It's scheduled for whenever someone gets around to doing it :)

As there is no 2.7 tree, nor is there going to be, why not do it right
now?  I'd gladly take patches that do this, and I don't think they would
be all that big at all.

> Germano,
> I still hate doing it, and I know it is against the "1 value per file in
> sys" rule,
> but for now I think exporting the values to the "card" directory with
> each file 
> containing the value as a list of ports, 1 per line, might be the best
> option
> to work with here, at least until the "tty class" gets developed.

No, I will not allow that to go into the kernel tree, sorry.  Just
export the tty class pointer in the proper structure, and you should be
fine.

thanks,

greg k-h
