Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262218AbVCOD0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262218AbVCOD0M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 22:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262219AbVCOD0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 22:26:12 -0500
Received: from gate.crashing.org ([63.228.1.57]:38301 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262218AbVCOD0I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 22:26:08 -0500
Subject: swsusp_restore crap
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 15 Mar 2005 14:24:29 +1100
Message-Id: <1110857069.29123.5.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel !

Please kill that swsusp_restore() call that itself calls
flush_tlb_global(), it's junk. First, the flush_tlb_global() thing is
arch specific, and that's all swsusp_restore() does. Then, the asm just
calls this before returning to C code, so it makes no sense to have a
hook there. The x86 asm can have it's own call to some arch stuff if it
wants or just do the tlb flush in asm...

Ben.


