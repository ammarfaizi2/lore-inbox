Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268710AbUILMEA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268710AbUILMEA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 08:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268707AbUILL7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 07:59:24 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:41691 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S268672AbUILL52
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 07:57:28 -0400
From: Duncan Sands <baldrick@free.fr>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Writable module parameters - should be volatile?
Date: Sun, 12 Sep 2004 13:57:25 +0200
User-Agent: KMail/1.6.2
Cc: rusty@rustcorp.com.au
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200409121357.25915.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I declare a writable module parameter as follows:

static unsigned int num_rcv_urbs = UDSL_DEFAULT_RCV_URBS;

module_param (num_rcv_urbs, uint, S_IRUGO | S_IWUSR);

Shouldn't I declare num_rcv_urbs volatile?  Otherwise compiler
optimizations could (for example) stick it in a register and miss
any changes made by someone writing to it...  However, if I do
declare it volatile then I get a warning:

In function `__check_num_rcv_urbs':
warning: return discards qualifiers from pointer target type

So what is the right thing to do?

Thanks,

Duncan.
