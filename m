Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262149AbTJASdn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 14:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262337AbTJASdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 14:33:09 -0400
Received: from smtp5.wanadoo.nl ([194.134.35.176]:26886 "EHLO smtp5.wanadoo.nl")
	by vger.kernel.org with ESMTP id S261681AbTJAScD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 14:32:03 -0400
Date: Wed, 1 Oct 2003 20:31:45 +0200
From: Sander van Malssen <svm@kozmix.org>
To: davej@redhat.com
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix leak in btaudio
Message-ID: <20031001183145.GA5380@kozmix.org>
Mail-Followup-To: Sander van Malssen <svm@kozmix.org>,
	davej@redhat.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
References: <E1A41Rq-0000NM-00@hardwired>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1A41Rq-0000NM-00@hardwired>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 29 September 2003 at 18:04:34 +0100, davej@redhat.com wrote:

> +			pci_free_consistent(bta->pci, bta->buf_size, bta->buf_cpu, bta->dma);


Surely bta->dma must be bta->buf_dma, like so:


--- linux-2.6/sound/oss/btaudio.c.~1~	2003-09-30 14:11:13.000000000 +0200
+++ linux-2.6/sound/oss/btaudio.c	2003-10-01 20:28:47.000000000 +0200
@@ -178,7 +178,7 @@
 		bta->risc_cpu = pci_alloc_consistent
 			(bta->pci, bta->risc_size, &bta->risc_dma);
 		if (NULL == bta->risc_cpu) {
-			pci_free_consistent(bta->pci, bta->buf_size, bta->buf_cpu, bta->dma);
+			pci_free_consistent(bta->pci, bta->buf_size, bta->buf_cpu, bta->buf_dma);
 			bta->buf_cpu = NULL;
 			return -ENOMEM;
 		}




Cheers,
Sander

-- 
     Sander van Malssen -- svm@kozmix.org -- http://www.kozmix.org/
      http://www.peteandtommysdayout.com/ -- http://www.1-2-5.net/
