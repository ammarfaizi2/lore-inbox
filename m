Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267986AbUIVVmV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267986AbUIVVmV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 17:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267987AbUIVVmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 17:42:21 -0400
Received: from main.gmane.org ([80.91.229.2]:49597 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S267986AbUIVVmT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 17:42:19 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Stefan Seyfried <seife@suse.de>
Subject: Re: 2.6.9-rc2-mm2
Date: Wed, 22 Sep 2004 23:02:43 +0200
Message-ID: <4151E873.9020308@suse.de>
References: <20040922131210.6c08b94c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: charybdis-ext.suse.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.2) Gecko/20040906
X-Accept-Language: en-us, en
In-Reply-To: <20040922131210.6c08b94c.akpm@osdl.org>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Andrew Morton wrote:

> swsusp-fix-highmem.patch
>   swsusp: fix highmem

this one should actually be

@@ -854,8 +854,10 @@ int swsusp_suspend(void)
  	local_irq_disable();
  	save_processor_state();
  	error = swsusp_arch_suspend();
+	/* Restore control flow magically appears here */
  	restore_processor_state();
+	restore_highmem();
  	local_irq_enable();
  	return error;

so that local_irq_enable() is _after_ restore_highmem(). It took Pavel 
and me quite some time to debug the mysterious crashes on some highmem 
machines...

     Stefan

