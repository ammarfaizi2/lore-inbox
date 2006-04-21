Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbWDUXdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbWDUXdd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 19:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbWDUXdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 19:33:33 -0400
Received: from liaag1ae.mx.compuserve.com ([149.174.40.31]:18579 "EHLO
	liaag1ae.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750759AbWDUXdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 19:33:33 -0400
Date: Fri, 21 Apr 2006 19:31:10 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: smp/up alternatives crash when CONFIG_HOTPLUG_CPU
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Gerd Hoffman <kraxel@suse.de>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Message-ID: <200604211932_MC3-1-BDAF-3F61@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060421074858.GA28858@elte.hu>

On Fri, 21 Apr 2006 09:48:58 +0200, Ingo Molnar wrote:

> you can also try the mutex.bad.s file i attached:
> 
>  $ as mutex.s.bad
>  mutex.s.bad: Assembler messages:
>  mutex.s.bad:267: Warning: .space or .fill with negative value, ignored
>  mutex.s.bad:355: Warning: .space or .fill with negative value, ignored
>  mutex.s.bad:412: Warning: .space or .fill with negative value, ignored
>  mutex.s.bad:574: Warning: .space or .fill with negative value, ignored
>  mutex.s.bad:627: Warning: .space or .fill with negative value, ignored

There are six of those in the file: the first one works and the rest fail.
This causes 5 * 16 bytes of fill to be missing from the output file.

Trying to get an assembler listing makes the problem go away:

$ as -o mutex.bad.o mutex.s
mutex.s: Assembler messages:
mutex.s:267: Warning: .space or .fill with negative value, ignored
mutex.s:355: Warning: .space or .fill with negative value, ignored
mutex.s:412: Warning: .space or .fill with negative value, ignored
mutex.s:574: Warning: .space or .fill with negative value, ignored
mutex.s:627: Warning: .space or .fill with negative value, ignored
$ as -al -o mutex.good.o mutex.s >mutex.lst
$ ll mutex*.o
-rw-rw-r--  1 me me 5028 Apr 21 19:24 mutex.bad.o
-rw-rw-r--  1 me me 5108 Apr 21 19:25 mutex.good.o
$ as --version
GNU assembler 2.15.90.0.3 20040415


-- 
Chuck
"Penguins don't come from next door, they come from the Antarctic!"

