Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262796AbTBJTkX>; Mon, 10 Feb 2003 14:40:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262807AbTBJTkX>; Mon, 10 Feb 2003 14:40:23 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:59824 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id <S262796AbTBJTkW>;
	Mon, 10 Feb 2003 14:40:22 -0500
Message-Id: <200302101957.OAA08418@moss-shockers.ncsc.mil>
Date: Mon, 10 Feb 2003 14:57:41 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: RE: [BK PATCH] LSM changes for 2.5.59
To: crispin@wirex.com, hch@infradead.org, law@tlinx.org
Cc: torvalds@transmeta.com, linux-security-module@wirex.com,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Content-MD5: yNSjuAOyDT+OvhU3Qe9luQ==
X-Mailer: dtmail 1.2.0 CDE Version 1.2 SunOS 5.6 sun4u sparc 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linda Walsh wrote:
> 	A security model that mediates access to security objects by
> logging all access and blocking access if logging cannot continue is
> unsupportable in any straight forward, efficient and/or non-kludgy, ugly
> way.  

Could this possibly be a result of the above being a fundamentally
flawed security model?  Not to mention it being primarily an auditing
model rather than a real access control model.  It also seems a bit
problematic regardless of your kernel security framework; what does
"logging cannot continue" truly mean?  Do you have to verify that the
log record made it to disk before you can proceed with the operation?

<insane ranting about evil conspiracies ignored>

> 	Also unsupported: The "no-security" model -- where all security 
> is thrown out (to save memory space and cycles) that was desired for embedded 
work.

The capabilities logic was moved into a module, and you have the option
of building a kernel with traditional superuser logic (dummy security
module) rather than capabilities.  It is true that the capability bits
haven't yet been moved into the opaque security field, as explained in
the documentation, but this can be changed if desired (but there are
consequences to such a change; see the discussion in lsm.tmpl) .  It is
also true that the capable() calls haven't been moved, but there is
little to be gained by it except possibly where there is a
corresponding LSM hook, and that is a straightforward refinement of the
existing LSM patch.

> 	LSM also doesn't support standard LSPP-B1 style graded security
> where mandatory access checks are logged as security violations before
> DAC checks are even looked at for an object.

An auditing issue, not an access control issue.  As previously
discussed, there is no channel as long as both checks return the
same error (and doing otherwise is a compatibility problem).

> 	At one point a plan was proposed (by Casey Schaufler, SGI) and 
> _\implemented\_ (team members & prjct lead Linda Walsh) to move all
> security checks out of the kernel into a 'default policy' module.
> The code to implement this was submitted to the LSM list in June 1991.

1991? I don't think so.  But feel free to point people to your patch if
you like.  Moving all of the DAC logic into a module is _not_ necessary
to add support for strong access controls.  And modularizing that logic
has interesting implications; what happens to your applications when
you turn off the kernel DAC logic and replace it with something
arbitrary?  

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


