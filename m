Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751309AbWIILTc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbWIILTc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 07:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbWIILTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 07:19:32 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:34726 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751309AbWIILTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 07:19:31 -0400
Subject: [0/6] 'make headers_check' fixes for 2.6.18
From: David Woodhouse <dwmw2@infradead.org>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sat, 09 Sep 2006 12:18:53 +0100
Message-Id: <1157800733.2977.40.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Our implementation of 'make headers_check' is currently _extremely_
simple -- all it does is check that none of the exported header files
are trying to include other header files which aren't also exported.

Mostly, this happens when the unexported headers aren't actually needed
from the user-visible part of the file which includes them. The fix is 
usually to move the #include so that it sits inside the #ifdef __KERNEL__
where it's actually used. A few minor fixes follow, to fix 'make
headers_check' in 2.6.18 at least for selected architectures...

-- 
dwmw2

