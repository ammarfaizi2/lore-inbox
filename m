Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbTJASg1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 14:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261946AbTJASg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 14:36:26 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:7014 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S261943AbTJASgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 14:36:13 -0400
Date: Wed, 1 Oct 2003 19:35:40 +0100
From: Dave Jones <davej@redhat.com>
To: Sander van Malssen <svm@kozmix.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix leak in btaudio
Message-ID: <20031001183540.GE25612@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Sander van Malssen <svm@kozmix.org>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <E1A41Rq-0000NM-00@hardwired> <20031001183145.GA5380@kozmix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031001183145.GA5380@kozmix.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 01, 2003 at 08:31:45PM +0200, Sander van Malssen wrote:
 > On Monday, 29 September 2003 at 18:04:34 +0100, davej@redhat.com wrote:
 > 
 > > +			pci_free_consistent(bta->pci, bta->buf_size, bta->buf_cpu, bta->dma);
 > 
 > 
 > Surely bta->dma must be bta->buf_dma, like so:
 > 
 > 
 > --- linux-2.6/sound/oss/btaudio.c.~1~	2003-09-30 14:11:13.000000000 +0200
 > +++ linux-2.6/sound/oss/btaudio.c	2003-10-01 20:28:47.000000000 +0200
 > @@ -178,7 +178,7 @@
 >  		bta->risc_cpu = pci_alloc_consistent
 >  			(bta->pci, bta->risc_size, &bta->risc_dma);
 >  		if (NULL == bta->risc_cpu) {
 > -			pci_free_consistent(bta->pci, bta->buf_size, bta->buf_cpu, bta->dma);
 > +			pci_free_consistent(bta->pci, bta->buf_size, bta->buf_cpu, bta->buf_dma);
 >  			bta->buf_cpu = NULL;
 >  			return -ENOMEM;
 >  		}


Good eyes. Yes, looks correct to me.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
