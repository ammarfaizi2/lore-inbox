Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261361AbSJCV1D>; Thu, 3 Oct 2002 17:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261371AbSJCV1D>; Thu, 3 Oct 2002 17:27:03 -0400
Received: from air-2.osdl.org ([65.172.181.6]:50071 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S261361AbSJCV1C>;
	Thu, 3 Oct 2002 17:27:02 -0400
Date: Thu, 3 Oct 2002 14:34:42 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: Matthew Dobson <colpatch@us.ibm.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [rfc][patch] driverfs multi-node(board) patch [2/2]
In-Reply-To: <3D98F450.8080003@us.ibm.com>
Message-ID: <Pine.LNX.4.44.0210031428280.1871-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, I'm finally getting back to you..

> 	Ok..  here are the real changes.  I'd really like to get some feedback on 
> what you (or anyone else) thinks of these proposed changes.  This sets 
> up a generic topology initialization routine which should discover all 
> online nodes (boards), CPUs, and Memory Blocks at boot time.  It also 
> makes the CPUs and memblks it discovers children of the appropriate nodes.

You didn't append the patch, which is annoying, but I'll deal..

The main problem I have is the code placement. I put the CPU stuff under 
arch/ because I anticpate wrapping the cpu structure with an arch-specific 
one, so you can ascertain arch-specific information via the generic 
structure. Moving it out of arch/ precludes that from happening (easily). 

Ditto for memblks, though I'm not really sure what other info you'd want 
in the structures. 

Ditto+ for nodes, or boards. Those are definitely arch-specific 
structures, and shouldn't be in drivers/base/. On top of that, I don't 
think their registration should all be munged together in one file. Maybe 
they should be, in their own play area (under arch/i386/mach-ccnuma/).


	-pat

