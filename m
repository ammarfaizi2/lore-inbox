Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161153AbWFVOi4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161153AbWFVOi4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 10:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbWFVOi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 10:38:56 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:57538 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751113AbWFVOiz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 10:38:55 -0400
Date: Thu, 22 Jun 2006 16:35:44 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, Linux/m68k <linux-m68k@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: m68k patch queue
Message-ID: <Pine.LNX.4.64.0606221216130.12900@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

For anyone interested at http://www.xs4all.nl/~zippel/m68k/ is my current 
patch queue for 2.6.18, one for current git and one for -mm.

Most of the patches are m68k specific and so shouldn't be a big problem.
Below are the patches which cause a conflict in -mm and where I'd 
aprreciate feedback the most.

One larger merge I finally like to get finished are the thread_info 
changes, most direct accesses to thread_info are gone by now, but a few 
sneaked back in:

- 0021-M68K-wrap-thread_info-access-in-mutex.txt

The mutex code is in a constant flux and the simplest fix is to do just do
s/\(\w*\)->thread_info/task_thread_info(\1)/ with kernel/mutex*c before 
the following patches are applied.
Ingo, could you please do this also in your tree/patches?


- 0023-M68K-Rename-thread_info.txt
- 0024-M68K-Rename-alloc-free-_thread_info.txt

There is only a minor conflict with pi-futex-rt-mutex-core.patch, so it's 
not really a problem.


The last part in the queue is a major cleanup of the m68k irq code, which 
gets it a lot closer to the generic irq code (although it's still a bit 
different) and results in a nice reduction of duplicated source. There is 
only one conflict here:

- 0031-M68K-convert-generic-irq-code-to-irq-controller.txt

This one conflicts with adjust-handle_irr_event-return-type.patch and I'm 
not sure about its status, especially since it's still without any 
response to the comments. Anyway, here I'd prefer to just drop the m68k 
specific part from it.


bye, Roman

