Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbUCAKEb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 05:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261154AbUCAKEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 05:04:31 -0500
Received: from moutng.kundenserver.de ([212.227.126.173]:25543 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261152AbUCAKEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 05:04:30 -0500
Date: Mon, 1 Mar 2004 11:04:26 +0100 (MET)
From: Armin Schindler <armin@melware.de>
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: workqueue function must be reentrant ?
Message-ID: <Pine.LNX.4.31.0403011054040.29362-100000@phoenix.one.melware.de>
Organization: Cytronics & Melware
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:4f0aeee4703bc17a8237042c4702a75a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

with the new workqueue the kernel 2.6 provides, I thought I can remove
my drivers kernel-thread. But looking at the workqueue code, it seems
my workqueue-function must be reentrant on SMP.

Not like the tasklet (where it is guaranteed that another
tasklet_schedule() will put the tasklet-function onto a queue which will not
be executed while another instance of my tasklet-function is still running)
the workqueue function may be put onto the queue of another cpu and get
called while the first one is still running on the first cpu.

Is that correct?
If yes, is it a bug or a feature?

Should I go back to my own kernel-thread to have a user-context-function
SMP-safe?

Thanks for any hint
Armin


