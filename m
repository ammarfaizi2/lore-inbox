Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423238AbWF1JSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423238AbWF1JSs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 05:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932569AbWF1JSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 05:18:48 -0400
Received: from mga03.intel.com ([143.182.124.21]:2138 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S932539AbWF1JSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 05:18:48 -0400
X-IronPort-AV: i="4.06,186,1149490800"; 
   d="scan'208"; a="58521141:sNHT157543484"
Subject: Re: [Patch] jbd commit code deadloop when installing Linux
From: Zou Nan hai <nanhai.zou@intel.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       mingo@elte.hu
In-Reply-To: <1151485856.3153.18.camel@laptopd505.fenrus.org>
References: <1151470123.6052.17.camel@linux-znh>
	 <20060627234005.dda13686.akpm@osdl.org>
	 <1151485856.3153.18.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Organization: 
Message-Id: <1151479976.6052.53.camel@linux-znh>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 28 Jun 2006 15:32:57 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-28 at 17:10, Arjan van de Ven wrote:
> On Tue, 2006-06-27 at 23:40 -0700, Andrew Morton wrote:
> > On 28 Jun 2006 12:48:43 +0800
> > Zou Nan hai <nanhai.zou@intel.com> wrote:
> > 
> > > We see system hang in ext3 jbd code
> > > when Linux install program anaconda copying 
> > > packages. 
> > > 
> > > That is because anaconda is invoked from linuxrc 
> > > in initrd when system_state is still SYSTEM_BOOTING.
> > > 
> > > Thus the cond_resched checks in  journal_commit_transaction 
> > > will always return 1 without actually schedule, 
> > > then the system fall into deadloop.
> > 
> > That's a bug in cond_resched().
> 
> hummm while this fix is needed... something makes me want to think that
> something as complex as an OS installer really shouldn't be running with
> SYSTEM_BOOTING state anymore.... 
> shouldn't we start considering running the initrd (esp now with klibc)
> as SYSTEM_RUNNING ?

  Is there any historical reason that we put system_state of app runs
from initrd into SYSTEM_BOOTING instead of SYSTEM_RUNNING?


Zou Nan hai
