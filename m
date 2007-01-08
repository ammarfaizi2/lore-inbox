Return-Path: <linux-kernel-owner+w=401wt.eu-S1161261AbXAHMdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161261AbXAHMdm (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 07:33:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161264AbXAHMdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 07:33:42 -0500
Received: from relay.gothnet.se ([82.193.160.251]:8525 "EHLO
	GOTHNET-SMTP2.gothnet.se" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1161261AbXAHMdl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 07:33:41 -0500
X-Greylist: delayed 10772 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Jan 2007 07:33:41 EST
From: thomas@tungstengraphics.com
To: davej@redhat.com
Cc: arjan@infradead.org, linux-kernel@vger.kernel.org
Subject: agpgart: drm-populated memory types
Reply-To: thomas@tungstengraphics.com
Date: Mon, 08 Jan 2007 10:33:37 +0100
Message-Id: <11682488182899-git-send-email-thomas@tungstengraphics.com>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <1166533877.3365.1244.camel@laptopd505.fenrus.org>
References: <1166533877.3365.1244.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave and Arjan,

I'm resending a slightly reworked version of the apgart patch for drm-populated
memory types.

The address- based vmalloc / vfree has been replaced and encapsulated in
agp-vkmalloc / agp vkfree which both takes a flag argument to indicate
whether to use vmalloc or kmalloc. This, at least, gets rid of the 
portability problem, and the chances of running into trouble in the future
will be small if all allocs / frees of these memory areas are done using
these functions.

A short recap why I belive the kmalloc / vmalloc construct is necessary:

0) The current code uses vmalloc only.
1) The allocated area ranges from 4 bytes possibly up to 512 kB, depending on
on the size of the AGP buffer allocated.
2) Large buffers are very few. Small buffers tend to be quite many. 
   If we continue to use vmalloc only or another page-based scheme we will
   waste approx one page per buffer, together with the added slowness of
   vmalloc. This will severely hurt applications with a lot of small
   texture buffers.

Please let me know if you still consider this unacceptable. 
In that case I suggest sticking with vmalloc for now.

Also please let me know if there are other parths of the patch that should be
reworked.

The patch that follows is against Dave's agpgart repo.

Regards,

Thomas




