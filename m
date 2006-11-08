Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423845AbWKHWrj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423845AbWKHWrj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 17:47:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423846AbWKHWrj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 17:47:39 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:37931 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1423845AbWKHWri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 17:47:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eqqtZXJJjGDk1DBNpTaMsaJcCyT3ox7/uWpl3uZ1OWNr0DeR8Kn2uMNQt+RAUC1MfDfRwLNz/t/MXrKJN3pMuZPVTk9bB4FDWdmNLrogrquBQjLrE/td8ZFpHhFKtZHQTr/ul8KLQCO3qWWkfpgCCtk8Rdy73GQPgG2g3nNKgtU=
Message-ID: <1defaf580611081447t4f443657xc4058626ce0f0907@mail.gmail.com>
Date: Wed, 8 Nov 2006 23:47:36 +0100
From: "Haavard Skinnemoen" <hskinnemoen@gmail.com>
To: "David Brownell" <david-b@pacbell.net>
Subject: Re: [-mm patch 1/4] GPIO framework for AVR32
Cc: hskinnemoen@atmel.com, linux-kernel@vger.kernel.org, andrew@sanpeople.com,
       akpm@osdl.org
In-Reply-To: <20061108221220.44E6C1DC983@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061107122507.6f1c6e81@cad-250-152.norway.atmel.com>
	 <20061107122715.3022da2f@cad-250-152.norway.atmel.com>
	 <20061107131014.535ab280.akpm@osdl.org>
	 <20061107223741.62FA21DC801@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	 <20061108124823.308ae3b4@cad-250-152.norway.atmel.com>
	 <20061108180059.845DE1DC95A@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	 <20061108195757.0d9e9dbc@cad-250-152.norway.atmel.com>
	 <20061108221220.44E6C1DC983@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/06, David Brownell <david-b@pacbell.net> wrote:
> > The request/free calls aren't really arch-specific, are they?
>
> Remember that where one platform may use numbers 32-159 for GPIOs, another
> might use 0-71 ... GPIO numbering has an arch-specific core, but whether
> a given board adds more GPIOs from an FPGA or other non-SOC chip is even
> more variable than "arch-specific".

Sorry, I'm having trouble expressing myself clearly today ;-)

I didn't mean to suggest that the interpretation of the numbers or the
gpio_request() implementation should be arch-independent. I was merely
suggesting that the _concept_ of requesting GPIO pins before using
them, keeping track of which pins have been allocated before, isn't
something inherently arch-specific.

I'm all for leaving it up to each arch or possibly each sub-arch how
to implement the request/free functions. They can even be implemented
as no-op stubs that always succeed for all I care. But I don't think
any arch or platform will really have much trouble with implementing
some kind of "please reserve this gpio pin represented as an unsigned
int for me" call.

> > I implement the actual allocation mechanism using atomic bitops.
>
> That's a fair way to implement it, sure; but if you look at e.g. how
> OMAP does it, the bitmap is inside a per-controller structure.  When
> one chip has two different _types_ of GPIO controller, and multiple
> instances of one (plus restrictions applying to specific instances),
> the notion of an arch-neutral implementation there seems unworkable.

Agreed. The avr32 implementation also uses a per-controller bitmap and
supports any number of instances (up to a compile-time limit since it
is initialized too early to be able to allocate any memory.) It
doesn't support different type of controllers though; that would
require some kind of demuxing and should probably be avoided on
platforms that don't need it.

Haavard
