Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277282AbRKFFi7>; Tue, 6 Nov 2001 00:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277094AbRKFFit>; Tue, 6 Nov 2001 00:38:49 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:54288 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S277012AbRKFFih>;
	Tue, 6 Nov 2001 00:38:37 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.4.13-ac8 current() changes
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 06 Nov 2001 16:38:24 +1100
Message-ID: <17745.1005025104@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.13-ac8 changed get_current() to use cr2 instead of esp and
introduced hard_get_current() which uses esp.  The comment on
hard_get_current() in include/asm-i386/smp.h says "for within NMI,
do_page_fault, cpu_init".  But NMI, do_page_fault and cpu_init can
execute other code, any references to current() in that other code will
use get_current() instead of hard_get_current().

How is generic code called from NMI etc. meant to know which version of
current() to use?  Usage of current() is hidden inside a lot of other
macros, this change looks like a data mismatch just waiting to bite us.


