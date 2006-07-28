Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752030AbWG1QGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752030AbWG1QGp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 12:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752033AbWG1QGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 12:06:45 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:29880 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1752030AbWG1QGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 12:06:44 -0400
Subject: [patch 0/5] Add -fstack-protector support the the kernel
From: Arjan van de Ven <arjan@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, akpm@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 28 Jul 2006 18:06:18 +0200
Message-Id: <1154102778.6416.21.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for the gcc 4.1 -fstack-protector feature
to the kernel. While gcc 4.1 supports this feature for userspace, the
patches to support it for the kernel only got added to the gcc tree on
27/7/2006 (eg for 4.2); it is expected that several distributors will
backport this patch to their 4.1 gcc versions.

-fstack-protector is a security feature in gcc that causes "selected"
functions to store a special "canary" value at the start of the
function, just below the return address. At the end of the function,
just before using this return address with the "ret" instruction, this
canary value is compared to the reference value again. If the value of
the stack canary has changed, it is a sign that there has been some
stack corruption (most likely due to a buffer overflow) that has
compromised the integrity of the return address.

Standard, the "selected" functions are those that actually have stack
buffers of at least 8 bytes, this selection is done to limit the
overhead to only those functions with the highest risk potential. There
is an override to enable this for all functions.

On first sight this would not be needed for the kernel, because the
kernel is "perfect" and "has no buffer overflows on the stack". I
thought that too for a long time, but the last year has shown a few
cases where that would have been overly naive.

This feature has some performance overhead (but it's not that incredibly
expensive either) so it should be a configuration option for those who
want this extra security.

For those people who want to use the gcc 4.1 patch, it can be found at
http://www.fenrus.org/stackprotector/gcc41.patch

