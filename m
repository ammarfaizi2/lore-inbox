Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271845AbTHHTGS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 15:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271807AbTHHTEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 15:04:13 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:4627 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S271808AbTHHS6O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 14:58:14 -0400
Date: Fri, 8 Aug 2003 20:58:09 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Adrian Bunk <bunk@fs.tum.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Surprising Kconfig depends semantics
In-Reply-To: <20030808183020.GD16091@fs.tum.de>
Message-ID: <Pine.LNX.4.44.0308082052460.24676-100000@serv>
References: <20030808144408.GX16091@fs.tum.de> <Pine.LNX.4.44.0308081708390.714-100000@serv>
 <20030808183020.GD16091@fs.tum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 8 Aug 2003, Adrian Bunk wrote:

> > This is probably the easiest solution:
> > 
> > 	default INPUT_KEYBOARD && SERIO
> > 
> > (INPUT_KEYBOARD already depends on INPUT)
> 
> I'll send a
>   default INPUT && INPUT_KEYBOARD && SERIO
> patch (to address the things James said, in any cases it doesn't do any 
> harm).

His comment didn't make much sense, INPUT_KEYBOARD is still independent of 
SERIO.

> But it stays strange that a default can assign a value that isn't 
> allowed by the depends, and you therefore have to write the depends 
> twice in this case:
> 
> config KEYBOARD_ATKBD
>         tristate "AT keyboard support" if EMBEDDED || !X86 
>         default INPUT && INPUT_KEYBOARD && SERIO
>         depends on INPUT && INPUT_KEYBOARD && SERIO

The easier solution is probably to force SERIO to 'y' as well, as the 
point of hiding it behind EMBEDDED is to get it compiled into the kernel.

bye, Roman

