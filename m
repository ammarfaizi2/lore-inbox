Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264946AbTGGL35 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 07:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264939AbTGGL35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 07:29:57 -0400
Received: from imf.math.ku.dk ([130.225.103.32]:32664 "EHLO imf.math.ku.dk")
	by vger.kernel.org with ESMTP id S266942AbTGGL3y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 07:29:54 -0400
Date: Mon, 7 Jul 2003 13:44:26 +0200 (CEST)
From: Peter Berg Larsen <pebl@math.ku.dk>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH] Synaptics: support for pass-through port (stick)
In-Reply-To: <200307062248.24006.dtor_core@ameritech.net>
Message-ID: <Pine.LNX.4.40.0307071308310.28730-100000@shannon.math.ku.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 6 Jul 2003, Dmitry Torokhov wrote:
> On Sunday 06 July 2003 08:23 am, Peter Berg Larsen wrote:

> > Why did you move the rescan up above the synaptics test? if the synaptics
> > is out of sync, any byte can be recieved.

> Yes, any byte can be received but it is unlikely that we will receive 0xAA.

Are you sure that it is unlikely for all type >= PSMOUSE_GENPS? How about
looking for the 0x00 also.

> +	if (psmouse->pktcnt == 1 && psmouse->packet[0] == PSMOUSE_RET_BAT) {
...
> +	if (psmouse->type == PSMOUSE_SYNAPTICS) {
...
> +	if (psmouse->pktcnt == 3 + (psmouse->type >= PSMOUSE_GENPS)) {


> the device gets reset. (What happens on resume for example? I am not sure as
> I didn't get to play with suspending/resuming my laptop yet.)

The mode byte is cleared to default.


> What you think about the patch below? I fixed the client's protocol order,
> ... and switching to 4-byte protocol for master.

ok.

> button reporting (only left and right as I am not sure to which buttons
> up/down should be mapped),

hmm. You dont know what the guest protocol, so you can't just | the
button information. However, reallity is that this will work for nearly
anybody now.


> +	/* adjust the touchpad to child's choice of protocol */
> +	child = port->private;
> +	if (child && child->type >= PSMOUSE_GENPS) {

Not type > PSMOUSE_GENPS ?


Peter


