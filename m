Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316723AbSGZCeN>; Thu, 25 Jul 2002 22:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316709AbSGZCeN>; Thu, 25 Jul 2002 22:34:13 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:37387 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S316723AbSGZCeM>; Thu, 25 Jul 2002 22:34:12 -0400
Date: Thu, 25 Jul 2002 19:37:19 -0700
From: jw schultz <jw@pegasys.ws>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Header files and the kernel ABI
Message-ID: <20020726023719.GA32764@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <3D406A09.37CE334@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D406A09.37CE334@kegel.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2002 at 02:13:45PM -0700, dank@kegel.com wrote:
> Oliver Xymoron <oxymoron@waste.org> wrote:
> > 
> > On Thu, 25 Jul 2002, Erik Andersen wrote:
> > 
> > > On Thu Jul 25, 2002 at 09:31:23AM -0700, H. Peter Anvin wrote:
> > > > Oliver Xymoron wrote:
> > > > >
> > > > >Ideally, the ABI layer would be maintained and packaged separately from
> > > > >both the kernel and glibc to avoid gratuitous changes from either side.
> > > >
> > > > I disagree.  The ABI is a product of the kernel and should be attached
> > > > to it.  It is *not* a product of glibc -- glibc is a consumer of it, as
> > > > are any other libcs.
> > >
> > > Agreed.  I maintain a libc and I certainly do not want to
> > > have to maintain the kernel ABI of the day headers.  That
> > > is clearly a job for the kernel.
> > 
> > The idea of maintaining them separately is that people won't be able to
> > touch the ABI without explicitly going through a gatekeeper whose job is
> > to minimize breakage. Linus usually catches ABI changes but not always.
> > 
> > I explicitly did _not_ suggest making it the job of libc maintainers. And
> > the whole point of the exercise is to avoid ABI of the day anyway. The ABI
> > should change less frequently than the kernel or libc. It's more analogous
> > to something like modutils.
> 
> IMHO it should live with the kernel, at least for now.  
> The ABI .h files can live in a walled-off area that stays as stable as possible.
> Anyone building glibc should be able to grab the ABI .h files from a
> recent linux kernel source tarball without much effort.  (Maybe we'd
> add a 'install headers_install' make target to install the ABI .h files
> to make it obvious how to get them.)
> 
> Imagine what would happen if the base ABI .h files were maintained 
> as part of a future Linux Standard Base, with the kernel only maintaining
> .h files for extensions to the base ABI.  You'd need to install the ABI .h 
> files before you could build the kernel!  That might be the right way to
> go, but let's not propose it until the ABI .h files exist and are useful.

I'd say it should be maintained with the kernel.  The lib
building process would include specifying the ABI headers
which would be copied to /usr/include as part of the libc
install.  I'd rather keep this in the hands of the kernel
maintainers than have a new standards committee slowing
progress.

Building the kernel would reference the ABI headers in
/usr/include so the kernel built would match the libs.
Backward compatibility could be supported with by build-time
checks.  In essence this would make the kernel ABI against
which the libc was built act as a set of implied kernel
build options.  The kernel build process could eventually
detect incompatabilities for ABI changes via version
assertions.  (what do you think Kieth?)

A CML option CONFIG_ABI would default to /usr/include/...
to allow building kernels for other systems or in
anticipation of a libc rebuild. (a shot in the foot)

This way kernel builds could leave out deprecated
interfaces as soon as the local libc stopped relying on
them.


-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
