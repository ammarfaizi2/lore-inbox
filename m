Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751227AbVLWAhL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbVLWAhL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 19:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbVLWAhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 19:37:11 -0500
Received: from smtp102.sbc.mail.mud.yahoo.com ([68.142.198.201]:41865 "HELO
	smtp102.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751227AbVLWAhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 19:37:09 -0500
From: David Brownell <david-b@pacbell.net>
To: Vitaly Wool <vwool@ru.mvista.com>
Subject: Re: [PATCH 2.6-git] SPI: add set_clock() to bitbang
Date: Thu, 22 Dec 2005 16:37:07 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, spi-devel-general@sourceforge.net
References: <20051222180449.4335a8e6.vwool@ru.mvista.com> <200512221337.39305.david-b@pacbell.net> <43AB1DB7.3080505@ru.mvista.com>
In-Reply-To: <43AB1DB7.3080505@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512221637.07895.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> No, suppose there're two devices behind the same SPI bus that have 
> different clock constraints. As active SPI device change may well happen 
> when each new message is processed, we'll need to set up clocks again 
> for each message. Right?

Clock is coupled to chipselect/device.  When the bus controller
switches to the other device, it updates the clock accordingly.

How exactly that's done is system-specific.  Many controllers
just have a register per chipselect, listing stuff like SPI mode,
clock divisor, and word size.  So switching to that chipselect
kicks those in automatically ... devices ignore the clock unless
they've been selected.

So it's like I said earlier.  And going to a new message will
normally involve a new chipselect, yes ... but maybe not, there's
that hint available to avoid the switching.



