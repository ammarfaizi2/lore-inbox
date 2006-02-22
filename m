Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161226AbWBVSEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161226AbWBVSEa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 13:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161263AbWBVSEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 13:04:30 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:48841 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1161226AbWBVSE3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 13:04:29 -0500
Date: Wed, 22 Feb 2006 18:04:23 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Zeuthen <david@fubar.dk>, Kay Sievers <kay.sievers@suse.de>,
       Pekka J Enberg <penberg@cs.Helsinki.FI>, Greg KH <gregkh@suse.de>,
       Adrian Bunk <bunk@stusta.de>, Robert Love <rml@novell.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       John Stultz <johnstul@us.ibm.com>
Subject: Re: 2.6.16-rc4: known regressions
Message-ID: <20060222180423.GD27946@ftp.linux.org.uk>
References: <1140383653.11403.8.camel@localhost> <20060220010205.GB22738@suse.de> <1140562261.11278.6.camel@localhost> <20060221225718.GA12480@vrfy.org> <Pine.LNX.4.58.0602220905330.12374@sbz-30.cs.Helsinki.FI> <20060222152743.GA22281@vrfy.org> <Pine.LNX.4.64.0602220737170.30245@g5.osdl.org> <1140625103.21517.18.camel@daxter.boston.redhat.com> <Pine.LNX.4.64.0602220848280.30245@g5.osdl.org> <Pine.LNX.4.64.0602220915500.30245@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602220915500.30245@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 09:31:59AM -0800, Linus Torvalds wrote:
> Why the hell anybody would care about what the command transport type is, 
> when all that matters is that it's a block device, I don't understand. The 
> exact details of what kind of block device it is are totally secondary, 
> and shouldn't affect basic desktop behaviour.

Actually, it's not about transport, it's about command _set_.  So there
is legitimate userland code that would want to know that (especially since
a lot of external enclosures have incredibly brittle and crappy firmware
and go tits-up when they see anything they don't recognize), but
	a) the last thing that code wants is to have TYPE_RBC mislabeled
as TYPE_DISK and
	b) hal has nothing to do with that.

The only place where _transport_ enters the picture is that RBC is very common
in e.g. firewire-to-IDE bridges, so sbp2 had to deal with it somehow.  And
instead of teaching sd.c to deal with those (it's very easy) it went ahead
and just marked those as type 0 (disk).  Almost worked...
