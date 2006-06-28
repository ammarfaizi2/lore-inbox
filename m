Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030480AbWF1JLD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030480AbWF1JLD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 05:11:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030486AbWF1JLD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 05:11:03 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:18588 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030480AbWF1JLB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 05:11:01 -0400
Subject: Re: [Patch] jbd commit code deadloop when installing Linux
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Zou Nan hai <nanhai.zou@intel.com>, linux-kernel@vger.kernel.org,
       mingo@elte.hu
In-Reply-To: <20060627234005.dda13686.akpm@osdl.org>
References: <1151470123.6052.17.camel@linux-znh>
	 <20060627234005.dda13686.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 28 Jun 2006 11:10:56 +0200
Message-Id: <1151485856.3153.18.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-27 at 23:40 -0700, Andrew Morton wrote:
> On 28 Jun 2006 12:48:43 +0800
> Zou Nan hai <nanhai.zou@intel.com> wrote:
> 
> > We see system hang in ext3 jbd code
> > when Linux install program anaconda copying 
> > packages. 
> > 
> > That is because anaconda is invoked from linuxrc 
> > in initrd when system_state is still SYSTEM_BOOTING.
> > 
> > Thus the cond_resched checks in  journal_commit_transaction 
> > will always return 1 without actually schedule, 
> > then the system fall into deadloop.
> 
> That's a bug in cond_resched().

hummm while this fix is needed... something makes me want to think that
something as complex as an OS installer really shouldn't be running with
SYSTEM_BOOTING state anymore.... 
shouldn't we start considering running the initrd (esp now with klibc)
as SYSTEM_RUNNING ?

