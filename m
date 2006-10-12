Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422867AbWJLRAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422867AbWJLRAy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 13:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932701AbWJLRAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 13:00:54 -0400
Received: from ms-smtp-01.socal.rr.com ([66.75.162.133]:28156 "EHLO
	ms-smtp-01.socal.rr.com") by vger.kernel.org with ESMTP
	id S932655AbWJLRAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 13:00:53 -0400
Message-Id: <6.2.3.4.0.20061012095229.048db398@pop-server.san.rr.com>
X-Mailer: QUALCOMM Windows Eudora Version 6.2.3.4
Date: Thu, 12 Oct 2006 09:57:36 -0700
To: Alexander van Heukelum <heukelum@mailshack.com>
From: John Coffman <johninsd@san.rr.com>
Subject: Re: [PATCH] Remove
  lilo-loads-only-five-sectors-of-zImage-fixup from setup.S
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       Linus Torvalds <torvalds@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       John Coffman <johninsd@san.rr.com>
In-Reply-To: <20061011194301.GA2084@mailshack.com>
References: <20061011163356.GA2022@mailshack.com>
 <452D3A11.5020100@zytor.com>
 <20061011194301.GA2084@mailshack.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Antivirus: avast! (VPS 0641-3, 10/12/2006), Outbound message
X-Antivirus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander,

You are referring to versions of LILO more than 8 years old.  Since 
version 21, when I took over maintenance from Werner, LILO has been 
sensitive to the boot protocol in use.  Peter has been kind enough to 
point out upgrades to the 2.00+ protocols when they have been introduced.

All versions of LILO since version 21 should be able to correctly 
handle both zImage and bzImage kernels, old and new.  The 
command:  "lilo -V -v" should indicate the version of LILO you are 
using, and may indicate a release date.

--John


At 12:43 PM  Wednesday 10/11/2006, Alexander van Heukelum wrote:
>On Wed, Oct 11, 2006 at 11:38:09AM -0700, H. Peter Anvin wrote:
> > Alexander van Heukelum wrote:
> > >Hi!
> > >
> > >The real-mode kernel (on i386 and x86_64) checks if the bootloader
> > >loaded it correctly. Apparantly, very old versions of LILO disregarded
> > >the setupsects field in the bootsector and always just loaded the first
> > >five sectors. If the kernel is compiled as a zImage, the real-mode
> > >kernel is able to rectify the situation. At least it was, until the code
> > >to do so was moved to the eighth sector in order to make space for more
> > >E820 entries (commit: f9ba70535dc12d9eb57d466a2ecd749e16eca866). This
> > >occured on 1 May 2005 and as far as I know, noone has complained yet.
> > >This patch removes the checks for the signature and the fixup code
> > >completely.
> > >
> > >Comments? Which bootloaders are still in use? Kill zImage?
> > >
> >
> > Andrew asked me to comment on this...
> >
> > This removes support for boot loaders that did not understand boot
> > loader protocol version 2.00 or later.  This probably includes very
> > early versions of LILO as well as the long-since obsolete Bootlin and
> > Shoelace.  Those loaders were unable to load bzImages as well.
> >
> > I have been urging that we kill zImage for a long time.  It is virtually
> > impossible to build a kernel today that will fit inside the zImage 512K
> > compressed limitation.
> >
> > It would be useful for setup.S to halt with a message if such an early
> > bootloader is detected, however.  This would have to be parked in the
> > first 2K of the setup area, and can simply be detected by looking for
> > zero in type_of_loader.
>
>Hi!
>
>The patch should not alter behaviour for any bootloader that takes
>setupsects into account. It just removes 'support' for bootloaders that
>have the size of the setup code hardcoded to 4 sectors.
>
>The current version of setup.S already checks if the bootloader
>understands boot protocol 2.00+ in the case of a big kernel, but that
>code is also after the 2k-mark. The zero-page still has some unused
>space between offsets 0x230 and 0x28f. Shall I put/move some code there
>to check unconditionally if the type_of_loader has been set?
>
>I'll do that if no objections are put forward.
>
>Thanks,
>     Alexander
>
> >
> >       -hpa
> >


         PGP KeyID: 6781C9C8  (good until 31-Dec-2008)
         Keyserver at  ldap://keyserver.pgp.com  OR  http://pgp.mit.edu
         LILO links at http://freshmeat.net/projects/lilo
         and Help link at http://lilo.go.dyndns.org


