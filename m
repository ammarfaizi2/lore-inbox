Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965344AbVKGUGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965344AbVKGUGE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 15:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965330AbVKGUEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 15:04:12 -0500
Received: from mail.kroah.org ([69.55.234.183]:15789 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965322AbVKGUDs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 15:03:48 -0500
Date: Mon, 7 Nov 2005 12:02:57 -0800
From: Greg KH <greg@kroah.com>
To: linas <linas@austin.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc64-dev@ozlabs.org,
       johnrose@austin.ibm.com, linux-pci@atrey.karlin.mff.cuni.cz,
       bluesmoke-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: typedefs and structs [was Re: [PATCH 16/42]: PCI:  PCI Error reporting callbacks]
Message-ID: <20051107200257.GA22524@kroah.com>
References: <20051103235918.GA25616@mail.gnucash.org> <20051104005035.GA26929@mail.gnucash.org> <20051105061114.GA27016@kroah.com> <17262.37107.857718.184055@cargo.ozlabs.ibm.com> <20051107175541.GB19593@austin.ibm.com> <20051107182727.GD18861@kroah.com> <20051107185621.GD19593@austin.ibm.com> <20051107190245.GA19707@kroah.com> <20051107193600.GE19593@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051107193600.GE19593@austin.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 01:36:00PM -0600, linas wrote:
> On Mon, Nov 07, 2005 at 11:02:45AM -0800, Greg KH was heard to remark:
> > 
> > > I'm not to clear on what "sparse" can do; however, in the good old days,
> > > gcc allowed you to commit great sins when passing "struct blah *" to 
> > > subroutines, whereas it stoped you cold if you tried the same trick 
> > > with a typedef'ed "blah_t *".  This got me into the habit of turning
> > > all structs into typedefs in my personal projects.  Can we expect
> > > something similar for the kernel, and in particular, should we start
> > > typedefing structs now?
> > 
> > No, never typedef a struct.  That's just wrong.  
> 
> Its a defacto convention for most C-language apps, see, for 
> example Xlib, gtk and gnome.

The kernel is not those projects.

> Also, "grep typedef include/linux/*" shows that many kernel device
> drivers use this convention.

They are wrong and should be fixed.

See my old OLS paper on all about the problems of using typedefs in
kernel code.

> > gcc should warn you
> > just the same if you pass the wrong struct pointer 
> 
> There were many cases where it did not warn (I don't remember 
> the case of subr calls). I beleive this had to do with ANSI-C spec
> issues dating to the 1990's; traditional C is weakly typed.
> 
> Its not just gcc; anyoe who coded for a while eventually discovered
> that tyedefs where strongly typed, but "struct blah *" were not.

Sorry, but you are using a broken compiler if it doesn't complain about
this.

thanks,

greg k-h
