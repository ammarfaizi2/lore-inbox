Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbUCQXSv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 18:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262149AbUCQXQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 18:16:26 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:40196 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262153AbUCQXPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 18:15:40 -0500
Date: Wed, 17 Mar 2004 23:15:36 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Marek Szuba <scriptkiddie@wp.pl>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4, or what I still don't quite like about the new stable
 branch
In-Reply-To: <S263158AbUCMS0h/20040313182637Z+893@vger.kernel.org>
Message-ID: <Pine.LNX.4.44.0403172308290.19415-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 1. Matrox framebuffer keeps on messing up the consoles when I have X
> running and switch back and forth. As far as I know this problem is
> known to you (in fact, I use the temporary workaround patch Petr has
> released which as far as I can see only leaves the issue of scrolling
> lines occasionally losing the screen bottom, especially with programs
> using ncurses) and besides things seem to have got much better thanks to
> the general-fbcon patches introduced in 2.6.3 and 2.6.4, so I only
> mention it here pro forma.

I need to get around to fixing that problem. I'm glad the general patch 
that went in fixed alot of problems :-) It's a matter of the framebuffer 
driver restoring its state when switching back to the console. Most 
drivers have a problem with that. The current approach is to use the
xxfb_blank function to fix this up.

> 2. While fbcon is active, setfont only works on the foreground VT. It
> happens with X both running and not running, as well as on both matroxfb
> and vesafb (I haven't tested the others); I don't think this is a kbd
> bug (my version is 1.10 and I don't see anything in the 1.10->1.12
> changelog which could be related with the issue). Hope this one gets
> fixed soon, as it's the most annoying of the whole bunch.

This is normal behavior. In 2.4.X you have the same behavior. Only vgacon 
doesn't do this because it doesn't handle the differences in screen size 
on VC switching. 

