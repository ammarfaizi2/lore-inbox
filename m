Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751130AbWCXV47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbWCXV47 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 16:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbWCXV47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 16:56:59 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:7723 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751130AbWCXV47 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 16:56:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=i7qVuYF9MUwZ00CZNZYvIZCxTEjYHLaFcfo+GMaTCXsUmT2f92tQOMZO/T5sLCFKdfytRqGw0AX9CvCOp5d4+h5SKMW90ABJU80eebmmxwHhVe6F+elGFw+V5e1yV9xcEfcxiijXu+0Tgr2bWgAtjwtKBbeWUJklecmLIlcfwIw=
Message-ID: <ff1cadb20603241356j7257f826n@mail.gmail.com>
Date: Fri, 24 Mar 2006 22:56:58 +0100
From: "Luca Falavigna" <dktrkranz@gmail.com>
To: mingo@elte.hu
Subject: SPIN_LOCK_UNLOCKED
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I noticed you recently changed the way you handle SPIN_LOCK_UNLOCKED macro.
Former version was something like that:

#define SPIN_LOCK_UNLOCKED(lockname) \
	(spinlock_t) { { __SPIN_LOCK_UNLOCKED(lockname) } }

while current version is:

# define SPIN_LOCK_UNLOCKED \
	(spinlock_t) { { __SPIN_LOCK_UNLOCKED } }

I noticed your 2.6.16-rt6 patch includes two calls to
SPIN_LOCK_UNLOCKED(lockname) macro, the first one in
arch/powerpc/kernel/rtas.c and the last one in
include/asm-powerpc/rwsem.h.
Is this the right behaviour?

Regards,

--
Luca
