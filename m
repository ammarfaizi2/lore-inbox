Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030289AbVLVVhl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030289AbVLVVhl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 16:37:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030292AbVLVVhl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 16:37:41 -0500
Received: from smtp103.sbc.mail.mud.yahoo.com ([68.142.198.202]:50358 "HELO
	smtp103.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030289AbVLVVhl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 16:37:41 -0500
From: David Brownell <david-b@pacbell.net>
To: Vitaly Wool <vwool@ru.mvista.com>
Subject: Re: [PATCH 2.6-git] SPI: add set_clock() to bitbang
Date: Thu, 22 Dec 2005 13:37:39 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, spi-devel-general@sourceforge.net
References: <20051222180449.4335a8e6.vwool@ru.mvista.com> <200512220840.34152.david-b@pacbell.net> <43AB1958.1070407@ru.mvista.com>
In-Reply-To: <43AB1958.1070407@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512221337.39305.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >This is actually not needed.  Clocks are set through the setup() method
> ...
>
> Where is it supposed to call setup? I guess it's anyway gonna be 
> per-transfer, right?
> Or am I missing something?

When the device is created, the core calls setup() to get things like
chipselect polarity sorted out and put into the inactive state.   That
matches the board-specific defaults associated with that device, which
would be a function of voltage, routing, and more.

And from then on, it'd be rare to ever call setup() again ... though
drivers certainly could do that between spi_message interactions with
a given device.

- Dave
