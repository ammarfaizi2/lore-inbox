Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262718AbTEMDxN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 23:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262728AbTEMDxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 23:53:13 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14263 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262718AbTEMDxM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 23:53:12 -0400
Date: Tue, 13 May 2003 05:05:57 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 must-fix list, v2
Message-ID: <20030513040557.GV10374@parcelfarce.linux.theplanet.co.uk>
References: <20030512155417.67a9fdec.akpm@digeo.com> <20030512155511.21fb1652.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030512155511.21fb1652.akpm@digeo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 12, 2003 at 03:55:11PM -0700, Andrew Morton wrote:
> 
> drivers/char/
> -------------
> 
> - TTY locking is broken.

No shit.  Locking, refcounting, serial drivers, yada, yada.  Currently it's
the worst widely-used subsystem in the tree - both 2.4 and 2.5 (and 2.2 is
not much better).  I've got some cleanups, but that will have to go slowly
and carefully - otherwise we'll destroy the last remnants of 2.0 race
prevention logics in there and that's the only thing that makes the current
code kinda-sorta work most of the time.

>   - see FIXME in do_tty_hangup().  This causes ppp BUGs in local_bh_enable()
> 
>   - Other problems: aviro, dipankar, Alan have details.

BTW, somebody will have to document the tty driver and ldisc API.
