Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264082AbUESHEu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264082AbUESHEu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 03:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264090AbUESHEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 03:04:50 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:12930 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S264082AbUESHEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 03:04:49 -0400
Subject: pte_addr_t size reduction for 64 GB case?
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: riel@redhat.com
Content-Type: text/plain
Organization: 
Message-Id: <1084941731.955.836.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 19 May 2004 00:42:11 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When handling 64 GB on i386, pte_addr_t really only
needs 33 bits to find the PTE. It sure doesn't need
the full 64 bits it is using.

How about cheating a bit? If the pte_addr_t only had
the high 32 bits of the 36-bit pointer, it would point
to a pair of the 8-byte PTEs in a 16-byte chunk of RAM.
Then simply examine the PTEs to see which one is the
correct one.


