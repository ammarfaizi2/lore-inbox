Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266289AbTGJHfv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 03:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266294AbTGJHfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 03:35:51 -0400
Received: from mailout11.sul.t-online.com ([194.25.134.85]:10931 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id S266289AbTGJHfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 03:35:50 -0400
Message-Id: <5.1.0.14.2.20030710091328.00ab78f8@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 10 Jul 2003 09:44:35 +0200
To: linux-kernel@vger.kernel.org
From: margitsw@t-online.de (Margit Schubert-While)
Subject: Re: [PATCH] 2.4.22-pre3: P3 and P4 for chekc_gcc
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Seen: false
X-ID: STlRW8ZFYeh1YE-mHPLPTvOvIv40YU9GSkvEhnuxE+dawgI14fZ6s1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Been using this in production for over 9 months.
It's interesting to note that, for AMD's, the check has been there for a 
long time.

For GCC3, there is another problem.
It does not inline what it should inline.
(Classic example is the ubiquitous copy_(from/to)_user with constant size)

You need either to add "-finline-limit=<n>" to the options
and/or add this into compiler.h
+#if (__GNUC__ > 3) || (__GNUC__ == 3 && __GNUC_MINOR__ >= 1)
+#define inline         __inline__ __attribute__((always_inline))
+#define __inline__     __inline__ __attribute__((always_inline))
+#define __inline       __inline__ __attribute__((always_inline))
+#endif


Margit 

