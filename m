Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262514AbUCRKxI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 05:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262515AbUCRKxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 05:53:08 -0500
Received: from 213-187-164-3.dd.nextgentel.com ([213.187.164.3]:61450 "EHLO
	ford.pronto.tv") by vger.kernel.org with ESMTP id S262514AbUCRKxF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 05:53:05 -0500
To: linux-kernel@vger.kernel.org
Subject: [BUG] alignment problem in net/core/flow.c:flow_key_compare
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: Thu, 18 Mar 2004 11:53:02 +0100
Message-ID: <yw1x8yhyv33l.fsf@kth.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a problem with alignment in the flow_key_compare function in
net/core/flow.c.  It takes arguments of type struct flowi * and casts
them to flow_compare_t *, which is 64 bits on 64-bit machines.  It
then proceeds to read and compare 64-bit values from these pointers.
The problem is that struct flowi only requires 32-bit alignment, so
these reads cause numerous unaligned exceptions.  On average, I get
nearly 1000 unaligned exceptions per second.

The solutions I see are either to force the alignment of struct flowi
to 64 bits, or to use 32-bit access in flow_key_compare.

-- 
Måns Rullgård
mru@kth.se
