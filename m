Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262734AbTIEOvl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 10:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262854AbTIEOvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 10:51:41 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59349 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262734AbTIEOvj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 10:51:39 -0400
Date: Fri, 5 Sep 2003 15:51:24 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Jan Ischebeck <mail@jan-ischebeck.de>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm@osdl.org, torvalds@osdl.org
Subject: Re: 2.6.0-test4-mm6
Message-ID: <20030905145124.GF454@parcelfarce.linux.theplanet.co.uk>
References: <1062766000.2081.11.camel@JHome.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1062766000.2081.11.camel@JHome.uni-bonn.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 05, 2003 at 02:46:40PM +0200, Jan Ischebeck wrote:
> Seems like I got the reason for X not starting:
> 
> pseudo terminals can't be acquired and only two consoles are running.
> 
> -> X11 can't get console Vt7
> -> pppd doesn't work either
> 
> This definitely worked with -mm5.

Grr...  Dumb typo.  Patch below should fix that...

diff -urN B4-misc3/drivers/char/tty_io.c B4-current/drivers/char/tty_io.c
--- B4-misc3/drivers/char/tty_io.c	Thu Sep  4 02:19:38 2003
+++ B4-current/drivers/char/tty_io.c	Fri Sep  5 10:46:59 2003
@@ -1334,7 +1334,7 @@
 		return -ENODEV;
 	}
 
-	if (device == MKDEV(TTY_MAJOR,2)) {
+	if (device == MKDEV(TTYAUX_MAJOR,2)) {
 #ifdef CONFIG_UNIX98_PTYS
 		/* find a device that is not in use. */
 		retval = -1;
