Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263134AbUEVCqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263134AbUEVCqr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 22:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264633AbUEVCqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 22:46:47 -0400
Received: from node1.nsp.NJ.us.style.net ([209.246.126.88]:39129 "EHLO
	style.net") by vger.kernel.org with ESMTP id S263134AbUEVCqq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 22:46:46 -0400
From: "Spinka, Kristofer" <kspinka@style.net>
Subject: Unserializing ioctl() system calls
To: linux-kernel@vger.kernel.org
X-Mailer: CommuniGate Pro WebUser Interface v.4.1.8
Date: Fri, 21 May 2004 22:46:45 -0400
Message-ID: <web-1649994@style.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that even in the 2.6.6 code, callers to ioctl 
system call (sys_ioctl in fs/ioctl.c) are serialized with 
{lock,unlock}_kernel().

I realize that many kernel modules, and POSIX for that 
matter, may not be ready to make this more concurrent.

I propose adding a flag to indicate that the underlying 
module would like to support its own concurrency 
management, and thus we avoid grabbing the BKL around the 
f_op->ioctl call.

The default behavior would adhere to existing standards, 
and if the flag is present (in the underlying module), we 
let the module (or modules) handle it.

Reasonable?

   /kristofer
