Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271714AbTGRG3y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 02:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271723AbTGRG3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 02:29:54 -0400
Received: from hauptpostamt.charite.de ([193.175.66.220]:60587 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id S271714AbTGRG3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 02:29:52 -0400
Date: Fri, 18 Jul 2003 08:44:44 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1-ac2 issues / Toshiba Laptop keyboard
Message-ID: <20030718064444.GF6429@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030717141847.GF7864@charite.de> <m38yqxf2ab.fsf@lugabout.jhcloos.org> <20030717201039.GC25759@charite.de> <m365m0etsr.fsf@lugabout.jhcloos.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m365m0etsr.fsf@lugabout.jhcloos.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* James H. Cloos Jr. <cloos@jhcloos.com>:

> The one example I quoted above, atkbd_set2_keycode[0xb2] is in fact 0.
> 
> Perhaps your kb is doing something unusual w/ the key release events.

I would think so!

The patch that fixed the issue with the key release events was this -
I submitted it to Alan who then put it into ac and then it went into
2.4.x...

Details: http://www.informatik.uni-freiburg.de/~leibl/lol/

Patch excerpt:

+                /* The following 'if' is a workaround for hardware
+                 * which sometimes send the key release event twice */
+                unsigned char next_scancode = scancode|up_flag;
+                if (up_flag && next_scancode==prev_scancode) {
+                       /* unexpected 2nd release event */
+                } else {
+                        prev_scancode=next_scancode;
+                        put_queue(next_scancode);
+                }

I haven't checked if 2.6.0 already has this!


-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite Campus Mitte                            Tel.  +49 (0)30-450 570-155
Referat V a - Kommunikationsnetze -             Fax.  +49 (0)30-450 570-916
AIM: ralfpostfix
