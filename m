Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030392AbWGMVF4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030392AbWGMVF4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 17:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030391AbWGMVF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 17:05:56 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:387 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030392AbWGMVFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 17:05:55 -0400
Subject: Re: [PATCH] Convert idr's internal locking to _irqsave variant
From: Arjan van de Ven <arjan@infradead.org>
To: Roland Dreier <rdreier@cisco.com>
Cc: Andrew Morton <akpm@osdl.org>, mingo@elte.hu, zach.brown@oracle.com,
       openib-general@openib.org, linux-kernel@vger.kernel.org
In-Reply-To: <adau05lrzdy.fsf@cisco.com>
References: <44B405C8.4040706@oracle.com> <adawtajzra5.fsf@cisco.com>
	 <44B433CE.1030103@oracle.com> <adasll7zp0p.fsf@cisco.com>
	 <20060712093820.GA9218@elte.hu> <adaveq2v9gn.fsf@cisco.com>
	 <20060712183049.bcb6c404.akpm@osdl.org> <adau05ltsso.fsf@cisco.com>
	 <20060713135446.5e2c6dd5.akpm@osdl.org>  <adau05lrzdy.fsf@cisco.com>
Content-Type: text/plain
Date: Thu, 13 Jul 2006 23:05:46 +0200
Message-Id: <1152824747.3024.92.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-13 at 14:03 -0700, Roland Dreier wrote:
>  > I suspect it'll get really ugly.  It's a container library which needs to
>  > allocate memory when items are added, like the radix-tree.  Either it needs
>  > to assume GFP_ATOMIC, which is bad and can easily fail or it does weird
>  > things like radix_tree_preload().
> 
> Actually I don't think it has to be too bad.  We could tweak the
> interface a little bit so that consumers do something like:
> 
> 	

it does get harder if this is needed for your IB device to do 
more work, so that your swap device on your IB can take more IO's
to free up ram..


