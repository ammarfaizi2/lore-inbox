Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261516AbVETRPH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261516AbVETRPH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 13:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261513AbVETRPH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 13:15:07 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:47764 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S261516AbVETRPB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 13:15:01 -0400
Subject: Re: 2.6.12-rc4-mm2 - sleeping function called from invalid context
	at mm/slab.c:2502
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Linux Audit Discussion <linux-audit@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050520170158.GY27549@shell0.pdx.osdl.net>
References: <200505171624.j4HGOQwo017312@turing-police.cc.vt.edu>
	 <1116502449.23972.207.camel@hades.cambridge.redhat.com>
	 <200505191845.j4JIjVtq006262@turing-police.cc.vt.edu>
	 <200505201430.j4KEUFD0012985@turing-police.cc.vt.edu>
	 <1116601195.29037.18.camel@localhost.localdomain>
	 <1116601757.12489.130.camel@moss-spartans.epoch.ncsc.mil>
	 <1116603414.29037.36.camel@localhost.localdomain>
	 <1116607223.12489.155.camel@moss-spartans.epoch.ncsc.mil>
	 <20050520170158.GY27549@shell0.pdx.osdl.net>
Content-Type: text/plain
Organization: National Security Agency
Date: Fri, 20 May 2005 13:05:36 -0400
Message-Id: <1116608736.12489.170.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-16) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-05-20 at 10:01 -0700, Chris Wright wrote:
> > +struct audit_aux_data_avc {
> 
> I guess it's not really avc specific (although it's primary user).

You mean generalize the struct for possible re-use by other audit
helpers but keep the type value and function distinct?
audit_aux_data_path?  Analogous to struct path in namei.c.

> Won't this change the order quite a bit?  And how do you correlate path
> vs. exe, etc.?  Oh, I see, you're not using it for exe...

Could be an issue for syscalls that involve multiple files, e.g. rename.
We are at least still logging the last component name, device, and inode
number with the avc message, and only deferring logging of the full
pathname.

-- 
Stephen Smalley
National Security Agency

