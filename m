Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266485AbUITNP5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266485AbUITNP5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 09:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266488AbUITNP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 09:15:57 -0400
Received: from nessie.weebeastie.net ([220.233.7.36]:10624 "EHLO
	theirongiant.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S266485AbUITNPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 09:15:55 -0400
Date: Mon, 20 Sep 2004 23:15:18 +1000
From: CaT <cat@zip.com.au>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Olaf Hering <olh@suse.de>, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org
Subject: Re: OOM & [OT] util-linux-2.12e
Message-ID: <20040920131518.GA1096@zip.com.au>
References: <UTC200409192205.i8JM52C25370.aeb@smtp.cwi.nl> <20040920094602.GA24466@suse.de> <Pine.LNX.4.61.0409201220200.3460@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0409201220200.3460@scrub.home>
Organisation: Furball Inc.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2004 at 12:23:30PM +0200, Roman Zippel wrote:
> > > then /etc/mtab can die. Comments? Better solutions?
> > 
> > Andries, /etc/mtab is obsolete since the day when /proc/self/mounts was
> > introduced. So, kill it today from your mount binary! TODAY. ...
> 
> How do you distinguish between manual and automatic loop device setup?
> How do you filter /proc/mounts for chroot environments?

My apologies if something like this is already in the source. Just
throwing out an idea to the wolves. ;)

>From /proc/self/mounts I take it that that's meant to be a list of 
mountpoints the requesting process sees. So... why not have instances
of mountlists. The default is what the kernel starts with and each
process inherits. The chroot creates a 2nd instance so that any
processes spawned from that one see the mountlist from that instance.

Each process would, obviously, inherit the mountlist instance from
its parent. 

The hassle happens when you want to deal with the process that began
an instance dieing without taking its children out with it. One way
to deal with it would be to introduce a counter, but that would 
require locking to keep it serialised.

-- 
    Red herrings strewn hither and yon.
