Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbTDUUcm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 16:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbTDUUcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 16:32:42 -0400
Received: from pointblue.com.pl ([62.89.73.6]:39176 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S261851AbTDUUcl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 16:32:41 -0400
Subject: Re: [PATCH] 2.5.68-bk1 crash in devfs_remove() for defpts files
From: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
To: Pavel Roskin <proski@gnu.org>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.55.0304211630230.2599@marabou.research.att.com>
References: <Pine.LNX.4.55.0304211338540.1491@marabou.research.att.com>
	 <20030421195555.A28583@lst.de> <20030421195847.A28684@lst.de>
	 <Pine.LNX.4.55.0304211451110.1798@marabou.research.att.com>
	 <20030421210020.A29421@lst.de>
	 <Pine.LNX.4.55.0304211539350.2462@marabou.research.att.com>
	 <20030421215637.A30019@lst.de>
	 <Pine.LNX.4.55.0304211630230.2599@marabou.research.att.com>
Content-Type: text/plain
Organization: K4 labs
Message-Id: <1050957875.1224.2.camel@flat41>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 21 Apr 2003 21:44:35 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-04-21 at 21:35, Pavel Roskin wrote:
> > Oh, I see now.  There's a longstanding bug in the handling of
> > TTY_DRIVER_NO_DEVFS that got exposed by this.
> >
> > Please try this patch additionally:
> 
> Applied.  Now I can log in by ssh and there are no problems with
> pseudoterminals.  However, all local terminals are gone:
> 
> INIT: Id "1" respawning too fast: disabled for 5 minutes
> INIT: Id "2" respawning too fast: disabled for 5 minutes
> INIT: Id "3" respawning too fast: disabled for 5 minutes
> INIT: Id "5" respawning too fast: disabled for 5 minutes
> INIT: Id "4" respawning too fast: disabled for 5 minutes
> INIT: Id "6" respawning too fast: disabled for 5 minutes
> INIT: Id "S0" respawning too fast: disabled for 5 minutes
> INIT: no more processes left in this runlevel
> 
you must mount devpts in /dev/pts
and change inittab :
[snip]
# Note that on most Debian systems tty7 is used by the X Window System,
# so if you want to add more getty's go ahead but skip tty7 if you run
X.
#
1:2345:respawn:/sbin/getty 38400 /dev/vc/1
2:23:respawn:/sbin/getty 38400 /dev/vc/2
3:23:respawn:/sbin/getty 38400 /dev/vc/3
4:23:respawn:/sbin/getty 38400 /dev/vc/4
5:23:respawn:/sbin/getty 38400 /dev/vc/5
6:23:respawn:/sbin/getty 38400 /dev/vc/6
[snip]

to use devfs only, it is funny but fe to open /dev/sound/* you need to
be root, or chmod it manually before use. (i've got seperate
/etc/init.d/chdevfsmod file to do that)

> The only entry under /dev/vc is /dev/vc/0.  /dev/tts is missing.
-- 
Grzegorz Jaskiewicz <gj@pointblue.com.pl>
K4 labs

