Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264953AbUFLWv2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264953AbUFLWv2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 18:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264955AbUFLWv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 18:51:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:40102 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264953AbUFLWvY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 18:51:24 -0400
Date: Sat, 12 Jun 2004 15:51:23 -0700
From: Chris Wright <chrisw@osdl.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: In-kernel Authentication Tokens (PAGs)
Message-ID: <20040612155123.W21045@build.pdx.osdl.net>
References: <772741DF-BC19-11D8-888F-000393ACC76E@mac.com> <20040611201523.X22989@build.pdx.osdl.net> <C636D44C-BC2B-11D8-888F-000393ACC76E@mac.com> <20040612135302.Y22989@build.pdx.osdl.net> <ADFD1FB4-BCB5-11D8-888F-000393ACC76E@mac.com> <20040612144437.V21045@build.pdx.osdl.net> <A63B46CC-BCBB-11D8-888F-000393ACC76E@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <A63B46CC-BCBB-11D8-888F-000393ACC76E@mac.com>; from mrmacman_g4@mac.com on Sat, Jun 12, 2004 at 05:58:34PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Kyle Moffett (mrmacman_g4@mac.com) wrote:
> On Jun 12, 2004, at 17:44, Chris Wright wrote:
> > Typically, objects that LSM cares about include a pointer to opaque
> > data (security blob) which describes the security domain for the 
> > object.
> > See task->security as an example.  It's not clear to me if 
> > task->security
> > is sufficient and you only need a back pointer to the task or if each
> > PAG needs it's own security blob.
> 
> Ahh, ok.  In this case, a PAG is an independent object, not directly
> associated with any specific task or other PAG, so therefore it will 
> likely
> need its own security blob.  Currently, in the creation of my PAG I just
> copy over the UID from the calling task.  If I was to convert it to use 
> LSM,
> I guess I should just leave out the UID entirely, and just have a 
> pointer
> to a security blob.  What is the best way to portray the security blob 
> to
> user-space, in terms of sys-calls?  I need a way for user-space apps to
> change the security context in a similar way as it is changed for a task
> or process.  Do you have a link to some documentation on the kernel
> API for LSM?  I basically need to copy the current task's security blob
> into a new one and be able to compare two contexts to see if one
> can affect the other.  Thanks!

I don't have a good feel for the PAG data structure, perhaps the
above would turn out as overkill.  The security api is commented in
include/linux/security.h, take a gander there.  The blobs are specific
to the security model, and I don't yet see a need to display them to
userspace for each PAG.  

> > Sounds like an extension to rlimits.  The counters could be stored in
> > ->user to limit the userwide number of tokens.
> 
> Ok, thank you very much, that's exactly what I need.  I am somewhat
> new to kernel development, so finding my way around the structs is
> somewhat difficult.  Is there a good guide somewhere on the net that
> you can point me to?

Hmm, not really.  The source is best.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
