Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266164AbUALNdf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 08:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266165AbUALNdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 08:33:35 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:41222 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S266164AbUALNdb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 08:33:31 -0500
Date: Mon, 12 Jan 2004 13:56:55 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: =?iso-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <1@pervalidus.net>,
       linux-kernel@vger.kernel.org
Subject: Re: BUG: The key "/ ?" on my abtn2 keyboard is dead with kernel 2.6.1
Message-ID: <20040112135655.A980@pclin040.win.tue.nl>
References: <200401111545.59290.murilo_pontes@yahoo.com.br> <20040111235025.GA832@ucw.cz> <Pine.LNX.4.58.0401120004110.601@pervalidus.dyndns.org> <20040112083647.GB2372@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040112083647.GB2372@ucw.cz>; from vojtech@suse.cz on Mon, Jan 12, 2004 at 09:36:47AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 12, 2004 at 09:36:47AM +0100, Vojtech Pavlik wrote:
> On Mon, Jan 12, 2004 at 12:17:03AM -0200, Frédéric L. W. Meunier wrote:

> > I tested with the patch and it didn't fix it on the console.
> 
> Yes, the patch didn't fix it for the console.

> > showkey under 2.4:
> > 
> > keycode  89
> 
> This, however, is VERY interesting, I didn't expect this keycode under
> 2.4 at all. Can you check with 'evtest' what it does send there?

See http://www.win.tue.nl/~aeb/linux/kbd/scancodes-5.html#ss5.17

---------------------------------------------------------------------
ABNT (Associao Brasileira de Normas Tecnicas) and ABNT2 are Brazilian
keyboard layout standards. The plain Brazilian keyboard has 103 keys. 
The Brazilian ABNT keyboard has two unusual keys, with scancodes 73 (/?)
and 7e (Keypad-.). The former is located to the left of the RShift
(which key therefore is less wide than usually), the latter below the
Keypad-Plus (reducing the Keypad-Plus to single height). 
Under Linux, the corresponding key codes are 89 and 121, respectively.
---------------------------------------------------------------------

In the 2.4 source, see the array high_keys[]. It will map 73, 7d
(seen on Japanese keyboards), 7e to keycodes 89, 124, 121.

The 2.6.1 kernel will first untranslate to 51, 6a, 6d and then map
to 181, 182, 124, changing the keycode for all three.

Andries

