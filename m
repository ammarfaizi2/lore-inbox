Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030201AbWCQQRL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030201AbWCQQRL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 11:17:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030204AbWCQQRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 11:17:11 -0500
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:48526 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1030201AbWCQQRK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 11:17:10 -0500
Subject: [Patch 0/8] Port of -fstack-protector to the kernel
From: Arjan van de Ven <arjan@linux.intel.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 17 Mar 2006 17:10:50 +0100
Message-Id: <1142611850.3033.100.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for the gcc 4.1 -fstack-protector feature to
the kernel. Unfortunately this needs a gcc patch before it can work, so at
this point these patches are just for comment, not for merging.

-fstack-protector is a security feature in gcc that causes "selected" functions
to store a special "canary" value at the start of the function, just below
the return address. At the end of the function, just before using this
return address with the "ret" instruction, this canary value is compared to
the reference value again. If the value of the stack canary has changed, it is a sign
that there has been some stack corruption (most likely due to a buffer overflow) that
has compromised the integrity of the return address.

Standard, the "selected" functions are those that actually have stack
buffers of at least 8 bytes, this selection is done to limit the overhead to
only those functions with the highest risk potential. There is an override to enable this
for all functions.

On first sight this would not be needed for the kernel, because the kernel
is "perfect" and "has no buffer overflows on the stack". I thought that too
for a long time, but the last year has shown a few cases where that would
have been overly naive.

