Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750836AbWKCIUX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbWKCIUX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 03:20:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbWKCIUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 03:20:23 -0500
Received: from styx.suse.cz ([82.119.242.94]:32465 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1750836AbWKCIUW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 03:20:22 -0500
Date: Fri, 3 Nov 2006 09:18:47 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: Dave Neuer <mr.fred.smoothie@pobox.com>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFT/PATCH] i8042: remove polling timer (v6)
Message-ID: <20061103081847.GC10906@suse.cz>
References: <200608232311.07599.dtor@insightbb.com> <161717d50610300501w240a8ce1h4d58b1f3f2f759bf@mail.gmail.com> <161717d50610300622h15d5e40w4a30e1a95b3c2564@mail.gmail.com> <200611030056.03357.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611030056.03357.dtor@insightbb.com>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2006 at 12:56:02AM -0500, Dmitry Torokhov wrote:
> On Monday 30 October 2006 09:22, Dave Neuer wrote:
> > On 10/30/06, Dave Neuer <mr.fred.smoothie@pobox.com> wrote:
> > >
> > > Maybe I'm missing something, (well actually I'm sure I'm missing
> > > somethng). Looking at the code again, it's unclear to me why there is
> > > even a call to the ISR in i8042_aux_write, since the latter function
> > > already calls i8042_read_data.
> > >
> > 
> > Whoops, sorry. I meant i8042_command, which is called by
> > i8042_aux_write before the call to i8042_interrupt, already calls
> > i8042_read_data.
> >
> 
> It only calls i8042_read_data() if command is supposed to return data.
> Neither I8042_CMD_AUX_SEND nor I8042_CMD_MUX_SEND wait fotr data to come
> back.
> 
> Anyway, I removed call to i8042_interrupt() from i8042_aux_write() because
> it is indeed unnecessary.
 
It was there because some older i8042's will report an error byte (=>
data) even though no device is connected, not just set error flags.

The unflushed byte in the FIFO then caused problems later on.

It may be that now it'll get disposed of correctly, I haven't looked at
the code for a while.

-- 
Vojtech Pavlik
Director SuSE Labs
