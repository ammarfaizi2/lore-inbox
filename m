Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317986AbSIAAXc>; Sat, 31 Aug 2002 20:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318060AbSIAAXc>; Sat, 31 Aug 2002 20:23:32 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:18422 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S317986AbSIAAXb>; Sat, 31 Aug 2002 20:23:31 -0400
Date: Sat, 31 Aug 2002 17:23:36 -0700
From: Chris Wright <chris@wirex.com>
To: Gabor Kerenyi <wom@tateyama.hu>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       Chris Wright <chris@wirex.com>
Subject: Re: extended file permissions based on LSM
Message-ID: <20020831172336.D11165@figure1.int.wirex.com>
Mail-Followup-To: Gabor Kerenyi <wom@tateyama.hu>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org, Chris Wright <chris@wirex.com>
References: <200208310616.04709.wom@tateyama.hu> <20020831052114.GA12082@kroah.com> <200208310909.59676.wom@tateyama.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200208310909.59676.wom@tateyama.hu>; from wom@tateyama.hu on Sat, Aug 31, 2002 at 09:09:59AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Gabor Kerenyi (wom@tateyama.hu) wrote:
> 
> How can I determine the dentry what the user actually acts on? Because
> of  hardlinks I thought it is impossible to find out the dentry having
> only the inode. 1:n (inode:dentry) relation isn't it?
> Or did I miss something?

You are correct.  In addition you need the vfsmount to pin it to a
unique point in the namespace.  As I mentioned, the dentry/vfsmount
pair is an anticipated change.

> If we move all security checks from the VFS to the LSM then
> the bahavior will be determined by the currently loaded LSM.
> In your point of view:
> the capability.c (or def_fileperm.c) can implement a deny policiy.
> For the rest of the LSModules it's up to them.
> 
> Is it acceptable for you?

No, this does not sound like a safe transition.  For starters we want a
fail safe mechanism.

> Having an "allow policiy" doesn't mean less security _if_ the loaded
> LSM knows what it is doing. It can be as secure as a "deny policy"
> if it is implemented in a proper way - it will always allow or deny
> access exaclty how the root told to by setting permissions etc.
> If the module is not implemented in a proper way then it means
> a problem whether it denies or allows things.

Indeed, however the invasive nature of a purely permissive policy along
with the ease of bugs is not a good way to begin merging a new project ;-)
Also, the capability interface provides a coarse grained permissive
interface, so all is not lost.

> OK. We can state that the current LSM design is restrictive and
> only an extension to the current security checks. So it can't add
> any extra security features (not checks) and therefore it's limitied
> in its own way. With this interface nobody can customize the
> system without hacking the very kernel (vfs for exmaple) to
> achieve new behavior and features.

Yes, this is intentional.  Of course, depending on your notion of
security feature, it may already be supported or not fall into the
category of access controls, which LSM is providing.

> Or we can create another LSM say Core Linux Security Module
> and its duty will be to move the security checks from the kernel
> to a seperate place and call the LSM functions if needed.
> You can't reprogram the security checks now. I know it's implemented
> to be U*IX like. It's great, it's enough for me too. But why can't we
> provide a possibility (only) to implement something else as well
> instead of and/or in conjunction with the current one?
> Would it be a big harm?

Please review the LSM list archives as this has been discussed
extensively.  The executive summary is that a restrictive design
provides simple assurance.  A permissive design is both more invasive
and makes it easy to write dumb security bugs.  The current focus is
merging the restrictive interface, later we can look at enhancements.
Basic walk before run philosophy ;-)

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
