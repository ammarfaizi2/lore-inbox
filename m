Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751180AbWBRMbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbWBRMbp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 07:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbWBRMbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 07:31:45 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:21922 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751180AbWBRMbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 07:31:44 -0500
Subject: Re: [PATCH 2/2] fix file counting
From: Arjan van de Ven <arjan@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Dipankar Sarma <dipankar@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, paulmck@us.ibm.com, dada1@cosmosbay.com,
       davem@davemloft.net, netdev@vger.kernel.org
In-Reply-To: <20060218121402.GB911@infradead.org>
References: <20060217154147.GL29846@in.ibm.com>
	 <20060217154337.GM29846@in.ibm.com> <20060217154626.GN29846@in.ibm.com>
	 <20060218010414.1f8d6782.akpm@osdl.org> <20060218092517.GP29846@in.ibm.com>
	 <20060218121402.GB911@infradead.org>
Content-Type: text/plain
Date: Sat, 18 Feb 2006 13:31:30 +0100
Message-Id: <1140265890.4035.17.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-02-18 at 12:14 +0000, Christoph Hellwig wrote:
> > > - Make the get_max_files export use _GPL - only unix.ko uses it.
> 
> The real question is, does af_unix really need to allow beeing built
> modular?  It's quite different from other network protocol and deeply
> tied to the kernel due to things like descriptor passing or using
> the filesystem namespace.  I already had to export another symbol that
> really should be internal just for it, and if one module acquires lots
> of such hacks it's usually a bad sign..

in 2.4 the answer would have been simple; modutils back then used
AF_UNIX stuff before it could load modules, so modular was in practice
impossible. 

Anyway I'd agree with making this non-modular... NOBODY will use this as
a module, or if they do loading it somehow is the very first thing done.
You just can't live without this, so making it a module is non-sensical.


