Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261637AbULBRty@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261637AbULBRty (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 12:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261686AbULBRtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 12:49:53 -0500
Received: from adsl-63-194-133-30.dsl.snfc21.pacbell.net ([63.194.133.30]:32640
	"EHLO penngrove.fdns.net") by vger.kernel.org with ESMTP
	id S261637AbULBRtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 12:49:43 -0500
From: John Mock <kd6pag@qsl.net>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
cc: Pavel Machek <pavel@suse.cz>
Subject: re: 2.6.10-rc2 on VAIO laptop and PowerMac 8500/G3
Message-Id: <E1CZv5H-0001zG-00@penngrove.fdns.net>
Date: Thu, 02 Dec 2004 09:49:39 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, this one has taint from forced module load... If you can
> reproduce it without that, it would be nice to decrease number of
> modules in use, perhaps one of them is a problem?

The diagnosis is correct, the removing the forced module unload prevents
the recursive page fault from happening.  The HOWEVER, i find it troubling
that it is even possible for the page fault handling code to get page
faults...

The problem is with the 'sonypi' module, which i will document separately.
It was being removed/re-installed to prevent the jog wheel from being
broken after software suspend under X windows.  It currently unloads
without forcing on '2.6.10-rc1' but not '2.6.10-rc2'.  If that is moved
to after the software suspend, then the recursive page fault doesn't
happen (until the next suspend).
				    -- JM
