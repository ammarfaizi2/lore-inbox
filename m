Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbUCWFka (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 00:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262014AbUCWFka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 00:40:30 -0500
Received: from vitelus.com ([64.81.243.207]:39568 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id S262006AbUCWFk3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 00:40:29 -0500
Date: Mon, 22 Mar 2004 21:40:26 -0800
From: Aaron Lehmann <aaronl@vitelus.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Joshua Kwan <joshk@triplehelix.org>
Subject: Re: Synaptics touchpad + external mouse with Linux 2.6?
Message-ID: <20040323054026.GA27081@vitelus.com>
References: <m33c81lsnk.fsf@defiant.pm.waw.pl> <20040322061657.GA346@ucw.cz> <pan.2004.03.23.02.41.08.115427@triplehelix.org> <200403222332.31308.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <200403222332.31308.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2004 at 11:32:29PM -0500, Dmitry Torokhov wrote:
> Because it is not implementation, it is hardware limitation. Synaptics native
> protocol uses 6 bytes, standard PS/2 3 or 4. The protocols are not compatible
> at all so unless the PC has an active multiplexing controller (which provides
> up to 4 completely independent AUX ports) all devices have to speak the same
> protocol. 

This only matters if you plug in a PS/2 mouse. If you have a USB
mouse, that's another issue entirely. Ideally XFree86 should read
/dev/input/mice and not have to worry about the specifics of the
device. When you use the synaptics driver, XFree86 won't accept input
from USB mice. It may be possible to work around this by using
multiple Input sections, but that seems especially awkward when
Synaptics events are presented in both /dev/input/mice and /dev/psaux.

I recently switched from the synaptics driver reading /dev/psaux to
the generic ImPS/2 driver reading /dev/input/mice. (Note that the only
reason I ever installed the synaptics driver was that a kernel upgrade
forced me to.) It performs bearably, but I personally wish that I
could click by tapping and use the odd scrolling button as button3
(this only works when I hit the button exactly in the middle). At
lease I can plug in external mice without hassle.
