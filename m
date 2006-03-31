Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbWCaX6B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbWCaX6B (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 18:58:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbWCaX6B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 18:58:01 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:27179 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S1750765AbWCaX6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 18:58:00 -0500
In-Reply-To: <200603311420.02962.david-b@pacbell.net>
References: <1B2FA58D-1F7F-469E-956D-564947BDA59A@kernel.crashing.org> <200603311315.14408.david-b@pacbell.net> <61D4885F-D742-4583-939F-FA93A4AAC8D4@kernel.crashing.org> <200603311420.02962.david-b@pacbell.net>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <7BA58A37-79FE-498B-8C1E-07130BFDF86F@kernel.crashing.org>
Cc: spi-devel-general@lists.sourceforge.net,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [spi-devel-general] Re: question on spi_bitbang
Date: Fri, 31 Mar 2006 17:58:13 -0600
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


On Mar 31, 2006, at 4:20 PM, David Brownell wrote:

> On Friday 31 March 2006 2:11 pm, Kumar Gala wrote:
>
>> So I give a new question.  Any issue with adding a rx & tx completion
>> to spi_bitbang?
>
> What do you mean?
>
>> In my HW I get an interrupt when the transmitter is
>> done transmitting and one when the receiver is done receiving.  I
>> need some way to synchronize and wait for both events to occur before
>> continuing on in txrx_word().
>
> You can't return from txrx_word() before the RX event, since the
> return value is the word that was shifted in.  So if you use IRQs
> to synchronize there (rather than polling a status register), all
> that would be internal to your code.

Your right, I just put this in my struct that wraps spi_bitbang.

It's too bad we dont have a better solution for spi_bitbang having to  
be first.

I've got a working driver w/o using the setup_transfer() mods, I'll  
look at fixing that up next.

- kumar
