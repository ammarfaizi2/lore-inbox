Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161243AbWGNGUi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161243AbWGNGUi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 02:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161279AbWGNGUi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 02:20:38 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:2755 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161243AbWGNGUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 02:20:37 -0400
Subject: Re: [PATCH] Convert idr's internal locking to _irqsave variant
From: Arjan van de Ven <arjan@infradead.org>
To: Roland Dreier <rdreier@cisco.com>
Cc: Andrew Morton <akpm@osdl.org>, mingo@elte.hu, zach.brown@oracle.com,
       openib-general@openib.org, linux-kernel@vger.kernel.org
In-Reply-To: <adad5c9rqd5.fsf@cisco.com>
References: <44B405C8.4040706@oracle.com> <adawtajzra5.fsf@cisco.com>
	 <44B433CE.1030103@oracle.com> <adasll7zp0p.fsf@cisco.com>
	 <20060712093820.GA9218@elte.hu> <adaveq2v9gn.fsf@cisco.com>
	 <20060712183049.bcb6c404.akpm@osdl.org> <adau05ltsso.fsf@cisco.com>
	 <20060713135446.5e2c6dd5.akpm@osdl.org> <adau05lrzdy.fsf@cisco.com>
	 <1152824747.3024.92.camel@laptopd505.fenrus.org>
	 <adad5c9rqd5.fsf@cisco.com>
Content-Type: text/plain
Date: Fri, 14 Jul 2006 08:20:26 +0200
Message-Id: <1152858026.3159.7.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-13 at 17:18 -0700, Roland Dreier wrote:
>     Arjan> it does get harder if this is needed for your IB device to
>     Arjan> do more work, so that your swap device on your IB can take
>     Arjan> more IO's to free up ram..
> 
> That's the classic problem, but it's more a matter of the consumer
> using GFP_NOIO in the right places.

GFP_NOIO isn't going to save you in the cases where the memory really is
running low and you need the memory to do more IO...


