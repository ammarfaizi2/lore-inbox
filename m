Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268421AbUHKXsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268421AbUHKXsk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 19:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268333AbUHKXsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 19:48:22 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:63156 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S268317AbUHKXFx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 19:05:53 -0400
Date: Thu, 12 Aug 2004 01:05:47 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Sam Ravnborg <sam@ravnborg.org>
cc: Adrian Bunk <bunk@fs.tum.de>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] select FW_LOADER -> depends HOTPLUG
In-Reply-To: <20040810211656.GA7221@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.58.0408120027330.20634@scrub.home>
References: <20040809195656.GX26174@fs.tum.de> <20040809203840.GB19748@mars.ravnborg.org>
 <Pine.LNX.4.58.0408100130470.20634@scrub.home> <20040810084411.GI26174@fs.tum.de>
 <20040810211656.GA7221@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 10 Aug 2004, Sam Ravnborg wrote:

> On Tue, Aug 10, 2004 at 10:44:11AM +0200, Adrian Bunk wrote:
> > 
> > I assume Sam thinks in the direction to let a symbol inherit the 
> > dependencies off all symbols it selects.
> > 
> > E.g. in
> > 
> > config A
> > 	depends on B
> > 
> > config C
> > 	select A
>         depends on Z
> 
>   config Z
>         depends on Y
> > 
> > 
> > C should be treated as if it would depend on B.

There are two problems:
1) If A has no prompt it's not visible and so it's dependency is 'n', this 
means a number of symbols wouldn't be visible anymore.
2) It would change the bahaviour of symbols, which already do multiple 
selects (e.g. CONFIG_INET_AH), the select of CRYPTO would be useless, as 
it would only become visible, when CRYPTO is enabled. This means such 
selects wouldn't be possible anymore.

This really needs a different (but similiar) mechanism, what I have in 
mind is something like this:

config A
	autoselect

config B
	depends on A

For the visibility calculation A is set to y and A is automatically 
selected if any symbol, which depends on A, is enabled.

> Correct. But at the same time I miss some functionality to
> tell me what a given symbol:
> 1) depends on
> 2) selects
> 
> It would be nice in menuconfig to see what config symbol
> that has dependencies and/or side effects. 

xconfig has something like this, if you enable 'Debug Info', although it 
rather dumps the internal representation.
Adding something like this to menuconfig, would mean hacking lxdialog, 
which is rather at the bottom of the list of things I want to do. :)

bye, Roman
