Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932284AbWB0I3U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbWB0I3U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 03:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932291AbWB0I3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 03:29:20 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:12951 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932284AbWB0I3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 03:29:19 -0500
Subject: Re: [Patch 5/7]  synchronous block I/O delays
From: Arjan van de Ven <arjan@infradead.org>
To: nagar@watson.ibm.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
In-Reply-To: <1141028448.5785.64.camel@elinux04.optonline.net>
References: <1141026996.5785.38.camel@elinux04.optonline.net>
	 <1141028448.5785.64.camel@elinux04.optonline.net>
Content-Type: text/plain
Date: Mon, 27 Feb 2006 09:29:17 +0100
Message-Id: <1141028957.2992.61.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> +static inline void delayacct_blkio(void)
> +{
> +	if (unlikely(current->delays && delayacct_on))
> +		__delayacct_blkio();
> +}

why is this unlikely?

> +	u64 blkio_delay;	/* wait for sync block io completion */

this misses O_SYNC, msync(), and general throttling.
I get the feeling this is being measured at the wrong level
currently.... since the number of entry points that needs measuring at
the current level is hardly finite...


