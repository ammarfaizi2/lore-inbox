Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751425AbWHIXSg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbWHIXSg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 19:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbWHIXSf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 19:18:35 -0400
Received: from mail.suse.de ([195.135.220.2]:39841 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751425AbWHIXSe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 19:18:34 -0400
From: Neil Brown <neilb@suse.de>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Date: Thu, 10 Aug 2006 09:18:24 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17626.27968.132243.825703@cse.unsw.edu.au>
Cc: Michael Tokarev <mjt@tls.msk.ru>, Alexandre Oliva <aoliva@redhat.com>,
       linux-raid <linux-raid@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: modifying degraded raid 1 then re-adding other members is bad
In-Reply-To: message from Jan Engelhardt on Wednesday August 9
References: <or8xlztvn8.fsf@redhat.com>
	<17624.29070.246605.213021@cse.unsw.edu.au>
	<44D8732C.2060207@tls.msk.ru>
	<17625.4242.910985.97868@cse.unsw.edu.au>
	<Pine.LNX.4.61.0608090834060.11585@yvahk01.tjqt.qr>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday August 9, jengelh@linux01.gwdg.de wrote:
> >> Why we're updating it BACKWARD in the first place?
> >
> >To avoid writing to spares when it isn't needed - some people want
> >their spare drives to go to sleep.
> 
> That sounds a little dangerous. What if it decrements below 0?

It cannot.
md  decrements the event count only on a dirty->clean transition, and
only if it had previously incremented the count on a clean->dirty
transition.  So it can never go below what it was when the array was
assembled.

NeilBrown
