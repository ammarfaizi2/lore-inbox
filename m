Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268457AbUIFS2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268457AbUIFS2g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 14:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268458AbUIFS2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 14:28:36 -0400
Received: from smtp803.mail.sc5.yahoo.com ([66.163.168.182]:55932 "HELO
	smtp803.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268457AbUIFS2d convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 14:28:33 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH] allow i8042 register location override
Date: Mon, 6 Sep 2004 13:28:30 -0500
User-Agent: KMail/1.6.2
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Alessandro Rubini <rubini@ipvvis.unipv.it>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <20040902175647.97709.qmail@web81309.mail.yahoo.com> <200409030941.24557.bjorn.helgaas@hp.com> <20040906122237.GA316@ucw.cz>
In-Reply-To: <20040906122237.GA316@ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200409061328.31045.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 September 2004 07:22 am, Vojtech Pavlik wrote:
> On Fri, Sep 03, 2004 at 09:41:24AM -0600, Bjorn Helgaas wrote:
> > On Friday 03 September 2004 12:57 am, Dmitry Torokhov wrote:
> > > What do you think about the patch below? I renamed some function/variable
> > > names to be more in line with the rest of i8042 code, other than that
> > > its pretty much your code.
> > 
> > That looks great to me, and it works fine on my DL360.
> > 
> > My only comment is that in an ideal world, we would not have to
> > change any drivers if a new architecture started supporting ACPI.
> > With the current patch, we'd have to twiddle some of the i8042-XXX.h
> > files a bit.  But I don't think it's worth the trouble of restructuring
> > them to fix that.
> > 
> > Thanks for all your help!
> 
> One bug that I could spot immediately is that the patch sets i8042_reset
> on i386. This doesn't seem intentional, and is quite wrong, too, since
> on some older machines it confuses the BIOS.

Nope it does not. It is only on IA64:

> +#if defined(__ia64__)
> +        i8042_reset = 1;
> +#endif
which is in i8042-x86ia64io.h

This fragment is in i8042-io.h which is not included in by Intel-originated
arches anymore.

> -#if !defined(__i386__) && !defined(__x86_64__)
>          i8042_reset = 1;
> -#endif

Did I miss something?

-- 
Dmitry
