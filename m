Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbUC1A3p (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 19:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262014AbUC1A3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 19:29:45 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:29961 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S262008AbUC1A3m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 19:29:42 -0500
Date: Sun, 28 Mar 2004 01:29:38 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Vojtech Pavlik <vojtech@suze.cz>, torvalds@osdl.org, vojtech@ucw.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 24/44] Workaround i8042 chips with broken MUX mode
Message-ID: <20040328002938.GA11657@wsdw14.win.tue.nl>
References: <20040316182409.54329.qmail@web80508.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040316182409.54329.qmail@web80508.mail.yahoo.com>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: : kweetal.tue.nl 1074; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2004 at 10:24:09AM -0800, Dmitry Torokhov wrote:
> Vojtech Pavlik wrote:

> > +	/* Workaround for broken chips which seem to
> support MUX, but in reality don't. */

Why call them "broken"? Better to delete that word.

> > +	/* They all report version 12.10 */
> > +	if (mux_version == 0xCA)
> > +		return -1;
> 
> I think it should be 0xAC (0xA4 with 4th bit flipped)
> as the version reported is 10.12.

Yes. I have seen one such report. Have there been more?

The Synaptics multiplexing proposal uses 0xf0, 0x56, 0xa4
to activate and 0xf0, 0x56, 0xa5 to deactivate.
In both cases the replies must be 0xf0, 0x56, version.

Thus, I suppose one might get a more robust detection
by checking that both the activation and deactivation
sequences yield the same version.

Andries
