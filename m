Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263655AbUD2Hnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263655AbUD2Hnl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 03:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263663AbUD2Hnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 03:43:41 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:7591 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S263655AbUD2Hnj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 03:43:39 -0400
Subject: Re: [PATCH] s390 (9/9): no timer interrupts in idle.
To: dipankar@in.ibm.com
Cc: akpm@osdl.org, hch@infradead.org, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.11   July 24, 2002
Message-ID: <OF03FE1BAD.C55CA638-ONC1256E85.0029C585-C1256E85.002A6C10@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Thu, 29 Apr 2004 09:43:21 +0200
X-MIMETrack: Serialize by Router on D12ML062/12/M/IBM(Release 6.0.2CF2|July 23, 2003) at
 29/04/2004 09:43:22
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





> Looks good except that I am wondering if idle_cpu_mask should
> really be called nohz_cpu_mask. That is what it is, after all.

I don't thinks so. The idle_cpu_mask isn't dependent on the
no hz timer feature. I think it would make sense to set the
bits in idle_cpu_mask even on system that use the normal hz timer.
The tricky part is to find a way to clear the bits again after
a wakeup interrupt. This needs to be done before the interrupt
function is executed, you can't do it in idle().

blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com


