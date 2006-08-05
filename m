Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751455AbWHEKnB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455AbWHEKnB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 06:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbWHEKnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 06:43:00 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:50958 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751455AbWHEKm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 06:42:59 -0400
Date: Sat, 5 Aug 2006 12:42:55 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Zachary Amsden <zach@vmware.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Wright <chrisw@sous-sol.org>,
       Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Jack Lo <jlo@vmware.com>,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       pazke@donpac.ru, Andi Kleen <ak@suse.de>
Subject: Re: A proposal - binary
Message-ID: <20060805104255.GR25692@stusta.de>
References: <44D1CC7D.4010600@vmware.com> <20060803190605.GB14237@kroah.com> <44D24DD8.1080006@vmware.com> <20060803200136.GB28537@kroah.com> <20060804183448.GE11244@sequoia.sous-sol.org> <44D3B0F0.2010409@vmware.com> <1154726800.23655.273.camel@localhost.localdomain> <1154740485.3683.161.camel@mulgrave.il.steeleye.com> <44D42E7D.70101@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44D42E7D.70101@vmware.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2006 at 10:37:01PM -0700, Zachary Amsden wrote:
> James Bottomley wrote:
>...
> >2) A gateway page or vDSO provided by the hypervisor to the kernel.
> >This is the problematic piece, because the vDSO is de-facto linked into
> >the kernel and as such becomes subject to the prevailing developer
> >interpretation as being a derivative work by being linked in.  As Arjan
> >pointed out, this can be avoided as long as the gateway page itself is
> >GPL ... we could even create mechanisms like we use today for module
> >licensing by having a tag in the VMI describing the licensing of the
> >gateway page, so the kernel could be made only to load gateway pages
> >that promise they're available under the GPL.
> 
> Yes, this is what prompted my whole module rant.  The interesting thing 
> is - Linux may link to the hypervisor vDSO.  But it may not link back 
> into Linux.  This is where the line becomes very gray, as Theodore 
> mentioned earlier.  Is it a license violation for a GPL app to link 
> against a non-GPL library?  Surely, the other way around is a problem, 

I don't see the grey area.

Assuming non-GPL and not GPL compatible (e.g. 3 clause BSD is non-GPL 
but compatible):

Unless all people holding a copyright on the GPL app agreed that this 
linking is OK, it is considered a licence violation.

That's why you often see licence statements like the following:

"In addition, as a special exception, the Free Software Foundation
gives permission to link the code of its release of Wget with the
OpenSSL project's "OpenSSL" library (or with modified versions of it
that use the same license as the "OpenSSL" library), and distribute
the linked executables.  You must obey the GNU General Public License
in all respects for all of the code used other than "OpenSSL".  If you
modify this file, you may extend this exception to your version of the
file, but you are not obligated to do so.  If you do not wish to do
so, delete this exception statement from your version."

> unless the library has been made explicitly LGPL.  But if GPL apps can 
> link to non-GPL libraries, what stops GPL kernels from linking to 
> non-GPL modules?  This is where I think things become more interpretive 
> than well defined.  And that is why it is important for us to get kernel 
> developers feedback on exactly what that definition is.
>...

Some kernel developers (and some lawyers) consider all kernel modules 
with not GPL compatible licences illegal - similar to the case of 
linking a GPL app with a non-GPL library.

Quoting Novell [1]:

"Most developers of the kernel community consider non-GPL kernel
modules to be infringing on their copyright. Novell does respect this
position, and will no longer distribute non-GPL kernel modules as part 
of future products. Novell is working with vendors to find alternative
ways to provide the functionality that was previously only available
with non-GPL kernel modules."

And considering the number of people having a copyright on parts of the 
kernel, there's noone except a court who can tell what is OK and what is 
not (and even a court decision is not binding for courts in other 
countries).

> Zach

cu
Adrian

[1] http://lists.opensuse.org/archive/opensuse-announce/2006-Feb/0004.html

-- 

    Gentoo kernels are 42 times more popular than SUSE kernels among
    KLive users  (a service by SUSE contractor Andrea Arcangeli that
    gathers data about kernels from many users worldwide).

       There are three kinds of lies: Lies, Damn Lies, and Statistics.
                                                    Benjamin Disraeli

