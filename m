Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264974AbTLaOQt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 09:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265060AbTLaOQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 09:16:49 -0500
Received: from [199.72.99.40] ([199.72.99.40]:28421 "EHLO blackbox.ecweb.com")
	by vger.kernel.org with ESMTP id S264974AbTLaOQs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 09:16:48 -0500
Subject: 2.6.0-mm2 Surprises
From: Danny Cox <Danny.Cox@ECWeb.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Electronic Commerce Systems
Message-Id: <1072880245.1146.11.camel@vom>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 31 Dec 2003 09:17:26 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've found some surprises in my testing of 2.6.0-mm2 on my RH 9 box.

First, 'make menuconfig' doesn't work.  It paints the top 8 or so lines,
and freezes.  gnome-terminal begins using as much CPU as it's allowed. 
This is similar to bug 959 in bugme.osdl.org, but changing CHILD_PENALTY
from 90 to 130 didn't fix the problem.

Second, simply resizing gnome-terminal results in the same behavior. 
Certainly, this may be a gnome thing.

Third, 'rpm' cannot install packages.  It always exists with:

rpmdb: unable to join the environment
error: db4 error(11) from dbenv->open: Resource temporarily unavailable
error: cannot open Packages index using db3 - Resource temporarily
unavailable (11)
error: cannot open Packages database in /var/lib/rpm

11 is EAGAIN, but an strace revealed little to the uninitiated (me).

rpm also fails in the same way with --rebuilddb.  /var/lib/rpm/__db.001
is zero length BTW.  That is almost certainly wrong.  Of course, these
both work fine with a 2.4.20 kernel.

Sorry if these (or some variant thereof) have already been reported
here.

Thanks for your time, and please note that I'm not subscribed to
linux-kernel.  If you need more info, please don't hesitate to ask.

-- 
Daniel S. Cox
Electronic Commerce Systems

