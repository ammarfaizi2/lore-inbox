Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271388AbTGWXfZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 19:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271387AbTGWXfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 19:35:25 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:20697 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S271389AbTGWXfU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 19:35:20 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: "Michel Eyckmans (MCE)" <mce@pi.be>
Date: Thu, 24 Jul 2003 01:50:00 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: 2.6.0-test1 + matroxfb = unuusable VC 
Cc: nick black <dank@suburbanjihad.net>, linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <816FF467B0D@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 Jul 03 at 1:05, Michel Eyckmans (MCE) wrote:
> > > In this case, does it happen if you exit X, or only if you are switching
> > > to the console while X are active? If it happens only in second case, then
> > > it is bug (I believe fixed long ago) in XFree mga driver: it was sometime
> >
> > it is the latter case, thanks for the info!  regardless, the 2.6.0-test1
> > problems continue; i'll update my x this evening if my version doesn't
> > contain the fix.
> 
> After reading this, I enthousiastically upgraded from Xfree 4.2.0 to 
> 4.3.0, but nothing changed. :-( The problem is indeed X-related, but 
> refuses to go away after the upgrade.
> 
> Also, I've had 4.2.0 and several earlier X versions working just fine
> with the "old" matroxfb in the same setup that I'm using now. Was there 
> a bug workaround for this issue in the old driver? If so, is there any
> hope of it returning?

Are you sure it was matroxfb and not DRI what changed? I do not know
about any changes... But in the past (2.4.x) if XFree would set videomode
through /dev/fbX while being invisible (but with controlling tty), nothing
would change on display, as only videomode for XFree's VT would change. 
Now when there is no such virtualization, XFree server can change videomode 
of your actually visible console by mistake, while your VT could still
cache its idea of screen somewhere. But it does not look very possible,
you would probably notice that display resolution changed behind you...

Anyway, can you try applying matroxfb-2.5.72.gz from 
ftp://platan.vc.cvut.cz/pub/linux/matrox-latest to your tree (you can
enable only matroxfb after patching, no other fbdev will work) and retry
tests? Except other things it restores /dev/fbX behavior from 2.4.x
kernels. I have running XFree (Debian unstable, G550, gnome2, since last
week with metacity WM, with sawfish2 before) & VMware in the 
background while being at textual console all the time, and I see no 
strange rectangles on the screen...
                                                Petr
                                                

