Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262045AbUC1Akq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 19:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262051AbUC1Akq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 19:40:46 -0500
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:46690 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262045AbUC1Akn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 19:40:43 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Andries Brouwer <aebr@win.tue.nl>
Subject: Re: [PATCH 24/44] Workaround i8042 chips with broken MUX mode
Date: Sat, 27 Mar 2004 19:40:39 -0500
User-Agent: KMail/1.6.1
Cc: Vojtech Pavlik <vojtech@suze.cz>, torvalds@osdl.org, vojtech@ucw.cz,
       linux-kernel@vger.kernel.org
References: <20040316182409.54329.qmail@web80508.mail.yahoo.com> <20040328002938.GA11657@wsdw14.win.tue.nl>
In-Reply-To: <20040328002938.GA11657@wsdw14.win.tue.nl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200403271940.39940.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 27 March 2004 07:29 pm, Andries Brouwer wrote:
> On Tue, Mar 16, 2004 at 10:24:09AM -0800, Dmitry Torokhov wrote:
> > Vojtech Pavlik wrote:
> 
> > > +	/* Workaround for broken chips which seem to
> > support MUX, but in reality don't. */
> 
> Why call them "broken"? Better to delete that word.
> 
> > > +	/* They all report version 12.10 */
> > > +	if (mux_version == 0xCA)
> > > +		return -1;
> > 
> > I think it should be 0xAC (0xA4 with 4th bit flipped)
> > as the version reported is 10.12.
> 
> Yes. I have seen one such report. Have there been more?
>

As it turned out its not the chip but USB legacy emulation that
gets in the way of synaptics query. Actually alot of problems were
linked to broken legacy emulation implementations, Vojtech mentioned
that PCI quirk to turn legacy emulation off may be appropriate.
 
> The Synaptics multiplexing proposal uses 0xf0, 0x56, 0xa4
> to activate and 0xf0, 0x56, 0xa5 to deactivate.
> In both cases the replies must be 0xf0, 0x56, version.
> 
> Thus, I suppose one might get a more robust detection
> by checking that both the activation and deactivation
> sequences yield the same version.
>

Unfortunately in this particular case it looks like something flips
4th bit on some (but not all, like every 3rd) bytes, so it may very
well respond with 0xAC to both queries.
  
-- 
Dmitry
