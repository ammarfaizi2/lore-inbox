Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262750AbTKEHKY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 02:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262757AbTKEHKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 02:10:24 -0500
Received: from f10.mail.ru ([194.67.57.40]:8465 "EHLO f10.mail.ru")
	by vger.kernel.org with ESMTP id S262750AbTKEHKR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 02:10:17 -0500
From: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	<arvidjaar@mail.ru>
To: =?koi8-r?Q?=22?=Alistair J Strachan=?koi8-r?Q?=22=20?= 
	<alistair@devzero.co.uk>
Cc: =?koi8-r?Q?=22?=Arjan van de Ven=?koi8-r?Q?=22=20?= 
	<arjanv@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] KBUILD 2.5 issues/regressions
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: unknown via proxy [212.30.182.96]
Date: Wed, 05 Nov 2003 10:10:14 +0300
Reply-To: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	  <arvidjaar@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E1AHHny-000CwE-00.arvidjaar-mail-ru@f10.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am sorry to reopen this thread but as we hit the same issues in Mandrake
I hope someone can advice.

> On Friday 11 July 2003 19:01, Arjan van de Ven wrote:
> > On Fri, Jul 11, 2003 at 06:56:53PM +0100, Alistair J Strachan wrote:
> > > On Friday 11 July 2003 18:47, Arjan van de Ven wrote:
> > > > On Fri, 2003-07-11 at 19:40, Alistair J Strachan wrote:
> > > > > o The state of kbuild in shipped (distribution) kernels must be such
> > > > > that the construction of external modules can be done without having
> > > > > to modify the shipped kernel-source package.
> > > >
> > > > > that is actually not hard; I just did this in a RH rpm like way last
> > > > week.
> > >
> > > I cannot see how you can make modversions modules without first building
> > > vmlinux. This "RPM" presumably does not ship with vmlinux constructed
> >
> > It does actually.

But is it really enough? modpost needs all modules to extract symbol versions
so it means kernel-source should actually ship all module.o files.

> Ah. In that case, I suppose it's all moot and won't end up being an issue. It 
> just strikes me that vmlinux would not have to be included in a distro 2.4 
> kernel, because it is not a "dependency" of the build system. If this is how 
> distros will operate, then just forget about it.

Mandrake and AFAIK RedHat ship single 2.4 kernel source that allos building
external module for any currently running distribution kernel. While this
could be tweaked using symlinks it means that kernel-source needs to be
shipped with copies of vmlinux and *all modules.o for every kernel flavour
in distribution. As of this writing Mandrake includes 6 or 7 kernel versions.
It is rather too much :(

So it is still an issue. I am thinking about some way to direct modpost
to extract versions out of /boot/vmlinuz and /lib/modules if it detects
pristine distribution sources

To recap - currently under Mandrake and RH it is possible to do

rpm -i kernel-source
cd /external/module/src
make

and it will automatically create module for currently running kernel as long
as kernel is distribution kernel without any extra configuration.

It appears that to support same functionality on 2.6 modversions need to be disabled ...

TIA

-andrey
