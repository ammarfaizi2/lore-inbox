Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311587AbSCTGUA>; Wed, 20 Mar 2002 01:20:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311588AbSCTGTv>; Wed, 20 Mar 2002 01:19:51 -0500
Received: from smtp1.extremenetworks.com ([216.52.8.6]:13190 "HELO
	smtp1.extremenetworks.com") by vger.kernel.org with SMTP
	id <S311587AbSCTGTo>; Wed, 20 Mar 2002 01:19:44 -0500
Message-ID: <3C9829F2.26985552@extremenetworks.com>
Date: Tue, 19 Mar 2002 22:19:30 -0800
From: Jason Li <jli@extremenetworks.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: EXPORT_SYMBOL doesn't work
In-Reply-To: <2643.1016433275@kao2.melbourne.sgi.com> <3C963BF2.C9D78479@extremenetworks.com> <20020318191927.GB8155@opus.bloom.county> <3C964358.B4EA3C80@extremenetworks.com> <20020319002216.GH3762@opus.bloom.county>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini wrote:
> 
> On Mon, Mar 18, 2002 at 11:43:20AM -0800, Jason Li wrote:
> > Tom Rini wrote:
> > >
> > > On Mon, Mar 18, 2002 at 11:11:46AM -0800, Jason Li wrote:
> > > > Keith Owens wrote:
> > > > >
> > > > > On Sun, 17 Mar 2002 22:25:16 -0800,
> > > > > Jason Li <jli@extremenetworks.com> wrote:
> > > > > >int (*fdbIoSwitchHook)(
> > > > > >                           unsigned long arg0,
> > > > > >                           unsigned long arg1,
> > > > > >                           unsigned long arg2)=NULL;
> > > > > >EXPORT_SYMBOL(fdbIoSwitchHook);
> > > > > >gcc -D__KERNEL__ -I/home/jli/cvs2/exos/linux/include -Wall
> > > > > >-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> > > > > >-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
> > > > > >-march=i686    -c -o br_ioctl.o br_ioctl.c
> > > > > >br_ioctl.c:26: warning: type defaults to `int' in declaration of
> > > > > >`EXPORT_SYMBOL'
> > > > >
> > > > > #include <linux/module.h>
> > > > >
> > > > > Also add br_ioctl.o to export-objs in Makefile.
> > > >
> > > > Thanks alot. It works.
> > > >
> > > > Now another problem with versioning. It seems even after I have the
> > > > following in my module c file the symbol generated is not versioned:
> > >
> > > Backup your .config, run 'distclean' or 'mrproper' and try again.
> > >
> > > --
> > > Tom Rini (TR1265)
> > > http://gate.crashing.org/~trini/
> >
> > Just did a distclean. Now the inluce/linux/modules/netsym.ver has the
> > fdbIoSwitchHook version info.
> >
> > Recompiled the module. Did a nm on the module, and saw the version info
> > for the symbol. But when I dod insmod, it still complained about
> > unresolved symbol fdbIoSwitchHook.
> >
> > It seems now the version is different between the kernel and the module.
> > Should I wait for the bzImage compilation to complete and install the
> > new kernel?
> 
> There are annoying depenancies with modversions.  Basically the safe way
> is that if you change any export (add/remove), you should do a
> 'distclean', recompile everything and switch to that.
> 
> --
> Tom Rini (TR1265)
> http://gate.crashing.org/~trini/

In case I haven't concluded this thread yet, all the info worked for me.

After the distclean everything is in place and it works nicely now.

Will try more when I get a little bit more time.

Huge thanks to Tom and Keith for their input. 

-Jason
