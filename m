Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262387AbUJ0KmP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262387AbUJ0KmP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 06:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262393AbUJ0KiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 06:38:25 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:49383 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262375AbUJ0Kek (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 06:34:40 -0400
Subject: NFS and recalc_sigpending() semantics?
From: Greg Banks <gnb@melbourne.sgi.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Silicon Graphics Inc, Australian Software Group.
Message-Id: <1098873273.1985.180.camel@hole.melbourne.sgi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 27 Oct 2004 20:34:33 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

G'day,

Can someone please explain to me why recalc_sigpending() fails
to clear the TIF_SIGPENDING flag if the pending signal is a
coredumping signal like SIGQUIT?  Is this deliberate?

I ask because there's code in the NFS client like this:

---> got here because signal_pending() is set <----
	spin_lock_irqsave(&current->sighand->siglock, flags);
	oldset = current->blocked;
	sigfillset(&current->blocked);
	recalc_sigpending();
	spin_unlock_irqrestore(&current->sighand->siglock, flags);
---> assumes signal_pending() is cleared <----

Have these semantics changed, or has NFS always been broken?

Greg.
-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.


