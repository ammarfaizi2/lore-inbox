Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266498AbUF3SPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266498AbUF3SPq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 14:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266703AbUF3SPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 14:15:46 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:60068 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266498AbUF3SPm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 14:15:42 -0400
Subject: Re: per-process namespace?
From: Ram Pai <linuxram@us.ibm.com>
To: Mike Waychison <Michael.Waychison@Sun.COM>
Cc: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
In-Reply-To: <40E2BCE1.3040302@sun.com>
References: <1088534826.2816.38.camel@dyn319623-009047021109.beaverton.ibm.com>
	 <40E1DABD.9000202@sun.com>
	 <20040629221025.GI12308@parcelfarce.linux.theplanet.co.uk>
	 <40E2BCE1.3040302@sun.com>
Content-Type: text/plain
Organization: 
Message-Id: <1088619320.2927.77.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 30 Jun 2004 11:15:22 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-06-30 at 06:15, Mike Waychison wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> viro@parcelfarce.linux.theplanet.co.uk wrote:
> > On Tue, Jun 29, 2004 at 05:10:21PM -0400, Mike Waychison wrote:
> >
> >>Another caveat is that the current system disallows you from doing any
> >>mount/umount's in another namespace (bogus security?).
> >
> >
> > Nothing bogus here - namespace boundary _IS_ a trust boundary and that's
> > exactly the diference between symlinks and bindings - symlink attacks
> > are possible exactly because they allow you to modify visible tree
> topology
> > for other users.
> 
> Yet being able to access another namespace via directory fd still breaks
> that boundary.  I'm not sure if it's a feature or a not.  If it is a
> feature, I'd argue that having the fd means you are trusted to play in
> that namespace, which implies the right to do things like call mount(2)
> in it.
> 
> >
> > Note that sharing parts of namespace (which is basically what automounter
> > wants and what we do not have yet) is deliberate act of trust - same as
> > having a part of your address space shared with other process.
> 
> Namespace sharing has been touched on before, but hasn't been discussed
> publicly.  My take on it is that in order to have namespace sharing work
> in some semantically sane way, we need to be able to identify
> owner-namespaces for shared branches of the vfsmount tree.  This implies
> making namespaces first-class primitives.  Is this where we want to go
> with this?
> 
> I only see automounting being the only consumer of such a beast, are
> there other possible users?

We have a customer requirement where they want to tailor the namespace
of each process according to some environmental attributes. But at the
same time they want to see the system mounts except at some predefined
local directory tree. 

The per-process namespace concept comes in handy here except for the
static nature of the namespace. In the sense, any changes to the system
namespace do not reflect in the children namespace.

  
Perhaps the way to implement this feature is to 
provide a feature to make some mounts points maskable.

A new forked-off namespace sees all the mounts in the parent 
namespace, except the mounts on mount point that are 
masked.

eager to hear how Al Viro envisions this to work, 
RP  

> 
> - --
> Mike Waychison
> Sun Microsystems, Inc.
> 1 (650) 352-5299 voice
> 1 (416) 202-8336 voice
> http://www.sun.com
> 
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> NOTICE:  The opinions expressed in this email are held by me,
> and may not represent the views of Sun Microsystems, Inc.
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.4 (GNU/Linux)
> 
> iD8DBQFA4rzgdQs4kOxk3/MRAkxVAJ9kHj/6xfa/zSXLpT7v2hkOSFWhrgCggjL/
> ovcsxTkm6FpbWMlzIQn4geU=
> =B4D5
> -----END PGP SIGNATURE-----
> 

