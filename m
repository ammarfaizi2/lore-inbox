Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261859AbVAYHsz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261859AbVAYHsz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 02:48:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261860AbVAYHsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 02:48:55 -0500
Received: from asplinux.ru ([195.133.213.194]:38158 "EHLO relay.asplinux.ru")
	by vger.kernel.org with ESMTP id S261859AbVAYHsw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 02:48:52 -0500
Message-ID: <41F5F98C.7020004@sw.ru>
Date: Tue, 25 Jan 2005 10:47:24 +0300
From: Vasily Averin <vvs@sw.ru>
Organization: SW-soft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021224
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Marcelo Tosatti <marcello.tosatti@cyclades.com>,
       Andrey Melnikov <temnota+kernel@kmv.ru>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] Prevent NMI oopser
X-Enigmail-Version: 0.70.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcello, Andrey

I believe this patch is wrong.
First, it prevent nothing: NMI watchdog is a signal that you wait too 
long with disabled interrupts. Your controller was not answered too 
long, obviously it is a hardware issue.
Second, you could not call schedule() with io_request_lock spinlock taken.

You should unlock io_request_lock before msleep, like in latest versions 
of megaraid2 drivers.

Please fix it.

Thank you,
      Vasily Averin, SWSoft Linux Kernel Team

# ChangeSet
#   2005/01/19 14:16:32-02:00 temnota@kmv.ru
#   [PATCH] Prevent NMI oopser from triggering when megaraid2 waits
#   for abort/reset cmd completion
#
#   > We should backport msleep() in 2.4.29-pre1.
#
#   Ok, msleep() backported, but driver isn't fixed. This patch
#   acceptable?
#
#   Prevent NMI oopser kill kernel thread when megaraid2 driver waiting
#   abort or reset command completion.
#
#   Signed-off-by: Andrey Melnikov <temnota+kernel@kmv.ru>


