Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261478AbVETQls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261478AbVETQls (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 12:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261480AbVETQls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 12:41:48 -0400
Received: from fire.osdl.org ([65.172.181.4]:40914 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261478AbVETQlq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 12:41:46 -0400
Date: Fri, 20 May 2005 09:41:38 -0700
From: Chris Wright <chrisw@osdl.org>
To: Linux Audit Discussion <linux-audit@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc4-mm2 - sleeping function called from invalid context at mm/slab.c:2502
Message-ID: <20050520164138.GX27549@shell0.pdx.osdl.net>
References: <200505171624.j4HGOQwo017312@turing-police.cc.vt.edu> <1116502449.23972.207.camel@hades.cambridge.redhat.com> <200505191845.j4JIjVtq006262@turing-police.cc.vt.edu> <200505201430.j4KEUFD0012985@turing-police.cc.vt.edu> <1116601195.29037.18.camel@localhost.localdomain> <1116601757.12489.130.camel@moss-spartans.epoch.ncsc.mil> <1116603414.29037.36.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116603414.29037.36.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* David Woodhouse (dwmw2@infradead.org) wrote:
> On Fri, 2005-05-20 at 11:09 -0400, Stephen Smalley wrote:
> > The lock is being held by the af_unix code (unix_state_wlock), not
> > avc_audit; the AVC is called under all kinds of circumstances (softirq,
> > hard irq, caller holding locks on relevant objects) for permission
> > checking and must never sleep.
> > 
> > One option might be to defer some of the AVC auditing to the audit
> > framework (e.g. save the vfsmount and dentry on the current audit
> > context and let audit_log_exit perform the audit_log_d_path).
> 
> Yeah, maybe. Assuming you pin them, it's easy enough to hang something
> off the audit context's aux list which refers to them. I'm really not
> that fond of the idea of allocating a whole PATH_MAX with GFP_ATOMIC.

I agree, PATH_MAX atomic is greedy.  But the calling convention could
be a bit awkward.  Currently it's as got as audit_log_format.  Tacking
vfsmount/dentry pair on might be tough to format the message with.
Got a good idea?
