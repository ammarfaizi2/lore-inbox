Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263880AbTLUTBz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 14:01:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263895AbTLUTBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 14:01:55 -0500
Received: from bristol.phunnypharm.org ([65.207.35.130]:46771 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S263880AbTLUTBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 14:01:52 -0500
Date: Sun, 21 Dec 2003 13:31:32 -0500
From: Ben Collins <bcollins@debian.org>
To: M?ns Rullg?rd <mru@kth.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Firewire/sbp2 troubles with Linux 2.6.0
Message-ID: <20031221183132.GP6607@phunnypharm.org>
References: <yw1x8yl66ecs.fsf@ford.guide> <20031221035348.GM6607@phunnypharm.org> <yw1x4qvumozm.fsf@ford.guide> <20031221144813.GN6607@phunnypharm.org> <yw1xn09mkvs9.fsf@ford.guide>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yw1xn09mkvs9.fsf@ford.guide>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I've seen that before with an old card that I had. I was forced to
> > either serialize the serial commands in sbp2, or reduce the max speed to
> > S200.
> 
> Setting serialize_io=1 seems to help.  I managed to read an 800 MB
> file at 10 MB/s.  What's the penalty for setting that?  And isn't 10
> MB/s a little slow for Firewire?

Basically that causes the scsi layer to only send sbp2 1 command at a
time, so it's a performance hit.

I'm guessing that your card doesn't like getting some many commands at
once. It's possible that your sbp2 device itself cannot handle it
(generally, I've found it to be caused by the card though).

As far as 10mbs, you have to remember that even though firewire is much
higher than that, your drive is still an IDE, and the firewire is still
going through an IDE bridge. So the limitation lies in the IDE bridge.
I've seen performance as high as 34MB/s with good IDE bridges and
drives, though.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
