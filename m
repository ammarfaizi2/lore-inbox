Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262207AbVDFNYS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262207AbVDFNYS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 09:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262205AbVDFNXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 09:23:50 -0400
Received: from zork.zork.net ([64.81.246.102]:26246 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S262207AbVDFNVi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 09:21:38 -0400
From: Sean Neakums <sneakums@zork.net>
To: rml@novell.com
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.12-rc2-mm1: inotify and directory removal
Mail-Followup-To: rml@novell.com, linux-kernel@vger.kernel.org
Date: Wed, 06 Apr 2005 14:21:37 +0100
Message-ID: <6uacocvy5a.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: sneakums@zork.net
X-SA-Exim-Scanned: No (on zork.zork.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using your glib sample thingy from
http://www.kernel.org/pub/linux/kernel/people/rml/inotify/glib/

  $ mkdir snozzberries
  Event on wd=0: snozzberries, a directory, was created
  $ rmdir snozzberries
  Event on wd=0: snozzberries, a directory, was deleted

  $ mkdir snozzberries
  Event on wd=0: bunneh, a directory, was created
  $ rm -r snozzberries
  Event on wd=0: The watch was opened

Also seen, watching a directory after some other traffic:

  $ mkdir snozzberries
  Event on wd=0: snozzberries, a directory, was created
  $ rm -r snozzberries
  Event on wd=0: The watch was opened
  Event on wd=0:  was closed (was not writable)

If I use absolute paths the rmdir/mkdir case is the same.
However:

  $ mkdir ~/tmp/snozzberries
  Event on wd=0: snozzberries, a directory, was created
  $ rm -r ~/tmp/snozzberries
  Event on wd=0: snozzberries was opened

-- 
Dag vijandelijk luchtschip de huismeester is dood
