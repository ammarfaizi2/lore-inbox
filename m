Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161736AbWKHWMd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161736AbWKHWMd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 17:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161743AbWKHWMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 17:12:32 -0500
Received: from smtp109.sbc.mail.mud.yahoo.com ([68.142.198.208]:28549 "HELO
	smtp109.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161736AbWKHWMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 17:12:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:Received:Date:From:To:Subject:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
  b=iEXkK74OsEi4+ZwejD1+aeLLLS+PR2Qs2H9FkpuyluOX8DaBcR+UZ7YGJDmYUXOgKQDSgvLfnAp5YSywA2AtKeSsRErB8p/LkHyNpsd4gMtKtwK5yEVrzZxtyUUFVf00vwocNRjHkumlel73fZ00hLTc/sv750dyOtFhq+3ryx0=  ;
Date: Wed, 08 Nov 2006 14:12:20 -0800
From: David Brownell <david-b@pacbell.net>
To: hskinnemoen@atmel.com
Subject: Re: [-mm patch 1/4] GPIO framework for AVR32
Cc: linux-kernel@vger.kernel.org, andrew@sanpeople.com, akpm@osdl.org
References: <20061107122507.6f1c6e81@cad-250-152.norway.atmel.com>
 <20061107122715.3022da2f@cad-250-152.norway.atmel.com>
 <20061107131014.535ab280.akpm@osdl.org>
 <20061107223741.62FA21DC801@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
 <20061108124823.308ae3b4@cad-250-152.norway.atmel.com>
 <20061108180059.845DE1DC95A@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
 <20061108195757.0d9e9dbc@cad-250-152.norway.atmel.com>
In-Reply-To: <20061108195757.0d9e9dbc@cad-250-152.norway.atmel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20061108221220.44E6C1DC983@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The request/free calls aren't really arch-specific, are they?

Remember that where one platform may use numbers 32-159 for GPIOs, another
might use 0-71 ... GPIO numbering has an arch-specific core, but whether
a given board adds more GPIOs from an FPGA or other non-SOC chip is even
more variable than "arch-specific".


> I implement the actual allocation mechanism using atomic bitops.

That's a fair way to implement it, sure; but if you look at e.g. how
OMAP does it, the bitmap is inside a per-controller structure.  When
one chip has two different _types_ of GPIO controller, and multiple
instances of one (plus restrictions applying to specific instances),
the notion of an arch-neutral implementation there seems unworkable.

- Dave

