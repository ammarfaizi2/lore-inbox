Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262465AbTF0ITf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 04:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262584AbTF0ITf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 04:19:35 -0400
Received: from [193.112.238.6] ([193.112.238.6]:28098 "EHLO caveman.xisl.com")
	by vger.kernel.org with ESMTP id S262465AbTF0ITf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 04:19:35 -0400
Message-ID: <3EFC016A.7080207@xisl.com>
Date: Fri, 27 Jun 2003 09:33:46 +0100
From: John M Collins <jmc@xisl.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Minor Bug with System 5 Semaphores
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please CC me on any reply as I'm not subscribed.

I've come across what seems to me to be a minor bug on System 5 semaphores.

When a process which has used a set of semaphores exits, the process id 
of the exiting process is assigned to the "sempid" of every semaphore in 
the set, not just the ones that the process has changed.

This seems to me because in kernel 2.4.21/ipc/sem.c line 1062

sem->sempid = current->pid;

should be made conditional on u->semadj[i] being non-zero.

Personally I think it would be useful to omit this assignment altogether 
and have the "sempid" value reflect the last explicit semaphore 
operation rather than the implicit ones caused by "undos".

-- 
John Collins Xi Software Ltd www.xisl.com


