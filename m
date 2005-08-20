Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbVHTNm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbVHTNm3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 09:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbVHTNm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 09:42:29 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:37508 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750730AbVHTNm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 09:42:29 -0400
Subject: Re: 2.6.13-rc6-mm1
From: David Woodhouse <dwmw2@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Reuben Farrelly <reuben-lkml@reub.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20050819183600.49f620b0.akpm@osdl.org>
References: <20050819043331.7bc1f9a9.akpm@osdl.org>
	 <4305DCC6.70906@reub.net> <20050819103435.2c88a9f2.akpm@osdl.org>
	 <430686EA.3000901@reub.net>  <20050819183600.49f620b0.akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 20 Aug 2005 14:40:31 +0100
Message-Id: <1124545232.3407.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-19 at 18:36 -0700, Andrew Morton wrote:
> Reuben Farrelly <reuben-lkml@reub.net> wrote:
> >
> > ...
> > >> 4. PAM is complaining about "PAM audit_open() failed: Protocol not suppor
> > >> ted" and I can't log in as any user including root.  I would have picked this 
> > >> was a userspace problem, but it doesn't break with -rc5-mm1, yet reproduceably 
> > >> breaks with -rc6-mm1.  Weird.
> > > 
> > > hm.  How come you're able to use the machine then?
> > 
> > Machine was booting up ok, and things were being written to syslog.  Rebooted 
> > into -rc5-mm1 to investigate, and of course could boot into rc6-mm1 in single 
> > user mode, test and bring services up one by one from there.  Having two boxes 
> > helped too.
> > 
> > > Is it possible to get an strace of this failure somehow?
> > 
> > Not sure if this is needed anymore, as I found that the problem goes away when 
> > I compile in kernel auditing.  This not required for -rc5-mm1.  Is that change 
> > intended?
> > 
> 
> Sounds wrong to me, especially if 2.6.13-rc6 doesn't do that.

Hm. It sounds like you'd configured PAM to require the pam_loginuid
module even though you didn't have auditing enabled in your kernel. That
seems strange and wrong to me, and _is_ a userspace problem.

I'd also agree that it shouldn't have changed with the new kernel though
-- and I can't think of anything I changed recently which would have
that effect. An strace would still be useful.

Can you double-check that you didn't have auditing enabled in your
older, working kernel?

-- 
dwmw2

