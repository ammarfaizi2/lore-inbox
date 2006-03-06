Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752393AbWCFSbo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752393AbWCFSbo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 13:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752390AbWCFSbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 13:31:44 -0500
Received: from liaag2ad.mx.compuserve.com ([149.174.40.155]:53994 "EHLO
	liaag2ad.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751549AbWCFSbn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 13:31:43 -0500
Date: Mon, 6 Mar 2006 13:25:54 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: spin_lock_irqsave only re-enables interrupts while spinning
  on some archs?
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200603061327_MC3-1-B9F7-26DD@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On some architectures, spin_lock_irqsave() re-enables interrupts when
spinning while waiting for the lock to become available.  The list
of archs includes i386, powerpc and ia64.  Others leave interrupts
disabled while spinning (x86_64, arm, alpha).  They just define
__raw_spin_lock_flags to be the same as __raw_spin_lock.  (And
because predication is so efficient, ia64 does the opposite:
it uses __raw_spin_lock_flags for everything -- a neat trick.)

Shouldn't there be a standard way of doing this?  Is there any practical
difference in behavior?

-- 
Chuck
"Penguins don't come from next door, they come from the Antarctic!"
