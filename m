Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270701AbTHFKdE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 06:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274929AbTHFKdD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 06:33:03 -0400
Received: from h234n2fls24o900.bredband.comhem.se ([217.208.132.234]:51940
	"EHLO oden.fish.net") by vger.kernel.org with ESMTP id S270701AbTHFKdB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 06:33:01 -0400
Date: Wed, 6 Aug 2003 12:35:07 +0200
From: Voluspa <lista1@telia.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O13int for interactivity
Message-Id: <20030806123507.7e1c7cae.lista1@telia.com>
Organization: The Foggy One
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Mon, 4 Aug 2003 21:12:47 +0200 I wrote:

> Wine/wineserver now has the same PRI as in pure A3 on my game-test,

I have to make an addendum based on more thorough observations.
Determining which one of wine or wineserver to treat as interactive
seems to be a hard nut for O13int - maybe impossible and irrelevant as
well. Anyway, here's what is happening:

Switching from the game to a text console where "top" is running,
counting to 15 in my head (didn't have a watch on my arm), wine dropps
its PRI from 25 to 16. Wineserver, which has had a PRI of 16, gains a
few points to 18, then shortly after gets elevated to 25 and stays
there. Returning to the game everything is clunky and sound choppy. It
takes a fair amount of work (panning, character movement, menu
selections etc) before wine gets its 25 PRI back. Just waiting doesn't
cut it.

A3 can also be fooled. Not by a mere switch to the text console, but by
deactivating an option which affects the whole graphic handling:

"Software standard BLT [on/off]. Enable this option if graphic anomalies
appear in the game"

After disabling it, but only the first time - on/off thereafter has no
trigger effect - A3 gives wineserver a PRI of 25. It does however
recuperate quickly, within something like 5 seconds. Just waiting is
enough. O13int is also affected by this trigger, that's how I first
experienced the PRI reversing.

Disclaimer: I'm not a gamer, and have no interest in the scheduler
being tuned for this particular scenario. It just happens to be that the
game-test is where I really can observe the differences in scheduler
behaviour.

Mvh
Mats Johannesson
