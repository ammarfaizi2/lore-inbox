Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbTI3MmC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 08:42:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261447AbTI3MmC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 08:42:02 -0400
Received: from petasus.isw.intel.com ([192.55.37.196]:59639 "EHLO
	petasus.isw.intel.com") by vger.kernel.org with ESMTP
	id S261440AbTI3Mlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 08:41:45 -0400
Date: Tue, 30 Sep 2003 14:41:33 +0200 (CEST)
From: Artur Klauser <Artur.Klauser@computer.org>
To: Andreas Schwab <schwab@suse.de>
cc: Matti Aarnio <matti.aarnio@zmailer.org>,
       Rogier Wolff <Swen-Trap1@BitWizard.nl>, linux-kernel@vger.kernel.org
Subject: Re: div64.h:do_div() bug
In-Reply-To: <je8yo6e9vz.fsf@sykes.suse.de>
Message-ID: <Pine.LNX.4.58.0309301434520.30778@fcfcp001.hcp.vagry.pbz>
References: <Pine.LNX.4.51.0309291503030.7947@enm.xynhfre.bet>
 <20030930095229.GA32421@bitwizard.nl> <20030930101438.GJ1058@mea-ext.zmailer.org>
 <20030930112830.GK1058@mea-ext.zmailer.org> <je8yo6e9vz.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Sep 2003, Andreas Schwab wrote:
> Matti Aarnio <matti.aarnio@zmailer.org> writes:
> > On Tue, Sep 30, 2003 at 01:14:38PM +0300, Matti Aarnio wrote:
> >> On Tue, Sep 30, 2003 at 11:52:29AM +0200, Rogier Wolff wrote:
> >> > On Mon, Sep 29, 2003 at 03:25:19PM +0200, Artur Klauser wrote:
> >> > > I've found that a bug in asm-arm/div64.h:do_div() is preventing correct
> >> > > conversion of timestamps in smbfs (and probably ntfs as well) from NT to
> >> >
> >> > Nope.
> >>
> >>   Nope yourself.
> >>
> >> > >   if (in.n64 != out.n64) {
> >> > >     printf("FAILURE: asm/div64.h:do_div() is broken for 64-bit dividends\n");
> >> >
> >> > do_div should be/is documented as not doing 64 bit dividents. It does
> >> > 64/32 -> 32 divides, IIRC...
> >>
> >>   64/32 -> 64,32
> >>
> >> The REMAINDER is 32 bit value.
> >
> > Non-native english speaker makes the mistake..  MODULUS is 32 bits as is
> > DIVISOR, REMAINDER is 64 bit, as is DIVIDEND.
> >
> > That is:
> > 	DIVIDEND / DIVISOR -> REMAINDER , MODULUS
>                               ^^^^^^^^^^^^^^^^^^^
> ???
>                               QUOTIENT, REMAINDER

Actually, I have to agree with Andreas here - and with Matti's 1st naming
attempt :)

But whatever the naming is, the operation AFAICT should be, and is
implemented that way in other asm-<arch>/div64.h:do_div() macros:

do_div(u64, u32)
  u64 / u32  ->  u64  (modifies 1st argument)
  u64 % u32  ->  u32  (return value)

 -r2r-
