Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264118AbTKZKKH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 05:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264120AbTKZKKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 05:10:06 -0500
Received: from enigma.barak.net.il ([212.150.48.99]:7326 "EHLO
	enigma.barak.net.il") by vger.kernel.org with ESMTP id S264118AbTKZKKD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 05:10:03 -0500
From: "Amir Hermelin" <amir@montilio.com>
To: <linux-kernel@vger.kernel.org>
Subject: PG_reserved bug
Date: Wed, 26 Nov 2003 12:09:58 +0200
Organization: Montilio
Message-ID: <001501c3b405$75d49c90$1d01a8c0@CARTMAN>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I've found a bug in the 2.4.20 kernel (might have appeared before), that if
the PG_reserved flag is set on a page, its reference count will be
incremented but won't be decremented.  This is due to the wrong order of
lazy if tests in __free_pages().

I have two questions:
1.  How do I report it?  I found no maintainer for MM in MAINTAINERS
2.  I'm writing a module that gets pages (via __get_free_pages) and holds
them throughout its lifetime.  Where must I check if this page can be taken
from under me, without using the reserved bit?  In other words, if I want to
make sure the behavior is the same with or without the reserved bit, what
must I maintain?

Thanks,
Amir.


