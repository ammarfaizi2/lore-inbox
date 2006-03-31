Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751421AbWCaWUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbWCaWUG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 17:20:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbWCaWUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 17:20:06 -0500
Received: from smtp113.sbc.mail.mud.yahoo.com ([68.142.198.212]:37236 "HELO
	smtp113.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751421AbWCaWUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 17:20:05 -0500
From: David Brownell <david-b@pacbell.net>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [spi-devel-general] Re: question on spi_bitbang
Date: Fri, 31 Mar 2006 14:20:02 -0800
User-Agent: KMail/1.7.1
Cc: spi-devel-general@lists.sourceforge.net,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <1B2FA58D-1F7F-469E-956D-564947BDA59A@kernel.crashing.org> <200603311315.14408.david-b@pacbell.net> <61D4885F-D742-4583-939F-FA93A4AAC8D4@kernel.crashing.org>
In-Reply-To: <61D4885F-D742-4583-939F-FA93A4AAC8D4@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603311420.02962.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 31 March 2006 2:11 pm, Kumar Gala wrote:

> So I give a new question.  Any issue with adding a rx & tx completion  
> to spi_bitbang?

What do you mean?

> In my HW I get an interrupt when the transmitter is   
> done transmitting and one when the receiver is done receiving.  I  
> need some way to synchronize and wait for both events to occur before  
> continuing on in txrx_word().

You can't return from txrx_word() before the RX event, since the
return value is the word that was shifted in.  So if you use IRQs
to synchronize there (rather than polling a status register), all
that would be internal to your code.

- Dave
