Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262906AbUC2NAm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 08:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262874AbUC2M7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 07:59:38 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:46479 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262906AbUC2MaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 07:30:15 -0500
Date: Mon, 29 Mar 2004 14:10:03 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jamie Lokier <jamie@shareable.org>
Cc: Nigel Cunningham <ncunningham@users.sourceforge.net>,
       Pavel Machek <pavel@suse.cz>,
       Suspend development list <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: fast compressed fs (was Re: -nice tree)
Message-ID: <20040329121002.GG1453@openzaurus.ucw.cz>
References: <20040323233228.GK364@elf.ucw.cz> <opr5d7ad0b4evsfm@smtp.pacific.net.th> <20040325014107.GB6094@elf.ucw.cz> <200403250857.08920.matthias.wieser@hiasl.net> <1080247142.6679.3.camel@calvin.wpcb.org.au> <20040325222745.GE2179@elf.ucw.cz> <1080250718.6674.35.camel@calvin.wpcb.org.au> <20040327144945.GG21884@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040327144945.GG21884@mail.shareable.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > How?
> 
> Run two parallel tasks: 1. write pages to disk by queuing the I/Os;
> 2. compress unqueued pages.
> 
> The first task won't use much CPU because it's always waiting for disk
> DMAs to complete.  While it sleeps, the second task runs.
> Alternatively this can be implemented using polling for I/O
> completions in the second task, if that's easier.
> 
> The first task should keep the I/O queue full enough to sustain
> writing, but not much fuller than that.  Either a fixed queue length
> will be fine, or it is easy to adjust the queue length dynamically by
> enlarging it if any I/O completions occur when the queue is empty.
> 
> The second task consumes uncompressed pages and makes available
> compressed pages.
> 
> When the first task wants to queue more pages for I/O, it first checks
> the compressed-page list.  If there are any, they are queued,
> otherwise it consumes uncompressed pages.
> 
> This will automatically converge on an optimal balance between
> compressed and uncompressed page writing, provided the disk is using
> DMA, which they do on all modern system.
> 
> This is actually better than fully enabling or disabling compression.

Very clever. This even could be used for a filesystem to make writes faster...
Hmm, compressed fs and *faster* than normal... sounds good.

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

