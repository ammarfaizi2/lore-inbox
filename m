Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751152AbVKNPbG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbVKNPbG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 10:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbVKNPbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 10:31:06 -0500
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:30644 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S1751152AbVKNPbF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 10:31:05 -0500
Message-ID: <4378ADB2.7040905@rtr.ca>
Date: Mon, 14 Nov 2005 10:30:58 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051013 Debian/1.7.12-1ubuntu1
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.xx:  dirty pages never being sync'd to disk?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, this one's been nagging me since I first began using 2.6.xx.

My Notebook computer has 2GB of RAM, and the 2.6.xx kernel seems quite
happy to leave hundreds of MB of dirty unsync'd pages laying around
more or less indefinitely.  This worries me, because that's a lot of data
to lose should the kernel crash (which it has once quite recently)
or the battery die.

/proc/sys/vm/dirty_expire_centisecs = 3000 (30 seconds)
/proc/sys/vm/dirty_writeback_centisecs = 500 (5 seconds)

My understanding (please correct if wrong) is that this means
that any (file data) page which is dirtied, should get flushed
back to disk after 30 seconds or so.

That doesn't happen here.  Hundreds of MB of dirty pages just
hang around indefinitely, until I manually type "sync",
at which point the hard drive gets very busy for 20 seconds or so.

What's going on?
