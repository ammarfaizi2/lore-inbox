Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964978AbWALCCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964978AbWALCCN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 21:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964983AbWALCCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 21:02:13 -0500
Received: from po.harenet.ne.jp ([210.167.64.67]:15317 "EHLO po.harenet.ne.jp")
	by vger.kernel.org with ESMTP id S964978AbWALCCL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 21:02:11 -0500
Date: Thu, 12 Jan 2006 11:02:49 +0900 (JST)
Message-Id: <20060112.110249.46098125.psbfan@po.harenet.ne.jp>
To: linux-kernel@vger.kernel.org
Subject: about sanitize_e820_map()
From: Toshiyuki Ishii <psbfan@po.harenet.ne.jp>
X-Mailer: Mew version 3.3 on XEmacs 21.1.8 (Bryce Canyon)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Good evening.
I am Toshiyuki Ishii at Kurashiki in Japan.

I am a beginner of kernel source code,
so sorry if I am misunderstanding.

In sanitize_e820_map(),
When sorting change_point[] by address and swapping
two maps that represets the same memory region
and have a different address, end address for privious change_point
and start address for current change_point,
"if" statement is

if ((change_point[i]->addr < change_point[i-1]->addr) ||

     ((change_point[i]->addr == change_point[i-1]->addr) &&
      (change_point[i]->addr == change_point[i]->pbios->addr) &&
      (change_point[i-1]->addr != change_point[i-1]->pbios->addr))

There are two conditions and I think the first one is sorting by address.
I have a qestion in the second condition.

I think second line

change_point[i]->addr == change_point[i]->pbios->addr

checks that current change_point represents start address.
and third line

change_point[i-1]->addr != change_point[i-1]->pbios->addr

checks that previous change_point represents end address.
If this "if" statement intends to swap maps for "the same" region
that match these condition, the first line should be

change_point[i]->pbios->addr == change_point[i-1]->pbios->addr

I think.

Am I wrong?

