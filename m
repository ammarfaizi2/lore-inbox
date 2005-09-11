Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750845AbVIKUIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750845AbVIKUIp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 16:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750847AbVIKUIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 16:08:45 -0400
Received: from imap.gmx.net ([213.165.64.20]:35732 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750844AbVIKUIo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 16:08:44 -0400
X-Authenticated: #2813124
From: Daniel Ritz <daniel.ritz@gmx.ch>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.13-mm2
Date: Sun, 11 Sep 2005 22:08:44 +0200
User-Agent: KMail/1.7.2
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org,
       Hugh Dickins <hugh@veritas.com>
References: <20050908053042.6e05882f.akpm@osdl.org> <200509111903.38938.rjw@sisk.pl> <20050911123627.2551a057.akpm@osdl.org>
In-Reply-To: <20050911123627.2551a057.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509112208.44422.daniel.ritz@gmx.ch>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 11 September 2005 21.36, Andrew Morton wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> >
> > > 
> >  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13/2.6.13-mm2/
> >  > 
> >  > (kernel.org propagation is slow.  There's a temp copy at
> >  > http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.13-mm2.bz2)
> > 
> >  Could you please reintroduce the yenta-free_irq-on-suspend.patch (attached)
> >  into -mm?  My box does not resume from disk without it.
> 
> No probs.
> 
> Daniel, do you remember why we decided to drop it?  What should we do about
> this?  Thanks.
> 

yeah, there was a long discussion about it. see:
	http://marc.theaimsgroup.com/?t=112275164900002&r=1&w=4
the reason being that it breaks APM suspend on Hugh Dickins' (added to cc:) laptop.
Linus was quite clear about why reverting...
	http://marc.theaimsgroup.com/?l=linux-kernel&m=112278810115252&w=4

we should look at both problems in detail:
- with APM it seems to break because the bridge gives interrupt before the
  handler is installed.
- with ACPI i think some _other_ device gives the interrupts too early. but
  when all devices on the interrupt unregister the irq is disabled and the
  problem is hidden.

i don't think we can do mutch about the APM case...

so Rafael, your /proc/interrupts, lspci -vvv and dmesg, please.

rgds
-daniel
