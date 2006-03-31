Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbWCaTcN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbWCaTcN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 14:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932106AbWCaTcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 14:32:13 -0500
Received: from smtp110.sbc.mail.mud.yahoo.com ([68.142.198.209]:48305 "HELO
	smtp110.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932092AbWCaTcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 14:32:10 -0500
From: David Brownell <david-b@pacbell.net>
To: spi-devel-general@lists.sourceforge.net
Subject: Re: [spi-devel-general] Re: question on spi_bitbang
Date: Fri, 31 Mar 2006 11:32:06 -0800
User-Agent: KMail/1.7.1
Cc: Kumar Gala <galak@kernel.crashing.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <1B2FA58D-1F7F-469E-956D-564947BDA59A@kernel.crashing.org> <200603311011.00981.david-b@pacbell.net> <29F33C89-519A-412B-9615-1944ED29FD9C@kernel.crashing.org>
In-Reply-To: <29F33C89-519A-412B-9615-1944ED29FD9C@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200603311132.06819.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 31 March 2006 11:07 am, Kumar Gala wrote:
> My controller is just a shift register that I can set the  
> characteristics of (bit length for example, reverse data).

I've got a patch somewhere to enable LSB-first transfers in the API,
though without an implementation, if you're interested.  I'll post it
as an RFC at some point.


> > The chipselect() call should only affect the chipselect signal and,
> > when you're activating a chip, its initial clock polarity.  Though
> > if you're not using the latest from the MM tree, that's also your
> > hook for ensuring that the SPI mode is set up right.
> 
> Why deal with just clock polarity and not clock phase as well in  
> chipselect()?

You could, but the point is that you _must_ set the initial polarity
before setting the chipselect.  Most SPI devices support modes 0 and 3,
and make the choice based on the clock polarity when chipselect goes
active.  Changing polarity later would start a transfer.  :)


> It sounds like with the new patch, I'll end up setting txrx_word[] to  
> the same function for all modes.

Yes, it does sound like that.  If that works for you, I'd like to see
that go into 2.6.17 kernels.

- Dave
