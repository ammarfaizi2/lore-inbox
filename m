Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265842AbUBBUXW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 15:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265816AbUBBUWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 15:22:20 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:1152 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S266056AbUBBURx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 15:17:53 -0500
Date: Mon, 2 Feb 2004 21:18:13 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Valdis.Kletnieks@vt.edu
Cc: Joshua Kwan <joshk@triplehelix.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: 2.6 input drivers FAQ
Message-ID: <20040202201813.GA272@ucw.cz>
References: <20040201100644.GA2201@ucw.cz> <20040201163136.GF11391@triplehelix.org> <200402020527.i125RvTx008088@turing-police.cc.vt.edu> <20040202092318.GD548@ucw.cz> <200402021812.i12IC6eR006637@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402021812.i12IC6eR006637@turing-police.cc.vt.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 02, 2004 at 01:12:06PM -0500, Valdis.Kletnieks@vt.edu wrote:

> Section "InputDevice"
>         Identifier  "Mouse0"
>         Driver      "mouse"
>         Option      "Device" "/dev/psaux"
>         Option      "Protocol" "ExplorerPS/2"
>         Option      "Buttons" "7"
>         Option      "Emulate3Buttons" "on"
>         Option      "ZAxisMapping" "6 7"
> EndSection
> 
> And if I *had* gotten it in there twice, why would it only hit sporadically
> once or twice a day, as opposed to *all* mouse events (clicks, moves,
> etc) being doubled?

Because normally the X server reads them in very quick succession and if
you don't make a very short click, the sequence looks like this:

push1 push2 release1 release2, which is fine, because X interprets that
as just a push and a release.

If there is disk activity or something else that causes the scheduling
to be delayed, it's push1 release1 push2 release2, which counts as a
doubleclick.

Hence sporadic doubleclicking.

For movement, of course, you get twice the mouse speed, but usually most
people just adjust the acceleration settings and are done with that.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
