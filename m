Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261462AbVETPjI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbVETPjI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 11:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261476AbVETPjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 11:39:08 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:22194 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261462AbVETPjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 11:39:04 -0400
Subject: Re: 2.6.12-rc4-mm2 - sleeping function called from invalid context
	at mm/slab.c:2502
From: David Woodhouse <dwmw2@infradead.org>
To: Linux Audit Discussion <linux-audit@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1116601757.12489.130.camel@moss-spartans.epoch.ncsc.mil>
References: <200505171624.j4HGOQwo017312@turing-police.cc.vt.edu>
	 <1116502449.23972.207.camel@hades.cambridge.redhat.com>
	 <200505191845.j4JIjVtq006262@turing-police.cc.vt.edu>
	 <200505201430.j4KEUFD0012985@turing-police.cc.vt.edu>
	 <1116601195.29037.18.camel@localhost.localdomain>
	 <1116601757.12489.130.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 20 May 2005 16:36:53 +0100
Message-Id: <1116603414.29037.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-05-20 at 11:09 -0400, Stephen Smalley wrote:
> The lock is being held by the af_unix code (unix_state_wlock), not
> avc_audit; the AVC is called under all kinds of circumstances (softirq,
> hard irq, caller holding locks on relevant objects) for permission
> checking and must never sleep.
> 
> One option might be to defer some of the AVC auditing to the audit
> framework (e.g. save the vfsmount and dentry on the current audit
> context and let audit_log_exit perform the audit_log_d_path).

Yeah, maybe. Assuming you pin them, it's easy enough to hang something
off the audit context's aux list which refers to them. I'm really not
that fond of the idea of allocating a whole PATH_MAX with GFP_ATOMIC.

-- 
dwmw2

