Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268080AbUHKPZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268080AbUHKPZV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 11:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268081AbUHKPZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 11:25:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:40936 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268080AbUHKPZQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 11:25:16 -0400
Date: Wed, 11 Aug 2004 08:25:10 -0700
From: Chris Wright <chrisw@osdl.org>
To: davidm@hpl.hp.com
Cc: James Morris <jmorris@redhat.com>, Chris Wright <chrisw@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Kurt Garloff <garloff@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH] [LSM] Rework LSM hooks
Message-ID: <20040811082510.D1924@build.pdx.osdl.net>
References: <20040810131217.Q1924@build.pdx.osdl.net> <Xine.LNX.4.44.0408101630250.9412-100000@dhcp83-76.boston.redhat.com> <16665.56613.143598.768389@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <16665.56613.143598.768389@napali.hpl.hp.com>; from davidm@napali.hpl.hp.com on Wed, Aug 11, 2004 at 01:47:33AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* David Mosberger (davidm@napali.hpl.hp.com) wrote:
> >>>>> On Tue, 10 Aug 2004 16:31:12 -0400 (EDT), James Morris <jmorris@redhat.com> said:
> 
>   James> On Tue, 10 Aug 2004, Chris Wright wrote:
>   >> Thanks, James.  Since these are the only concrete numbers and
>   >> they are in the noise, I see no compelling reason to change to
>   >> unlikely().
> 
>   James> There may be some way to make it ia64 specific.  Is it a cpu
>   James> issue, or compiler?
> 
> I'm pretty sure the "unlikely()" part could be dropped with little/no
> downside.  The part that's relatively expensive (10 cycles when
> mispredicted) is the indirect call.  GCC doesn't handle this well on
> ia64 and as a result, most indirect calls are mispredicted.
> 
> An alternative solution might be to have a call_likely() macro, where
> you could predict the most likely target of an indirect call.  Perhaps
> that could help other platforms as well.

Hmm, the pointers are generally quite static, set once near boot time
typically, and that's it.  Seems like a plausible win.  Do you have an
example of what call_likely() would look like?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
