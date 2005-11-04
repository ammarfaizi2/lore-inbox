Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161107AbVKDI5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161107AbVKDI5y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 03:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161115AbVKDI5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 03:57:53 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:52986 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1161107AbVKDI5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 03:57:53 -0500
Message-ID: <436B228D.2000309@fr.ibm.com>
Date: Fri, 04 Nov 2005 09:57:49 +0100
From: Greg <gkurz@fr.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: sigsuspend() and ptrace()
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My program uses gdb to attach to a process and make it execute a specific
function thanks to the gdb 'call' command. This works quite well unless the
attached process is sleeping in sigsuspend(). I peeked into the kernel sources
and saw that the typical sigsuspend() implementation is like this :

while (1) {
	schedule();
	if (do_signal())
		return -EINTR;
}

When using ptrace attach, the target process receives a SIGSTOP but there
isn't *of course* any handler to SIGSTOP. And no way for the process to return
to userland... is it implemented that way on purpose ? How can I make suspending
processes do some *alternative* work with gdb ?

Thanks.

Greg.

