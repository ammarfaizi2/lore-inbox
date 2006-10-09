Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932992AbWJIRYB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932992AbWJIRYB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 13:24:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932994AbWJIRYB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 13:24:01 -0400
Received: from rubidium.solidboot.com ([81.22.244.175]:49894 "EHLO
	mail.solidboot.com") by vger.kernel.org with ESMTP id S932992AbWJIRYA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 13:24:00 -0400
Date: Mon, 9 Oct 2006 20:23:50 +0300
From: Timo Teras <timo.teras@solidboot.com>
To: Timo Teras <timo.teras@solidboot.com>, drzeus-list@drzeus.cx,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MMC: Select only one voltage bit in OCR response
Message-ID: <20061009172350.GC1637@mail.solidboot.com>
References: <20061009150044.GB1637@mail.solidboot.com> <20061009165317.GA6431@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061009165317.GA6431@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2006 at 05:53:17PM +0100, Russell King wrote:
> On Mon, Oct 09, 2006 at 06:00:44PM +0300, Timo Teras wrote:
> > The card might go to inactive state (according to specification), if
> > there are unsupported bits set in the OCR.
> 
> NAK.  This breaks some MMC cards.

I see. But if we do send an OCR with an unsupported bit set, the card will
go to inactive state and is unusable. This problem is masked on controllers
with only 3.3V support, but I'm working with a controller supporting several
different voltages.

For example, I have a card giving an OCR reply of 0x0ff80080. The current
code will reply to this with 0x00000180 which is clearly incorrect.

Maybe something like "ocr &= 3 << bit;" would be more approriate?

Cheers,
  Timo
