Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266529AbUAWIVc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 03:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266538AbUAWIVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 03:21:32 -0500
Received: from gate.crashing.org ([63.228.1.57]:56026 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266529AbUAWIVb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 03:21:31 -0500
Subject: Re: swsusp vs  pgdir
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <ncunningham@users.sourceforge.net>,
       Patrick Mochel <mochel@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040123075451.GB211@elf.ucw.cz>
References: <1074833921.975.197.camel@gaston>
	 <20040123073426.GA211@elf.ucw.cz> <1074843781.878.1.camel@gaston>
	 <20040123075451.GB211@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1074846066.789.3.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 23 Jan 2004 19:21:19 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Now, I'm apparently rewriting swapper_pg_dir with itself (same
> data). That's not too clean, but CPUs do not notice it...

Well... ok, you _hope_ it's same data :) I suppose with same kernel,
same text and same amount of RAM, you indeed have the same data, though
this is a bit hairy.

For PPC, I have to go to a different way though. I'll probably end up
allocating a small hash table for G5 like CPUs on resume outside of
the space that gets overwriten, though that is definitely a bit nasty,
since the minimum size of a hash table is 256K, so I'll need that
contiguous at least...

For now, I'm just disabling the data translation on the MMU and
assume the BAT is covering me for resume, but that's a bit hairy
too and definitely slow on some CPUs 

Ben.


