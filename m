Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263606AbUAEEm2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 23:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264387AbUAEEm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 23:42:28 -0500
Received: from fw.osdl.org ([65.172.181.6]:55717 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263606AbUAEEm0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 23:42:26 -0500
Date: Sun, 4 Jan 2004 20:42:17 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Peter Chubb <peter@chubb.wattle.id.au>
cc: Andries Brouwer <aebr@win.tue.nl>, Rob Love <rml@ximian.com>,
       rob@landley.net, Pascal Schmidt <der.eremit@email.de>,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: udev and devfs - The final word
In-Reply-To: <16376.58584.518664.138740@wombat.chubb.wattle.id.au>
Message-ID: <Pine.LNX.4.58.0401042038370.2162@home.osdl.org>
References: <20040103040013.A3100@pclin040.win.tue.nl>
 <Pine.LNX.4.58.0401022033010.10561@home.osdl.org> <20040103141029.B3393@pclin040.win.tue.nl>
 <Pine.LNX.4.58.0401031423180.2162@home.osdl.org> <20040104000840.A3625@pclin040.win.tue.nl>
 <Pine.LNX.4.58.0401031802420.2162@home.osdl.org> <20040104034934.A3669@pclin040.win.tue.nl>
 <Pine.LNX.4.58.0401031856130.2162@home.osdl.org> <20040104142111.A11279@pclin040.win.tue.nl>
 <Pine.LNX.4.58.0401041302080.2162@home.osdl.org> <20040104230104.A11439@pclin040.win.tue.nl>
 <16376.58584.518664.138740@wombat.chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 5 Jan 2004, Peter Chubb wrote:
> 
> It's worse than that.  You can do
>      mknod fred b maj minor
> anywhere on any UNIX filesystem and expect it to a) work and b) refer
> to the same device for all time until it is removed.

Hmm.. I can see (a) (except for the fact that pretty  much all unixes have 
mount-flags to say "no device files") but I don't see why you'd _ever_ 
expect (b) to be true.

It's patently not true for such rather traditional unix devices as pty's, 
for example. The "same device" ends up being true only for as long as the 
master at the other end exists - and the same numbers get re-used in all 
normal usage for different virtual devices.

> I know that Linux already breaks this (the stupid /dev/sg[0-9] that
> depend not on the SCSI bus and lun but on the order they're detected,
> for example) 

That "stupid" thing is a hell of a lot less stupid than the alternatives, 
and is very much equivalent to how pty's work. 

In fact, the "number according to detection" is pretty much the best 
device number allocation strategy. It's the _only_ one that doesn't have 
some incorrect bias built-in. 

			Linus
