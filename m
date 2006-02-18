Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750852AbWBRF76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750852AbWBRF76 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 00:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbWBRF76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 00:59:58 -0500
Received: from mail2.genealogia.fi ([194.100.116.229]:1223 "EHLO
	mail2.genealogia.fi") by vger.kernel.org with ESMTP
	id S1750838AbWBRF76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 00:59:58 -0500
Date: Fri, 17 Feb 2006 21:57:36 -0800
From: Jouni Malinen <jkmaline@cc.hut.fi>
To: Mark Lord <lkml@rtr.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: TKIP: replay detected:  WTF?
Message-ID: <20060218055736.GE8579@jm.kir.nu>
References: <43F65F03.1080001@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F65F03.1080001@rtr.ca>
User-Agent: Mutt/1.5.11
X-Spam-Score: -2.6 (--)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2006 at 06:40:51PM -0500, Mark Lord wrote:

> Lately I've been seeing my kernel logs spammed by these events:
> 
> Feb 17 18:38:48 localhost kernel: TKIP: replay detected: 
> STA=00:13:46:16:96:b8 previous TSC ffff80723500 received TSC 000000000001

netdev could be better mailing list for this kind of issue. Anyway, it
looks like something managed to set the last packet number to very high
number which will make all future frames dropped as replays.

> This is with the various 2.6.16-rc*-git* kernels, and possibly older 2.6.15 
> series as well.
> They always seem to arrive in large bursts, like the bunch shown above.  
> Using wifi
> over ipw2200 to a WPA2 AP.

Are you using wpa_supplicant to take care of the WPA2 handshake? If yes,
it would be interesting to see debug log from it for the key handshake
that happened just prior to this replay issue occurring.

> Either this is "normal" behaviour, in which case the code should NOT be 
> spamming me,
> or something is broken, in which case.. what?

This is not normal behavior, i.e., something is indeed broken
(driver/supplicant/AP). Though, the those messages could be disabled by
default if there were a useful counter for detecting this kind of issues
easily. Anyway, these debug messages are quite useful in figuring out
what could have caused the "replays".

-- 
Jouni Malinen                                            PGP id EFC895FA
