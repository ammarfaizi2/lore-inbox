Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbTJINaF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 09:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262177AbTJINaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 09:30:05 -0400
Received: from [64.238.111.222] ([64.238.111.222]:23936 "EHLO Borogove")
	by vger.kernel.org with ESMTP id S262176AbTJIN37 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 09:29:59 -0400
Subject: 2.6.0 mouse events across suspend-to-disk
From: Josh Litherland <josh@emperorlinux.com>
Reply-To: josh@emperorlinux.com
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Emperor Linux
Message-Id: <1065706196.2085.17.camel@Borogove>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 09 Oct 2003 09:29:57 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is probably an XFree bug, but it's only triggered by
suspend-to-disk so I thought I'd at least mention it.  I have my X11
configured to read core pointer events from /dev/input/mice and
/dev/psaux.  Since the PS/2 mouse now feeds the input layer, it's
reasonable to suspect that I might be getting some redundancy of events
when I migrate this config to 2.6.  However, XFree seemed to be able to
pick this out at startup time and would correctly see the two dev nodes
as the same mouse, registering each event only once.  After resuming
from suspend-to-disk, however, all mouse events would occur twice. 
Shutting down and restarting X corrected this, chvt'ing out and back in
did not correct it.  The 'correct' fix seems to be making X only watch
/dev/input/mice for events.

FWIW, the laptop is a Toshiba Portege 3490CT, and I noted this behaviour
on test6 and test7 before realizing it was probably X's fault.  =D

-- 
Josh Litherland (josh@emperorlinux.com)
