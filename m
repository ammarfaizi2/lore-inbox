Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030229AbWJTNMQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030229AbWJTNMQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 09:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030260AbWJTNMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 09:12:16 -0400
Received: from [81.2.110.250] ([81.2.110.250]:7580 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1030229AbWJTNMP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 09:12:15 -0400
Subject: Re: [PATCH 2.6.19-rc2] [REVISED 2] drivers/media/video/se401.c:
	check kmalloc() return value.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Amit Choudhary <amit2030@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20061019221642.d10bae34.amit2030@gmail.com>
References: <20061019221642.d10bae34.amit2030@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 20 Oct 2006 14:14:58 +0100
Message-Id: <1161350098.26440.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-10-19 am 22:16 -0700, ysgrifennodd Amit Choudhary:
> Description: Check the return value of kmalloc() in function se401_start_stream(), in file drivers/media/video/se401.c.
> 
> Signed-off-by: Amit Choudhary <amit2030@gmail.com>

This actually isn't needed for the first case as SE401_NUMSBUF is 1 but
the second fix is needed. Both are right and useful to merge in case
NUMSBUF is ever changed.

If you know se401->sbuf[] and se401->scratch , urb etc are being cleared
to NULL (or you did that) you could just use the kfree loops in nomem_
for all cases as kfree(NULL) is an allowed "no-op"


