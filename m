Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267447AbUIFT6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267447AbUIFT6Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 15:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267474AbUIFT6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 15:58:25 -0400
Received: from [195.135.223.162] ([195.135.223.162]:32130 "EHLO
	midnight.ucw.cz") by vger.kernel.org with ESMTP id S267447AbUIFT6X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 15:58:23 -0400
Date: Mon, 6 Sep 2004 21:58:42 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Alessandro Rubini <rubini@ipvvis.unipv.it>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] allow i8042 register location override
Message-ID: <20040906195841.GA1048@ucw.cz>
References: <20040902175647.97709.qmail@web81309.mail.yahoo.com> <200409030941.24557.bjorn.helgaas@hp.com> <20040906122237.GA316@ucw.cz> <200409061328.31045.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200409061328.31045.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 06, 2004 at 01:28:30PM -0500, Dmitry Torokhov wrote:
> On Monday 06 September 2004 07:22 am, Vojtech Pavlik wrote:
> > On Fri, Sep 03, 2004 at 09:41:24AM -0600, Bjorn Helgaas wrote:
> > > On Friday 03 September 2004 12:57 am, Dmitry Torokhov wrote:
> > > > What do you think about the patch below? I renamed some function/variable
> > > > names to be more in line with the rest of i8042 code, other than that
> > > > its pretty much your code.
> > > 
> > > That looks great to me, and it works fine on my DL360.
> > > 
> > > My only comment is that in an ideal world, we would not have to
> > > change any drivers if a new architecture started supporting ACPI.
> > > With the current patch, we'd have to twiddle some of the i8042-XXX.h
> > > files a bit.  But I don't think it's worth the trouble of restructuring
> > > them to fix that.
> > > 
> > > Thanks for all your help!
> > 
> > One bug that I could spot immediately is that the patch sets i8042_reset
> > on i386. This doesn't seem intentional, and is quite wrong, too, since
> > on some older machines it confuses the BIOS.
> 
> Nope it does not. It is only on IA64:
> 
> > +#if defined(__ia64__)
> > +        i8042_reset = 1;
> > +#endif
> which is in i8042-x86ia64io.h
> 
> This fragment is in i8042-io.h which is not included in by Intel-originated
> arches anymore.
> 
> > -#if !defined(__i386__) && !defined(__x86_64__)
> >          i8042_reset = 1;
> > -#endif
> 
> Did I miss something?
 
No, sorry, I did. I didn't notice the fact that i8042-io.h is not used
on i386 at all.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
