Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284548AbRLIW12>; Sun, 9 Dec 2001 17:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284553AbRLIW1S>; Sun, 9 Dec 2001 17:27:18 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:2316 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S284548AbRLIW1K>; Sun, 9 Dec 2001 17:27:10 -0500
Message-ID: <3C13E52A.48C0843D@linux-m68k.org>
Date: Sun, 09 Dec 2001 23:26:50 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: Marcelo Tosatti <marcelo@conectiva.com.br>, Rene Rebe <rene.rebe@gmx.net>,
        linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net
Subject: Re: devfs unable to handle permission: 2.4.17-pre[4,5] 
 /ALSA-0.9.0beta[9,10]
In-Reply-To: <3C1378D6.A5BAB1FA@linux-m68k.org>
		<Pine.LNX.4.21.0112091744430.24350-100000@freak.distro.conectiva> <200112092126.fB9LQZE12582@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Richard Gooch wrote:

> There are some broken boot scripts (modelled after the long obsolete
> rc.devfs script)

Which is still included in the kernel tree and at least Mandrake is
currently using it.
There were no signs of deprecation, so people are legally using it.

> This is not actually a problem for leaf nodes, since the user-space
> created device nodes will still work. It just results in a warning
> message.

Wrong, these are not just warning messages, the driver API has changed.

> So, in this case, the device nodes that the user wants to use will
> still be there (created by the boot script) and will work fine.

Except the dynamic update of device nodes won't happen anymore, so it
affects also all leaf nodes in the directories (e.g. partition entries
won't be created/removed anymore). Events won't be created for these
nodes as well, so configurations depending on this are broken as well.

> The second issue was due to a broken devfsd configuration file which
> caused the wrong permissions to be set on a directory. This led to
> Roman thinking that the new devfs core was breaking stuff. As I've
> shown above, the breakage is a rare corner case involving an obsolete
> script.

"rare corner case"??? Richard, this isn't funny anymore. :-(
BTW restoring backward compatibility is probably just a couple of lines
code, but first you had to admit that it's broken.

bye, Roman
