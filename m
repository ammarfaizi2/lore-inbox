Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261674AbVFFVW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261674AbVFFVW4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 17:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbVFFVW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 17:22:56 -0400
Received: from [24.93.172.51] ([24.93.172.51]:22657 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S261674AbVFFVWg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 17:22:36 -0400
Date: Mon, 6 Jun 2005 17:18:55 -0400
From: Adam Belay <ambx1@neo.rr.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: matthieu castet <castet.matthieu@free.fr>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: PNP parallel&serial ports: module reload fails (2.6.11)?
Message-ID: <20050606211855.GA3289@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Michael Tokarev <mjt@tls.msk.ru>,
	matthieu castet <castet.matthieu@free.fr>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050602222400.GA8083@mut38-1-82-67-62-65.fbx.proxad.net> <429FA1F3.9000001@tls.msk.ru> <42A2D37A.5050408@free.fr> <42A46551.9010707@tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42A46551.9010707@tls.msk.ru>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2005 at 07:01:37PM +0400, Michael Tokarev wrote:
> matthieu castet wrote:
> > Michael Tokarev wrote:
> > 
> >> castet.matthieu@free.fr wrote:
> >>
> >>> And pnpacpi have some problem to activate resource with some strange
> >>> acpi implementation...
> >>
> >>
> >> I haven't seen any probs with acpi or bios or other things on
> >> those boxen yet -- pretty good ones.  It's HP ProLiant ML150
> >> machine (not G2).  There are other HP machines out here which
> >> also shows the same problem - eg HP ProLiant ML310 G1.
> >>
> > hpml310.dsl acpi dsdt is strange :
> 
> [ it's in http://www.corpit.ru/mjt/hpml310.dsdt - apache ships it
>   as Content-Type: text/plain, for some reason.  I grabbed iasl
>   and converted that stuff into .dsls, available at:
>   http://www.corpit.ru/mjt/hpml310.dsl and
>   http://www.corpit.ru/mjt/hpml150.dsl ]
> 
> Well, the problem is, I don't know *at all* how ACPI stuff works.
> So if you're saying the DSDT (whatever it is) is strange, I have
> only two choices: to believe you or not.. ;)
> 
> >             Name (CRES, ResourceTemplate ()
> >             {
> >                 IRQNoFlags () {7}
> >                 DMA (Compatibility, NotBusMaster, Transfer8) {3}
> >                 IO (Decode16, 0x0378, 0x0378, 0x08, 0x08)
> >                 IO (Decode16, 0x0678, 0x0678, 0x00, 0x06)
> >             })
> > 
> > [...]
> > Name (_PRS, ResourceTemplate ()
> >             {
> >                 StartDependentFn (0x00, 0x00)
> >                 {
> >                     IO (Decode16, 0x0378, 0x0378, 0x00, 0x08)
> >                 }
> >                 StartDependentFn (0x00, 0x00)
> >                 {
> >                     IO (Decode16, 0x03BC, 0x03BC, 0x00, 0x03)
> >                 }
> >                 StartDependentFn (0x00, 0x00)
> >                 {
> >                     IO (Decode16, 0x0278, 0x0278, 0x00, 0x08)
> >                 }
> >                 EndDependentFn ()
> >             })
> > 
> > So in the list of possible resource (_PRS) there only info about one
> > ioport not about the others resource. I wonder if it is really valid ?

Hi Michael,

I've been looking into the parport issue.

Your ACPI _PRS method does look a little unusual (and possibly broken), but
it might work if we assume that all of the other resources not mentioned are
to be disabled.

I'd like to see how the PnP layer is interpreting this, and also what your
_CRS method is giving us.

Could I see the output of:

/sys/devices/pnp0/00:XX/resources

and:

/sys/bus/pnp/devices/00:XX/options

where XX is the function number of your parport device...  In one of your
earlier emails it was "08".

> Jun  1 02:45:46 linux kernel: pnp: Device 00:08 activated.

I appreciate your help.

Thanks,
Adam
