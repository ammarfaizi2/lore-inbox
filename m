Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbTFNWqC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 18:46:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbTFNWqC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 18:46:02 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:52864 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S261245AbTFNWqA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 18:46:00 -0400
Date: Sun, 15 Jun 2003 00:59:47 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Eric Wong <eric@yhbt.net>
Cc: linux-kernel@vger.kernel.org, linus@transmeta.com, vojtech@suse.cz
Subject: Re: [PATCH] Logitech PS/2++ updates
Message-ID: <20030615005947.E27599@ucw.cz>
References: <20030326025538.GB12549@BL4ST>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030326025538.GB12549@BL4ST>; from eric@yhbt.net on Tue, Mar 25, 2003 at 06:55:38PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 25, 2003 at 06:55:38PM -0800, Eric Wong wrote:

> Updates to the PS/2++ mouse protocol used by Logitech, as well as
> SMS/Smart Scroll/Cruise Control and 800 cpi resolution control for those
> who want it.  Up to 10 buttons are supported now, although only 8 are
> used at the moment  on the MX500 and MX700.

Nice.

>  /*
>   * The PS2++ protocol is a little bit complex
>   */
> +	if (psmouse->type == PSMOUSE_PS2PP) { 
> +
> +		if ((packet[0] & 0x48) == 0x48 && (packet[1] & 0x02) == 0x02 ) {
>  

Hmm, is this change needed? This

if ((packet[0] & 0x40) == 0x40 && abs((int)packet[1] - (((int)packet[0] & 0x10) << 4)) > 191 ) {

condition is from Logitech docs and should work with any PS2PP device.
It doesn't with yours?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
