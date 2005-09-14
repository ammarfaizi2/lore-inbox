Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965167AbVINMvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965167AbVINMvW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 08:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965169AbVINMvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 08:51:21 -0400
Received: from relay3.mail.ox.ac.uk ([163.1.2.165]:7553 "EHLO
	relay3.mail.ox.ac.uk") by vger.kernel.org with ESMTP
	id S965167AbVINMvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 08:51:20 -0400
Date: Wed, 14 Sep 2005 13:51:18 +0100
From: Ian Collier <Ian.Collier@comlab.ox.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: 2.6.13: More on drivers/block/loop.c
Message-ID: <20050914135118.A25087@pixie.comlab>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20050909132725.C23462@pixie.comlab>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050909132725.C23462@pixie.comlab>; from Ian.Collier@comlab.ox.ac.uk on Fri, Sep 09, 2005 at 01:27:26PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vanilla 2.6.13 doesn't crash.

However, unpack a fresh copy of 2.6.13, edit include/linux/loop.h to
change LO_KEY_SIZE from 32 to 1844, and *boom*.  [Don't ask me why
1844... that's just what PPDD wants.]

It's crashing somewhere in loop_set_status_old, probably during the
call to copy_from_user, but the crash messages aren't that helpful as
they are different each time, often seem to happen during an interrupt,
and usually contain pages of recursive calls to do_page_fault and
error_code.

The loop_set_status_old function has two local variables, each of which
is now 1812 bytes longer than it was, and I'm wondering if it's a stack
overflow problem.  How much stack is a kernel function allowed to use,
anyway?

Replacing these variables with kmalloc'd pointers seems to stop the crashes
anyway, so I'll pass that tip on to the PPDD folks.

imc
