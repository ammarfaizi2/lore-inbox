Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261515AbVFEIAK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261515AbVFEIAK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 04:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261517AbVFEIAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 04:00:09 -0400
Received: from chello212017098056.surfer.at ([212.17.98.56]:40721 "EHLO
	hofr.at") by vger.kernel.org with ESMTP id S261515AbVFEH7s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 03:59:48 -0400
From: Der Herr Hofrat <der.herr@hofr.at>
Message-Id: <200506050754.j557sZD16659@hofr.at>
Subject: 2.4.29 arch/i386/entry.S question
To: linux-kernel@vger.kernel.org
Date: Sun, 5 Jun 2005 09:54:35 +0200 (CEST)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi  !

Kernel 2.4.29 (unpatched)
Arch   i386

 I'm trying to understand the details of what is going on here. As I 
understand this, the cli/sti braces are intended for atomicity of 
need_resched and signals, but what does the comment at the sti them mean ?
can one get to signal_return without entering at ret_from_sys_call ?
I assumed the sti is just balancing the cli - woong ?

arch/i386/kernel/entry.S:

ENTRY(ret_from_sys_call)
	cli				# need_resched and signals atomic test
	cmpl $0,need_resched(%ebx)
	jne reschedule
	cmpl $0,sigpending(%ebx)
	jne signal_return
restore_all:
	RESTORE_ALL

	ALIGN
signal_return:
	sti				# we can get here from an interrupt handler

 Also if need_resched and sigpending were not handled atomically, that is if
one removes the cli/sti - would that actually break anything ? It seems that
it could be inefficient as one would reschedule in cases without this
being necessary, and could call do_signal without that it is needed, or is
there more to it ? I removed the cli/sti and rebuilt the system, but could
not find any imediate problems (which off course does not really say much
yet).

thx !
hofrat
