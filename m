Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932267AbWCaUAo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbWCaUAo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 15:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbWCaUAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 15:00:44 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:544 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S932264AbWCaUAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 15:00:43 -0500
In-Reply-To: <200603311132.06819.david-b@pacbell.net>
References: <1B2FA58D-1F7F-469E-956D-564947BDA59A@kernel.crashing.org> <200603311011.00981.david-b@pacbell.net> <29F33C89-519A-412B-9615-1944ED29FD9C@kernel.crashing.org> <200603311132.06819.david-b@pacbell.net>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <3E572FEF-093B-4359-9FC4-45D00B33C993@kernel.crashing.org>
Cc: spi-devel-general@lists.sourceforge.net,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [spi-devel-general] Re: question on spi_bitbang
Date: Fri, 31 Mar 2006 14:00:55 -0600
To: David Brownell <david-b@pacbell.net>
X-Mailer: Apple Mail (2.746.3)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mar 31, 2006, at 1:32 PM, David Brownell wrote:

> On Friday 31 March 2006 11:07 am, Kumar Gala wrote:
>> My controller is just a shift register that I can set the
>> characteristics of (bit length for example, reverse data).
>
> I've got a patch somewhere to enable LSB-first transfers in the API,
> though without an implementation, if you're interested.  I'll post it
> as an RFC at some point.

The controllers capable so if/when we have something at a higher  
level I can look at adding support for it.

>>> The chipselect() call should only affect the chipselect signal and,
>>> when you're activating a chip, its initial clock polarity.  Though
>>> if you're not using the latest from the MM tree, that's also your
>>> hook for ensuring that the SPI mode is set up right.
>>
>> Why deal with just clock polarity and not clock phase as well in
>> chipselect()?
>
> You could, but the point is that you _must_ set the initial polarity
> before setting the chipselect.  Most SPI devices support modes 0  
> and 3,
> and make the choice based on the clock polarity when chipselect goes
> active.  Changing polarity later would start a transfer.  :)

Makes sense about needing to set polarity in the chipselect() before  
the actual chip select.  I just now completely confused on when I  
need to things.

My confusion is about the order of which various things occur.  setup 
(), chipselect() and transfer() vs what's happening in bitbang_work 
().  I don't see how we handle the fact that two different devices  
may require setup() to be called when we switch between them.

>> It sounds like with the new patch, I'll end up setting txrx_word[] to
>> the same function for all modes.
>
> Yes, it does sound like that.  If that works for you, I'd like to see
> that go into 2.6.17 kernels.

I'm not sure I understand what you'd like to see go into 2.6.17.

- kumar
