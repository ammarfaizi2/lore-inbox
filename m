Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261956AbVCAQQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbVCAQQm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 11:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbVCAQQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 11:16:42 -0500
Received: from fire.osdl.org ([65.172.181.4]:17132 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261956AbVCAQQk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 11:16:40 -0500
Date: Tue, 1 Mar 2005 08:17:47 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       vojtech@suse.de
Subject: Re: Breakage from patch: Only root should be able to set the N_MOUSE
 line discipline.
In-Reply-To: <20050301114718.GA5375@ucw.cz>
Message-ID: <Pine.LNX.4.58.0503010814580.25732@ppc970.osdl.org>
References: <200502030209.j1329xTG013818@hera.kernel.org>
 <1109416402.2584.5.camel@localhost.localdomain> <20050301114718.GA5375@ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 1 Mar 2005, Vojtech Pavlik wrote:
>  
> A nonprivileged user could inject mouse movement and/or keystrokes
> (using the sunkbd driver) into the input subsystem, taking over the
> console/X, where another user is logged in.
> 
> Simply using a slightly modified inputattach on a PTY will do the trick.

Might an alternative be to just make writes to N_MOUSE require privileges?

Ie "reading is ok, and changing to N_MOUSE is ok, but tryign to write a 
mouse packet is not"? The check should be easy enough to add to the 
ldisc.write thing?

		Linus
