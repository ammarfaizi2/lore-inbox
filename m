Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263172AbTCLNRl>; Wed, 12 Mar 2003 08:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263173AbTCLNRl>; Wed, 12 Mar 2003 08:17:41 -0500
Received: from users.linvision.com ([62.58.92.114]:57268 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S263172AbTCLNRk>; Wed, 12 Mar 2003 08:17:40 -0500
Date: Wed, 12 Mar 2003 14:28:22 +0100
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: linux-kernel@vger.kernel.org
Cc: patrick@BitWizard.nl
Subject: [PATCH] [RFC] Userspace serial drivers: PTY changes. 
Message-ID: <20030312142822.A12206@bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Last time I implemented a complex network-using serial driver, 
I chose to implement the driver in userspace, communicating wiht
the kernel through a special driver I called USSP: User-Space Serial 
Ports. The general consensus then was that I should've used ptys. 
I agree. 

So this time, I've done things using ptys. There were however, some
features that physical serial ports could do which ptys could not.

For example Baud rates. You could set the baud rate on the slave
side, which was impossible to get at from the master side. Also
modem control signals were not implemented.  

Also we don't want the program on the master side to have to poll
say every second to see if the other side changed the baud rate
or did something else special. So when these are changed, the other
side is signalled that a change has happened and notified....


So we implemented all this. Patch attached. What do you think?

(We can dial out or dial in on the remote modem using our
userspace driver, without any significant differences from a 
normal local port!)

(This is not the time to bitch about that I generated the patch 
against the wrong kernel. I'll generate them against recent
kernels when we agree that the followed path is OK. )

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* The Worlds Ecosystem is a stable system. Stable systems may experience *
* excursions from the stable situation. We are currently in such an      * 
* excursion: The stable situation does not include humans. ***************
