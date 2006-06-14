Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbWFNSs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbWFNSs2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 14:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbWFNSs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 14:48:28 -0400
Received: from mtagate5.uk.ibm.com ([195.212.29.138]:51655 "EHLO
	mtagate5.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1750745AbWFNSs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 14:48:27 -0400
Date: Wed, 14 Jun 2006 20:47:57 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [patch 7/8] lock validator: s390 use raw_spinlock in mcck handler
Message-ID: <20060614184757.GA10391@osiris.ibm.com>
References: <20060614142318.GH1241@osiris.boeblingen.de.ibm.com> <20060614182516.GB31243@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060614182516.GB31243@elte.hu>
User-Agent: mutt-ng/devel-r802 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2006 at 09:25:16PM +0200, Ingo Molnar wrote:
> 
> * Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
> 
> > From: Heiko Carstens <heiko.carstens@de.ibm.com>
> > 
> > Machine checks on s390 are always enabled (except in the machine check 
> > handler itself). Therefore use a raw_spinlock in the machine check 
> > handler to avoid deadlocks in the lock validator.
> 
> hm, couldnt you use the ->lockdep_recursion mechanism to take care of 
> such cases? Just call lockdep_off() when entering a machine exception 
> handler, and lockdep_on() when exiting it.

Ah, sure. Wasn't aware that there is such an interface. Will do.
