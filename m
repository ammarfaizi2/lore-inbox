Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262294AbULCQCZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262294AbULCQCZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 11:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262303AbULCQCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 11:02:25 -0500
Received: from chello083144090118.chello.pl ([83.144.90.118]:29967 "EHLO
	plus.ds14.agh.edu.pl") by vger.kernel.org with ESMTP
	id S262294AbULCQCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 11:02:22 -0500
From: =?utf-8?q?Pawe=C5=82_Sikora?= <pluto@pld-linux.org>
To: linux-kernel@vger.kernel.org
Subject: [arm] __arch__swab32.
Date: Fri, 3 Dec 2004 17:02:19 +0100
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412031702.20313.pluto@pld-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This function reverses the bytes in a word.
The method was discovered in 1986 following a competition between
ARM programmers. It requires just 4 instructions and 1 work register.

unsigned long reverse(unsigned long v)
{
 unsigned long t;
 t = v ^ ((v << 16) | (v >> 16)); // EOR r1,r0,r0,ROR #16     [*]
 t &= ~0xff0000;    // BIC r1,r1,#&ff0000
 v = (v << 24) | (v >> 8);  // MOV r0,r0,ROR #8
 return v ^ (t >> 8);   // EOR r0,r0,r1,LSR #8
}

Could we use the asm. optimized version instead of the generic ___swab32?

[*] http://gcc.gnu.org/PR18560

-- 
/* Copyright (C) 2003, SCO, Inc. This is valuable Intellectual Property. */

                           #define say(x) lie(x)
