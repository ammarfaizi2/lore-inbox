Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263066AbTHVIul (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 04:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263060AbTHVIul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 04:50:41 -0400
Received: from AMarseille-201-1-4-31.w217-128.abo.wanadoo.fr ([217.128.74.31]:55079
	"EHLO gaston") by vger.kernel.org with ESMTP id S263066AbTHVIG3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 04:06:29 -0400
Subject: Re: [power] Improve suspend functions.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Patrick Mochel <mochel@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200308212310.h7LNATLo005881@hera.kernel.org>
References: <200308212310.h7LNATLo005881@hera.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1061539577.18044.41.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 22 Aug 2003 10:06:17 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	
> 	- Allocate a console and stop processes from common code before entering
> 	  state.

Here we need something... We still want (at least I do) to emulate /dev/apm_bios
suspend/resume userland notification (XFree among others uses them, though the
suspend console switch makes that less necessary, it's still something widely
used by existing userland code).

On pmac, I'm doing that from my "old style" notifiers that I call around
the new style ones (my old semantics are a bit different, I have NOTIFY
and SUSPEND, what I do is NOTIFY old stuff, suspend new stuff, then
SUSPEND old stuff, the APM emulation acts on NOTIFY old stuff and my
old stuff having explicit ordering, userland is suspended almost first,
just after the ADB in fact).

I may need a few more hooks in that generic code, I'll let you know once
I have something implemented using it.

Ben.

