Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316342AbSHaHNj>; Sat, 31 Aug 2002 03:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316408AbSHaHNj>; Sat, 31 Aug 2002 03:13:39 -0400
Received: from cttsv008.ctt.ne.jp ([210.166.4.137]:23986 "EHLO
	cttsv008.ctt.ne.jp") by vger.kernel.org with ESMTP
	id <S316342AbSHaHNi> convert rfc822-to-8bit; Sat, 31 Aug 2002 03:13:38 -0400
Content-Type: text/plain; charset=US-ASCII
From: Gabor Kerenyi <wom@tateyama.hu>
To: Greg KH <greg@kroah.com>
Subject: Re: extended file permissions based on LSM
Date: Sat, 31 Aug 2002 09:09:59 +0200
User-Agent: KMail/1.4.2
Cc: linux-kernel@vger.kernel.org, Chris Wright <chris@wirex.com>
References: <200208310616.04709.wom@tateyama.hu> <20020831052114.GA12082@kroah.com>
In-Reply-To: <20020831052114.GA12082@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208310909.59676.wom@tateyama.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 31 August 2002 07:21, Greg KH wrote:
> On Sat, Aug 31, 2002 at 06:16:04AM +0200, Gabor Kerenyi wrote:
> > In this case we could have some very interesting (useful
> > or not who knows) features. For example if there are two
> > hardlinks for an inode in two different directories, the user
> > could get different rights for the file depending on the
> > path he reaches it.
>
> I think you can already do this with the existing LSM interface, you can
> always get the dentry for a given inode, right?  

How can I determine the dentry what the user actually acts on? Because
of  hardlinks I thought it is impossible to find out the dentry having
only the inode. 1:n (inode:dentry) relation isn't it?
Or did I miss something?

> > To be honest I'd welcome if the whole file permisssion
> > part were moved to LSM. It would allow us to override the
> > currently implemented default behavior easily.
>
> No!  One of the main goals of the LSM design was to not override the
> current Linux permission behavior.  It can only deny access to things,
> not be a permissive system of allowing access to things that the current
> system denies.  See the many threads on the LSM mailing list for the
> reasons behind this.

Well, the current LSM maybe designed this way. But as I see LSM
is modular. There is a capability.c in the security dir. It could still
deny access in the way I described, moreover the "security checks"
would be in the right place -> security/ (at least in my point of
view)
The capability.c is only _one_ module. It doesn't mean we can't have
more that work differently. User can choose among them.
(it would be great in the future if more sec. modules could be loaded
for a system - for instance one sec.modules deals with tasks, the
other deals with file permissions).

There are many situations where the current right management is
not good enough and with only having a "deny policy" they can't
be solved using LSM.

It would be up to the LSM to decide whether it wants to apply a "deny
policy" or an "allow policiy"

If we move all security checks from the VFS to the LSM then
the bahavior will be determined by the currently loaded LSM.
In your point of view:
the capability.c (or def_fileperm.c) can implement a deny policiy.
For the rest of the LSModules it's up to them.

Is it acceptable for you?

Having an "allow policiy" doesn't mean less security _if_ the loaded
LSM knows what it is doing. It can be as secure as a "deny policy"
if it is implemented in a proper way - it will always allow or deny
access exaclty how the root told to by setting permissions etc.
If the module is not implemented in a proper way then it means
a problem whether it denies or allows things.

OK. We can state that the current LSM design is restrictive and
only an extension to the current security checks. So it can't add
any extra security features (not checks) and therefore it's limitied
in its own way. With this interface nobody can customize the
system without hacking the very kernel (vfs for exmaple) to
achieve new behavior and features.

Or we can create another LSM say Core Linux Security Module
and its duty will be to move the security checks from the kernel
to a seperate place and call the LSM functions if needed.
You can't reprogram the security checks now. I know it's implemented
to be U*IX like. It's great, it's enough for me too. But why can't we
provide a possibility (only) to implement something else as well
instead of and/or in conjunction with the current one?
Would it be a big harm?

Thanks,

Gabor

