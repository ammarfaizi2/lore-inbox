Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265914AbUATXne (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 18:43:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265923AbUATXne
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 18:43:34 -0500
Received: from gate.crashing.org ([63.228.1.57]:52949 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265914AbUATXnc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 18:43:32 -0500
Subject: Re: swsusp does not stop DMA properly during resume
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040120150629.6949eda7.akpm@osdl.org>
References: <20040120224653.GA19159@elf.ucw.cz>
	 <20040120150629.6949eda7.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1074642037.739.49.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 21 Jan 2004 10:40:38 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I _think_ what this patch is doing is suspending all devices from within
> the boot kernel before starting into the resumed kernel.  Is this correct?
> 
> > +	update_screen(fg_console);	/* Hmm, is this the problem? */
> 
> Cryptic comment.  To what "problem" does this refer?

Note that you should make sure all calls to update_screen (among others)
are guarded by the console semaphore, with my VT patch, not doing so
will result in WARN_ON's

Ben.


