Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261598AbVEJKeY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbVEJKeY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 06:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261600AbVEJKeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 06:34:24 -0400
Received: from mgr2.xmission.com ([198.60.22.202]:27112 "EHLO
	mgr2.xmission.com") by vger.kernel.org with ESMTP id S261598AbVEJKeT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 06:34:19 -0400
Date: Tue, 10 May 2005 04:34:16 -0600 (MDT)
From: cpclark@xmission.com
To: Sam Ravnborg <sam@ravnborg.org>
cc: Kumar Gala <kumar.gala@freescale.com>,
       linuxppc-embedded list <linuxppc-embedded@ozlabs.org>,
       Tom Rini <trini@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050510042828.GA8398@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.63.0505100420380.8140@xmission.xmission.com>
References: <Pine.LNX.4.63.0505061718380.6288@xmission.xmission.com>
 <b0aede90eb15562c0dd5a44c10d1b965@freescale.com> <20050510042828.GA8398@mars.ravnborg.org>
Organization: Secret Conspiracy Labs
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: PPC uImage build not reporting correctly
X-SA-Exim-Connect-IP: 166.70.238.3
X-SA-Exim-Mail-From: cpclark@xmission.com
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mgr6.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 May 2005, Sam Ravnborg wrote:

> On Mon, May 09, 2005 at 10:19:01AM -0500, Kumar Gala wrote:
> > 
> > On May 6, 2005, at 6:22 PM, <cpclark@xmission.com> wrote:
> > 
> > >On Fri, 6 May 2005, Kumar Gala wrote:
> > > > I tried the following w/o success:
> > > >
> > > > $(obj)/uImage: $(obj)/vmlinux.gz
> > > >         $(Q)rm -f $@
> > > >         $(call if_changed,uimage)
> > > >         @echo ' Image: $@' $(shell if [ -f $@ ]; then echo 'is ready'; else echo 'not made'; fi)
> > >
> > >Couldn't you eliminate the ($shell ..) construct altogether, like this?:
> > >
> > >$(obj)/uImage: $(obj)/vmlinux.gz
> > >        $(Q)rm -f $@
> > >        $(call if_changed,uimage)
> > >        @echo -n '? Image: $@'
> > >        @if [ -f $@ ]; then echo 'is ready' ; else echo 'not made'; fi
> > 
> > Yes, and this seems to actually work.
> > 
> > Sam, does this look reasonable to you.  If so I will work up a patch.
>
> Looks ok - but I do not see why use of $(shell ...) did not work out.

As I understand it, the $(shell ...) construct doesn't "work" in the case 
cited above because make evaluates/expands the $(shell ...) stuff while it 
is parsing the makefile and building the command list--i.e. before it has 
issued any commands to build anything.  What seems to be desired in this 
case is a file-existence test which runs "inline" with respect to the 
preceding commands.  The use of $(shell ...) inside a command 
subverts/preempts that natural sequence.  I think. :-)

Chris
