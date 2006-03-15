Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932223AbWCOK1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbWCOK1S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 05:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbWCOK1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 05:27:18 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:2749 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932223AbWCOK1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 05:27:18 -0500
Subject: Re: [Patch 3/9] Block I/O accounting initialization
From: Arjan van de Ven <arjan@infradead.org>
To: nagar@watson.ibm.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>
In-Reply-To: <1142297222.5858.13.camel@elinux04.optonline.net>
References: <1142296834.5858.3.camel@elinux04.optonline.net>
	 <1142297222.5858.13.camel@elinux04.optonline.net>
Content-Type: text/plain
Date: Wed, 15 Mar 2006 11:27:15 +0100
Message-Id: <1142418436.3021.13.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>  
> +static inline void delayacct_blkio_start(void)
> +{
> +	if (unlikely(delayacct_on))
> +		__delayacct_blkio_start();
> +}


I still think the unlikely() makes no sense here; at runtime it's either
going to be always on or off (in the sense that switching it will be
RARE). The cpus branch predictor will get that right; while if you force
it unlikely you can even run the risk of getting a 100% miss on some
architectures (not x86/x86-64) when you enable the accounting


