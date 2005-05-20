Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261521AbVETRTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261521AbVETRTk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 13:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261513AbVETRT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 13:19:26 -0400
Received: from fire.osdl.org ([65.172.181.4]:11999 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261488AbVETRTP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 13:19:15 -0400
Date: Fri, 20 May 2005 10:19:06 -0700
From: Chris Wright <chrisw@osdl.org>
To: Linux Audit Discussion <linux-audit@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc4-mm2 - sleeping function called from invalid context at mm/slab.c:2502
Message-ID: <20050520171906.GZ27549@shell0.pdx.osdl.net>
References: <200505171624.j4HGOQwo017312@turing-police.cc.vt.edu> <1116502449.23972.207.camel@hades.cambridge.redhat.com> <200505191845.j4JIjVtq006262@turing-police.cc.vt.edu> <200505201430.j4KEUFD0012985@turing-police.cc.vt.edu> <1116601195.29037.18.camel@localhost.localdomain> <1116601757.12489.130.camel@moss-spartans.epoch.ncsc.mil> <1116603414.29037.36.camel@localhost.localdomain> <1116607223.12489.155.camel@moss-spartans.epoch.ncsc.mil> <20050520170158.GY27549@shell0.pdx.osdl.net> <1116608736.12489.170.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116608736.12489.170.camel@moss-spartans.epoch.ncsc.mil>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Stephen Smalley (sds@tycho.nsa.gov) wrote:
> On Fri, 2005-05-20 at 10:01 -0700, Chris Wright wrote:
> > > +struct audit_aux_data_avc {
> > 
> > I guess it's not really avc specific (although it's primary user).
> 
> You mean generalize the struct for possible re-use by other audit
> helpers but keep the type value and function distinct?
> audit_aux_data_path?  Analogous to struct path in namei.c.

Yup.

> > Won't this change the order quite a bit?  And how do you correlate path
> > vs. exe, etc.?  Oh, I see, you're not using it for exe...
> 
> Could be an issue for syscalls that involve multiple files, e.g. rename.
> We are at least still logging the last component name, device, and inode
> number with the avc message, and only deferring logging of the full
> pathname.

If it works for you, it's really only effecting your messages at this point.
I took David's idea to mean replace audit_log_d_path altogether, and all
paths logged on exit with aux data.

thanks,
-chris
