Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbULMXGO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbULMXGO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 18:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261348AbULMXGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 18:06:14 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:44804 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261347AbULMXGI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 18:06:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=iTHuioKv/80VQuWibjeCr9C6cLv0M4X/Hcf+TxfdqoMj1bb2945VjIw4INT4lT37LE/hRl7NLdw/GsoZFvpb2wDTnmz4K3dWap3RmuYD5g5E4OXMajfAdMx8F6Bydqzr5ErvMGKNy4DOiT9WEL1kATho7Jsb0XajuOQFCD9b6U0=
Message-ID: <4de0ceaa04121315064b9643c1@mail.gmail.com>
Date: Mon, 13 Dec 2004 21:06:08 -0200
From: Kalaky <kalaky@gmail.com>
Reply-To: Kalaky <kalaky@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC] sigpending rework
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Currently, queued RT signals go into a list of pending signals
for a given task_struct (multiple RT signals can be queued).
When an process dequeues a signal through sigwaitinfo()
we must search the list for the given signal. This search is
always O(n) where n is the number of pending signals,
since we must go through all list members to ensure if
a signal number is still pending.

I'm working on converting the sigpending structure into a vector
of _NSIG sigqueue's for each signal number (which is quite a big
work), this way we can directly access each signal list, delivering
and checking any pending signals in a efficient manner.

Any thoughts ?

TIA,

Kalaky
