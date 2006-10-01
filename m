Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932173AbWJANYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbWJANYX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 09:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbWJANYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 09:24:23 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:3722 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932146AbWJANYW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 09:24:22 -0400
Message-ID: <451FC182.6000502@garzik.org>
Date: Sun, 01 Oct 2006 09:24:18 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: chas@cmf.nrl.navy.mil, Netdev List <netdev@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: ATM bug found
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike 98% of the warnings of this type, this gcc warning does indeed 
seem to indicate a bug:

drivers/atm/zatm.c: In function ‘zatm_open’:
drivers/atm/zatm.c:919: warning: ‘pcr’ may be used uninitialized in this 
function

If alloc_shaper() argument 'unlimited' is true, then pcr is never 
assigned a value.  However, the caller of alloc_shaper() always tests 
the pcr value, regardless of whether or not 'unlimited' is true.

	Jeff


