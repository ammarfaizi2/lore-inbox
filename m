Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263926AbTKTH2C (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 02:28:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264027AbTKTH2C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 02:28:02 -0500
Received: from c-213-160-43-40.customer.ggaweb.ch ([213.160.43.40]:9221 "EHLO
	sco01.cobalt.webhostings.ch") by vger.kernel.org with ESMTP
	id S263926AbTKTH2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 02:28:00 -0500
Message-ID: <3FBC6728.7030504@sensaco.com>
Date: Thu, 20 Nov 2003 08:03:04 +0100
From: George Fankhauser <gfa@sensaco.com>
Reply-To: gfa@sensaco.com
Organization: http://www.sensaco.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: setcontext syscall
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there!

I wonder why linux i386 does not implement setcontext as a syscall. 
Instead it's in in glibc in userspace.

The problem that one may run into is with asynchronous signals such as 
SIGALRM, VTALRM, and IO: Let's say you have good reason to block such 
signals because your handling one of them and want to restore another 
user context which has them enabled in its sigmask. What sigcontext 
simply does is
1. trap into sigprocmask
2. restore all regs and jump
after exit of 1) until jump in 2) there is plenty of time to run into 
another asynchronous signal which must be detected in the nested handler 
etc. This is rather ugly.
I see this as a main reason to put setcontext into the kernel. Another 
one is performance: since we use sigprocmask, a syscall is used anyway.
And BTW: All SysV implementations use indeed syscalls for set/getcontext 
for these reasons.

What do you think?

regards
George
-- 
Sensaco GmbH
mailto:gfa@sensaco.com

