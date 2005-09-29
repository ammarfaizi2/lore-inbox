Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbVI2TrU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbVI2TrU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 15:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbVI2TrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 15:47:20 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:44550 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1750706AbVI2TrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 15:47:19 -0400
Date: Thu, 29 Sep 2005 21:41:55 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Andrew Morton <akpm@osdl.org>
Cc: davidel@xmailserver.org, nacc@us.ibm.com, nish.aravamudan@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] 2.6.14-rc2-mm1: fixes for overflow msec_to_jiffies()
Message-ID: <20050929194155.GB16171@alpha.home.local>
References: <Pine.LNX.4.63.0509231108140.10222@localhost.localdomain> <20050924040534.GB18716@alpha.home.local> <29495f1d05092321447417503@mail.gmail.com> <20050924061500.GA24628@alpha.home.local> <20050924171928.GF3950@us.ibm.com> <Pine.LNX.4.63.0509241120380.31327@localhost.localdomain> <20050924193839.GB26197@alpha.home.local> <20050924194418.GC26197@alpha.home.local> <20050929024312.2f3a9e80.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050929024312.2f3a9e80.akpm@osdl.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Andrew,

I'm very sorry because I have verified the code with gcc-2.95.3,
gcc-3.3.6 and gcc-3.4.4 on x86 and alpha to ensure that everything
went smooth on archs where sizeof(long) > sizeof(int). But I've
tested all the combinations in user-space for obvious ease of
validation. I believe I forgot to use -Wall. What architecture
gave you this, and with which compiler please ? I'm willing to
fix this as soon as I can understand the root of the problem.

Regards,
Willy


On Thu, Sep 29, 2005 at 02:43:12AM -0700, Andrew Morton wrote:
> Willy Tarreau <willy@w.ods.org> wrote:
> >
> > +#if HZ <= MSEC_PER_SEC && !(MSEC_PER_SEC % HZ)
> >  +#  define MAX_MSEC_OFFSET \
> >  +	(ULONG_MAX - (MSEC_PER_SEC / HZ) + 1)
> 
> That generates numbers which don't fit into unsigned ints, yielding vast
> numbers of
> 
> include/linux/jiffies.h: In function `msecs_to_jiffies':
> include/linux/jiffies.h:310: warning: comparison is always false due to limited range of data type
> include/linux/jiffies.h: In function `usecs_to_jiffies':
> include/linux/jiffies.h:323: warning: comparison is always false due to limited range of data type
> 
