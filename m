Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbTFOHIL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 03:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261985AbTFOHIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 03:08:11 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:34189 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S261939AbTFOHIJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 03:08:09 -0400
Date: Sun, 15 Jun 2003 09:21:54 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Eric Wong <normalperson@yhbt.net>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org,
       linus@transmeta.com
Subject: Re: [PATCH] Logitech PS/2++ updates
Message-ID: <20030615092154.A29763@ucw.cz>
References: <20030326025538.GB12549@BL4ST> <20030615005947.E27599@ucw.cz> <20030615002933.GB17706@BL4ST>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030615002933.GB17706@BL4ST>; from normalperson@yhbt.net on Sat, Jun 14, 2003 at 05:29:33PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 14, 2003 at 05:29:33PM -0700, Eric Wong wrote:

> Vojtech Pavlik <vojtech@suse.cz> wrote:
> > On Tue, Mar 25, 2003 at 06:55:38PM -0800, Eric Wong wrote:
> > >  /*
> > >   * The PS2++ protocol is a little bit complex
> > >   */
> > > +	if (psmouse->type == PSMOUSE_PS2PP) { 
> > > +
> > > +		if ((packet[0] & 0x48) == 0x48 && (packet[1] & 0x02) == 0x02 ) {
> > >  
> > 
> > Hmm, is this change needed? This
> > 
> > if ((packet[0] & 0x40) == 0x40 && abs((int)packet[1] - (((int)packet[0] & 0x10) << 4)) > 191 ) {
> > 
> > condition is from Logitech docs and should work with any PS2PP device.
> > It doesn't with yours?
> 
> The updated PS2PP uses 6 bits to determine packet-type instead of 4 as
> used previously, so compatibility with the touchpad protocol was broken
> if I recall correctly.
> 
> NEW (6 t bits):
>        bit7 bit6 bit5 bit4 bit3 bit2 bit1 bit0
> packet0   E    1   t5   t4    1    M    R    L   
> packet1  t3   t2   t1   t0   d2   d1    1    0  
> packet2  d8   d7   d6   d5   d4   d3   d2   d1 
> 
> OLD (4 t bits)
>        bit7 bit6 bit5 bit4 bit3 bit2 bit1 bit0
> packet0   E    1   t3   t2    1    M    R    L   
> packet1   ?    ?   t1   t0   d2   d1    1    0  
> packet2  d8   d7   d6   d5   d4   d3   d2   d1 
> 
> E is set if it's an external device

Thanks for the info. I didn't expect Logitech to ever need more than 16
special packets bits. 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
