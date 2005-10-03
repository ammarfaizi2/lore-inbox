Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932718AbVJCXtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932718AbVJCXtJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 19:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932726AbVJCXtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 19:49:08 -0400
Received: from science.horizon.com ([192.35.100.1]:15676 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S932718AbVJCXtH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 19:49:07 -0400
Date: 3 Oct 2005 19:49:00 -0400
Message-ID: <20051003234900.27066.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix TASK_STOPPED vs TASK_NONINTERACTIVE interaction
Cc: torvalds@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Any CPU I can think of has a "and + compare against zero". x86 calls it 
> "test", although a regular "and" will do it too. ppc has "andi.". alpha 
> comparisons are against registers being zero or not, so again it's an 
> "and".

About the only one for which "cmp" is faster than "test" is the 680x0.
"cmp" is a subtract that doesn't write the result (except to the condition
codes).  "tst" (called "bit" on the VAX and 6502) is a similar AND.

The 68k doesn't have that.  You have to obliterate one of the operands,
and it can't be the immediate operand, so it's often two instructions.

The 68k does have an instruction called "test", but it just sets the
condition codes based on a single operand (since it doesn't set the
condition codes on a simple move).

It *does* have a single-bit test instruction, which evaluates
"if (x & 1<<y)" in one cycle, but that doesn't help for multi-bit masks
like "if (x % 4096 == 0)"
