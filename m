Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262653AbTHUM0o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 08:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262655AbTHUM0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 08:26:44 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:36276 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S262653AbTHUM0n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 08:26:43 -0400
Date: Thu, 21 Aug 2003 14:26:25 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: John Bradford <john@grabjohn.com>
Cc: aebr@win.tue.nl, macro@ds2.pg.gda.pl, jamie@shareable.org,
       linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au, vojtech@suse.cz
Subject: Re: Input issues - key down with no key up
Message-ID: <20030821122625.GB20748@ucw.cz>
References: <200308211211.h7LCBrdf000281@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308211211.h7LCBrdf000281@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 21, 2003 at 01:11:53PM +0100, John Bradford wrote:

> >  Note the translation is done outside the keyboard -- the onboard 8042
> > controller is responsible for it.
> 
> How do we currently handle devices connected via bit-banging on the
> parallel port,(as we have no onboard 8042 in that case)?

You write a 'serio' driver for those keyboards - a driver which will do
the bit-banging on the parallel port and send bytes from and to the
device. See the parkbd.c module for that.

The keyboard/mouse driver always sees the bytes that are on the wire,
regardless whether there is an 8042 inbetween - in that case the 8042
driver tries to undo the damage caused by translation.

This way we can have a single atkbd.c driver for any at-style keyboard
attached over whatever interface is in the machine.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
