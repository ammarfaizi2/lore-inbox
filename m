Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031827AbWLGIJj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031827AbWLGIJj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 03:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031828AbWLGIJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 03:09:39 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:39588
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1031827AbWLGIJi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 03:09:38 -0500
Date: Thu, 07 Dec 2006 00:09:50 -0800 (PST)
Message-Id: <20061207.000950.28414823.davem@davemloft.net>
To: dhowells@redhat.com
CC: viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: cmpxchg() in kernel/workqueue.c breaks things
From: David Miller <davem@davemloft.net>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


David, you have to fix the locking scheme used in kernel/workqueue.c,
you absolutely cannot assume that cmpxchg() is available on all
platforms.  This breaks the build on the platforms that don't
have such an instruction, and no it cannot emulated.

Also, because Alan Cox's machine (zeniv) went down, a few folks such
as Al Viro (CC:'d) had no opportunity to comment on your changes
before they went in.  This mess would have been avoided if Al had a
chance to read over this, in particular since he does cross sparc32
builds he knows that cmpxchg is not available there.
