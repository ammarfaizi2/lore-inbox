Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262807AbVAFKsD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262807AbVAFKsD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 05:48:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262808AbVAFKsC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 05:48:02 -0500
Received: from [213.146.154.40] ([213.146.154.40]:22180 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262807AbVAFKsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 05:48:00 -0500
Date: Thu, 6 Jan 2005 10:47:59 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-mm2
Message-ID: <20050106104759.GA15842@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050106002240.00ac4611.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050106002240.00ac4611.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +rio-cli-conversion.patch
> +rio_linux-64-bit-workaround.patch

RIO is totally broken on all plattforms, and rio-cli-conversion.patch
makes it even more broken with things like:

-#define disable(oldspl) save_flags (oldspl) 
-#define restore(oldspl) restore_flags (oldspl) 
+#define disable(oldspl) local_irq_save(oldspl);
+#define restore(oldspl) local_irq_restore(oldspl) ;

or

+       if (PortP->gs.flags & ASYNC_CLOSING){ 
+               interruptible_sleep_on(&PortP->gs.close_wait);
+       }

please drop rio-cli-conversion.patch and mark the driver BROKEN to wait
a little before finally removing it unless it'll get a major rewrite.
