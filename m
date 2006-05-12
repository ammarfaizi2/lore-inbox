Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbWELQrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbWELQrJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 12:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932150AbWELQrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 12:47:09 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:45910 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932154AbWELQrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 12:47:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=THpGPI7tlLyrNxMu1CKpgtuCql2derMkCNchewADwTq+ugw6w7KuaN1VfBtGaiijBthVA7peaEZVQUqxPYFToNC3PUt953KyctfWL0QO1BDX80KIOe1t4H3LffjWcd6A4QXcH9crOWmM7R8TmJ9RKsjviRsjI+dLqJt78XHbq/A=
Date: Fri, 12 May 2006 20:45:46 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: linux-kernel@vger.kernel.org, bill@crowellsystems.com,
       bugme-daemon@osdl.org, Eric Moore <eric.moore@lsil.com>
Subject: Re: [Bug 6537] New: #ifdef CONFIG_PM causes MPT to not compile
Message-ID: <20060512164546.GA16827@mipter.zuzino.mipt.ru>
References: <4464A2AE.9080905@mbligh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4464A2AE.9080905@mbligh.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2006 at 07:58:54AM -0700, Martin J. Bligh wrote:
> Problem Description: /drivers/message/fusion/mpt* using #ifdef CONFIG_PM
> are not exporting the mpt_suspend mpt_resume.

> Steps to reproduce: compile the kernel. causes a kernel compilation failure.
>
> Steps to fix:
> comment out the #ifdef CONFIG_pm and corresponding #endif to disable this
> compilation flag. recompile and the world is happy.

This patch fixes your anonymous compilation problems?

[PATCH] mptspi: fix compilation with CONFIG_PM=n

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

--- a/drivers/message/fusion/mptspi.c
+++ b/drivers/message/fusion/mptspi.c
@@ -831,6 +831,7 @@ mptspi_ioc_reset(MPT_ADAPTER *ioc, int r
 	return rc;
 }
 
+#ifdef CONFIG_PM
 /*
  * spi module resume handler
  */
@@ -846,6 +847,7 @@ mptspi_resume(struct pci_dev *pdev)
 
 	return rc;
 }
+#endif
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/

