Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265456AbTFRRpi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 13:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265457AbTFRRph
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 13:45:37 -0400
Received: from adsl-157-201-192.dab.bellsouth.net ([66.157.201.192]:27115 "EHLO
	midgaard.us") by vger.kernel.org with ESMTP id S265456AbTFRRpP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 13:45:15 -0400
Subject: Re: [PATCH] 2.5.72 O(1) interactivity bugfix
From: Andreas Boman <aboman@midgaard.us>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <200306190043.14291.kernel@kolivas.org>
References: <200306190043.14291.kernel@kolivas.org>
Content-Type: text/plain
Message-Id: <1055959194.1077.21.camel@asgaard.midgaard.us>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 18 Jun 2003 13:59:54 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-06-18 at 10:43, Con Kolivas wrote: 
> --BEGIN PGP SIGNED MESSAGE--
> Hash: SHA1
> 
> Hi Ingo, all
> 
> While messing with the interactivity code I found what appears to be an 
> uninitialised variable (p->sleep_avg), which is responsible for all the 
> boost/penalty in the scheduler. Initialising this variable to 0 seems to have 
> made absolutely massive improvements to system responsiveness under load
> and completely removed audio skips up to doing a make -j64 on my uniprocessor 
> P4 (beyond which swap starts being used), without changing the scheduler 
> timeslices. This seems to help all 2.4 O(1) based kernels as well. Attached 
> is a patch against 2.5.72 but I'm not sure about the best place to initialise 
> it.

Applying this ontop of 2.5.72-mm1 causes more xmms/mpg321/ogg123
skipping than with plain -mm1 here. make -j20 on my up athlon 1900+ with
512M ram causes extreme skipping until the make is killed. With plain
-mm1 I may get _one_ skip at the very begining of a song during make
-j20 (about 50% of the time). Plain -mm1 stops skipping after 10-15 sec
of playback of a song, and even switching desktops after that doesnt
cause skips, with or without make -j20 running (switching to/from
desktops with apps like mozilla, evolution etc. will cause skips during
the first 10-15 sec of a song regardless what I do it seems).

Renicing xmms to -15 doesnt change anything with either kernel.  

	Andreas


