Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751179AbWBRMOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbWBRMOM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 07:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWBRMOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 07:14:12 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:19143 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751170AbWBRMOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 07:14:11 -0500
Date: Sat, 18 Feb 2006 12:14:02 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       paulmck@us.ibm.com, dada1@cosmosbay.com, davem@davemloft.net,
       netdev@vger.kernel.org
Subject: Re: [PATCH 2/2] fix file counting
Message-ID: <20060218121402.GB911@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dipankar Sarma <dipankar@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, paulmck@us.ibm.com,
	dada1@cosmosbay.com, davem@davemloft.net, netdev@vger.kernel.org
References: <20060217154147.GL29846@in.ibm.com> <20060217154337.GM29846@in.ibm.com> <20060217154626.GN29846@in.ibm.com> <20060218010414.1f8d6782.akpm@osdl.org> <20060218092517.GP29846@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060218092517.GP29846@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > - Make the get_max_files export use _GPL - only unix.ko uses it.

The real question is, does af_unix really need to allow beeing built
modular?  It's quite different from other network protocol and deeply
tied to the kernel due to things like descriptor passing or using
the filesystem namespace.  I already had to export another symbol that
really should be internal just for it, and if one module acquires lots
of such hacks it's usually a bad sign..

