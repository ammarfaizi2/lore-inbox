Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757049AbWKVVpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757049AbWKVVpF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 16:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757072AbWKVVpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 16:45:05 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:20909 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1757049AbWKVVoz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 16:44:55 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <4564C4C7.5060403@s5r6.in-berlin.de>
Date: Wed, 22 Nov 2006 22:44:39 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Robert Crocombe <rcrocomb@gmail.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       linux1394-devel <linux1394-devel@lists.sourceforge.net>
Subject: Re: ieee1394: host adapter disappears on 1394 bus reset
References: <e6babb600611220731p67b15e51q95f524683070ae80@mail.gmail.com>
In-Reply-To: <e6babb600611220731p67b15e51q95f524683070ae80@mail.gmail.com>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Crocombe wrote:
> I have an Opteron-based machine that has 1 Unibrain Fireboard 800 and
> 1 Indigita IDT804 card (4 separate 1394 controllers).  Sometimes upon
> bus reset, one of the controllers is lost.  By lost, I mean that
> debugging printouts in /var/log/messages which are usually prefixed
> "fw-hostXYZ" are gone.
[...]

IOW, ohci1394's bus reset handler is never called again.

Does this happen only if you reset all buses at once?
Does it only happen on the Indigita card or also on the Unibrain card?
Do the controllers share IRQs?
Does it happen if there is no transmission or reception going on?

It would be nice if you create an entry at bugzilla.kernel.org. If you
do, also add a link to an archive of this discussion, e.g.
http://lkml.org/lkml/2006/11/22/122 .

Maybe it's related to http://bugzilla.kernel.org/show_bug.cgi?id=6070
(use of msleep busy-wait loops in ohci1394's interrupt handler's
context). Whatever it is, the fact that you lose interrupt events only
after a bus reset & selfID complete event strongly indicates that there
is something wrong with the drivers' low-level bus reset handling. OTOH
I don't remember a similar report.

One thing you could try next is to add a debug logging macro which
prints the contents of OHCI1394_IntEventClear, OHCI1394_IntEventSet, and
OHCI1394_IntMaskSet, right after ohci1394's call to
hpsb_selfid_complete. (I'm merely poking in the dark here.)
-- 
Stefan Richter
-=====-=-==- =-== =-==-
http://arcgraph.de/sr/
