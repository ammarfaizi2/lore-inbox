Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750858AbWJJPTW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbWJJPTW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 11:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750864AbWJJPTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 11:19:22 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:19590 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750857AbWJJPTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 11:19:21 -0400
Subject: Re: [RFC] Reverting "bd_mount_mutex" to "bd_mount_sem"
From: Arjan van de Ven <arjan@infradead.org>
To: Srinivasa Ds <srinivasa@in.ibm.com>
Cc: Eric Sandeen <sandeen@sandeen.net>, Ingo Molnar <mingo@elte.hu>,
       dm-devel@redhat.com, linux-lvm@redhat.com, linux-kernel@vger.kernel.org,
       agk@redhat.com
In-Reply-To: <452BB67E.7000700@in.ibm.com>
References: <451A78DF.1060901@in.ibm.com> <20060927135705.GA30311@elte.hu>
	 <4526C184.7070507@sandeen.net>  <452BB67E.7000700@in.ibm.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 10 Oct 2006 17:19:05 +0200
Message-Id: <1160493546.3000.303.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-10 at 20:34 +0530, Srinivasa Ds wrote:
> Eric Sandeen wrote:
> > Ingo Molnar wrote:
> >   
> >> * Srinivasa Ds <srinivasa@in.ibm.com> wrote:
> >>
> >>     
> >>>   On debugging I found out that,"dmsetup suspend <device name>" calls 
> >>> "freeze_bdev()",which locks "bd_mount_mutex" to make sure that no new 
> >>> mounts happen on bdev until thaw_bdev() is called.
> >>>   This "thaw_bdev()" is getting called when we resume the device 
> >>> through "dmsetup resume <device-name>".
> >>>   Hence we have 2 processes,one of which locks 
> >>> "bd_mount_mutex"(dmsetup suspend) and Another(dmsetup resume) unlocks 
> >>> it.
> >>>       
> >> hm, to me this seems quite a fragile construct - even if the 
> >> mutex-debugging warning is worked around by reverting to a semaphore.
> >>
> >> 	Ingo
> >>     
> >
> > Ingo, what do you feel is fragile about this?  It seems like this is a
> > reasonable way to go, except that maybe a down_trylock would be good if
> > a 2nd process tries to freeze while it's already frozen...
> >
> > Thanks,
> >
> > -Eric
> >   
> Ingo, As per the discussion resending the patch with down_trylock.

Hi,

I still think that effectively exporting this semaphore to userspace is
a big design mistake; but at least it can't be a mutex for this reason
so the patch is sane in that regard...

Greetings,
   Arjan van de Ven

