Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262333AbVDLTwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262333AbVDLTwW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 15:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262166AbVDLTvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:51:42 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:7928 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262333AbVDLSPE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 14:15:04 -0400
Subject: FUSYN and RT
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: linux-kernel@vger.kernel.org
Cc: inaky.perez-gonzalez@intel.com, mingo@elte.hu
Content-Type: text/plain
Organization: MontaVista
Message-Id: <1113329702.23407.148.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 12 Apr 2005 11:15:02 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just wanted to discuss the problem a little more. From all the
conversations that I've had it seem that everyone is worried about
having PI in Fusyn, and PI in the RT mutex. 

It seems like these two locks are going to interact on a very limited
basis. Fusyn will be the user space mutex, and the RT mutex is only in
the kernel. You can't lock an RT mutex and hold it, then lock a Fusyn
mutex (anyone disagree?). That is assuming Fusyn stays in user space.

The RT mutex will never lower a tasks priority lower than the priority
given to it by locking a Fusyn lock.

At least, both mutexes will need to use the same API to raise and lower
priorities.

The next question is deadlocks. Because one mutex is only in the kernel,
and the other is only in user space, it seems that deadlocks will only
occur when a process holds locks that are all the same type.


Daniel


