Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262908AbVCWUh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262908AbVCWUh1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 15:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261961AbVCWUh0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 15:37:26 -0500
Received: from aun.it.uu.se ([130.238.12.36]:55014 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262908AbVCWUgq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 15:36:46 -0500
Date: Wed, 23 Mar 2005 21:36:27 +0100 (MET)
Message-Id: <200503232036.j2NKaRTq019068@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: david@gibson.dropbear.id.au
Subject: Re: [PATCH 2.6.12-rc1-mm1 3/3] perfctr: 64-bit values in register descriptors
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Mar 2005 14:34:30 +1100, David Gibson wrote:
>On Wed, Mar 23, 2005 at 04:00:03AM +0100, Mikael Pettersson wrote:
>> - <linux/perfctr.h>: Change value fields in register descriptors
>>   to 64 bits. This will be needed for ppc64, and ppc32 user-space
>>   on ppc64 kernels, and may eventually also be needed on x86.
>>   We could have different descriptor types for 32 and 64-bit
>>   registers, but that just complicates things for no real benefit.
>> 
>> Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>
>
>Erm.. won't this stop i386 binaries working on an x86_64 kernel, since
>kernel and user will have different ideas of the alignment...?

Indeed it does. A brown paper bag occasion :-(

Andrew, please apply the following fix on top of the previous patch.
This has been tested with i386 binaries on an x86_64 kernel.

- <linux/perfctr.h>: Change number fields in register descriptors to 64 bits.
  Otherwise i386 binaries break on x86_64 kernels since the descriptors
  get larger alignment and sizes on x86_64 than on i386.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 include/linux/perfctr.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -rupN linux-2.6.12-rc1-mm1.perfctr-update-common/include/linux/perfctr.h linux-2.6.12-rc1-mm1.perfctr-update-common-fix/include/linux/perfctr.h
--- linux-2.6.12-rc1-mm1.perfctr-update-common/include/linux/perfctr.h	2005-03-23 20:59:47.000000000 +0100
+++ linux-2.6.12-rc1-mm1.perfctr-update-common-fix/include/linux/perfctr.h	2005-03-23 20:59:57.000000000 +0100
@@ -29,7 +29,7 @@ struct vperfctr_control {
 
 /* common description of an arch-specific control register */
 struct perfctr_cpu_reg {
-	__u32 nr;
+	__u64 nr;
 	__u64 value;
 };
 
