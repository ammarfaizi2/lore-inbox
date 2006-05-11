Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965131AbWEKEDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965131AbWEKEDQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 00:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965132AbWEKEDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 00:03:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:24963 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965131AbWEKEDQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 00:03:16 -0400
X-Authenticated: #31060655
Message-ID: <4462B737.80108@gmx.net>
Date: Thu, 11 May 2006 06:01:59 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060316 SUSE/1.0-27 SeaMonkey/1.0
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Greg KH <gregkh@suse.de>, Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, trenn@suse.de,
       thoenig@suse.de
Subject: Re: [RFC] [PATCH] Execute PCI quirks on resume from suspend-to-RAM
References: <446139FF.205@gmx.net> <20060510093942.GA12259@elf.ucw.cz> <4461C0CA.8080803@gmx.net> <20060510205600.GB23446@suse.de> <44625CE9.2060204@gmx.net> <20060511023109.GB11693@redhat.com>
In-Reply-To: <20060511023109.GB11693@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Wed, May 10, 2006 at 11:36:41PM +0200, Carl-Daniel Hailfinger wrote:
>  > Greg KH wrote:
>  > > On Wed, May 10, 2006 at 12:30:34PM +0200, Carl-Daniel Hailfinger wrote:
>  > >> Thinking about it again, if we restored the full pci config space
>  > >> on resume, this quirk handling would be completely unnecessary.
>  > >> Any reasons why we don't do that?
>  > > 
>  > > We do do that.  Look at pci_restore_state().
>  > > 
>  > > Actually, look at it in the latest -mm tree, that version works better
>  > > than mainline does right now :)
>  > 
>  > Sorry. Even the version in -mm does not restore all 256 bytes, so it
>  > will not change anything.
> 
> You can't generically look at a PCI device past the first 32 bytes.
> *anything* could be there, including registers which cause the machine
> to lock up when they get read.
> 
> This is exactly the reason that lspci by default only shows 32 bytes,
> and you need to be root to see past that limit.

You mean 64 bytes?

>  > So either we really restore the full config space (probably a good idea
>  > by itself)
> 
> No, *really* *really* bad idea :)

I had hoped the warnings in the lspci man page would be obsolete now.
Wishful thinking, it appears. Thanks for the hint.


Unfortunately, that means we either have to introduce a new PCI_FIXUP_
type or we execute PCI_FIXUP_HEADER also on resume. Which is better?


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/
