Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262254AbTHJKdU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 06:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbTHJKdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 06:33:20 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:26044 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S262254AbTHJKdT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 06:33:19 -0400
Message-ID: <3F361F5E.10106@colorfullife.com>
Date: Sun, 10 Aug 2003 12:33:02 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: 4GB+DEBUG_PAGEALLOC oopses with 2.6.0-test3-mm1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

I'm running into crashes in copy_mount_options with 
CONFIG_DEBUG_PAGEALLOC and 4GB in 2.6.0-test3-mm1:

The functions in mm/usercopy assume that no exception handling is 
required if fs is KERNEL_DS. This is not true: at least the mount 
options copy and the i386 traps handler assume exception handling with 
fs==KERNEL_DS.

How should this be fixed? I don't see a simple, portable way to 
implement exception handling for the kernel address space.

--
    Manfred

