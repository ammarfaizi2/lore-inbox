Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbTFOAPf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 20:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261450AbTFOAPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 20:15:35 -0400
Received: from lsanca2-ar27-4-46-141-054.lsanca2.dsl-verizon.net ([4.46.141.54]:26243
	"EHLO BL4ST") by vger.kernel.org with ESMTP id S261444AbTFOAPe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 20:15:34 -0400
Date: Sat, 14 Jun 2003 17:29:33 -0700
From: Eric Wong <normalperson@yhbt.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org, linus@transmeta.com
Subject: Re: [PATCH] Logitech PS/2++ updates
Message-ID: <20030615002933.GB17706@BL4ST>
References: <20030326025538.GB12549@BL4ST> <20030615005947.E27599@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030615005947.E27599@ucw.cz>
Organization: Tire Smokers Anonymous
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik <vojtech@suse.cz> wrote:
> On Tue, Mar 25, 2003 at 06:55:38PM -0800, Eric Wong wrote:
> >  /*
> >   * The PS2++ protocol is a little bit complex
> >   */
> > +	if (psmouse->type == PSMOUSE_PS2PP) { 
> > +
> > +		if ((packet[0] & 0x48) == 0x48 && (packet[1] & 0x02) == 0x02 ) {
> >  
> 
> Hmm, is this change needed? This
> 
> if ((packet[0] & 0x40) == 0x40 && abs((int)packet[1] - (((int)packet[0] & 0x10) << 4)) > 191 ) {
> 
> condition is from Logitech docs and should work with any PS2PP device.
> It doesn't with yours?

The updated PS2PP uses 6 bits to determine packet-type instead of 4 as
used previously, so compatibility with the touchpad protocol was broken
if I recall correctly.

NEW (6 t bits):
       bit7 bit6 bit5 bit4 bit3 bit2 bit1 bit0
packet0   E    1   t5   t4    1    M    R    L   
packet1  t3   t2   t1   t0   d2   d1    1    0  
packet2  d8   d7   d6   d5   d4   d3   d2   d1 

OLD (4 t bits)
       bit7 bit6 bit5 bit4 bit3 bit2 bit1 bit0
packet0   E    1   t3   t2    1    M    R    L   
packet1   ?    ?   t1   t0   d2   d1    1    0  
packet2  d8   d7   d6   d5   d4   d3   d2   d1 

E is set if it's an external device

-- 
Eric Wong
