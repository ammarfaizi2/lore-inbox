Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964953AbVKGTDR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964953AbVKGTDR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 14:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964963AbVKGTDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 14:03:16 -0500
Received: from mail.kroah.org ([69.55.234.183]:12693 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964953AbVKGTDP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 14:03:15 -0500
Date: Mon, 7 Nov 2005 11:02:45 -0800
From: Greg KH <greg@kroah.com>
To: linas <linas@austin.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc64-dev@ozlabs.org,
       johnrose@austin.ibm.com, linux-pci@atrey.karlin.mff.cuni.cz,
       bluesmoke-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: typedefs and structs [was Re: [PATCH 16/42]: PCI:  PCI Error reporting callbacks]
Message-ID: <20051107190245.GA19707@kroah.com>
References: <20051103235918.GA25616@mail.gnucash.org> <20051104005035.GA26929@mail.gnucash.org> <20051105061114.GA27016@kroah.com> <17262.37107.857718.184055@cargo.ozlabs.ibm.com> <20051107175541.GB19593@austin.ibm.com> <20051107182727.GD18861@kroah.com> <20051107185621.GD19593@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051107185621.GD19593@austin.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 12:56:21PM -0600, linas wrote:
> On Mon, Nov 07, 2005 at 10:27:27AM -0800, Greg KH was heard to remark:
> > 
> > 3) realy strong typing that sparse can detect.
> 
> Am compiling now.
> 
> > enums don't really work, as you can get away with using an integer and
> > the compiler will never complain.  Please use a typedef (yeah, I said
> > typedef) in the way that sparse will catch any bad users of the code.
> 
> How about typedef'ing  structs?

No.  Use __bitwise.  See the lkml archives for how to do this properly.

> I'm not to clear on what "sparse" can do; however, in the good old days,
> gcc allowed you to commit great sins when passing "struct blah *" to 
> subroutines, whereas it stoped you cold if you tried the same trick 
> with a typedef'ed "blah_t *".  This got me into the habit of turning
> all structs into typedefs in my personal projects.  Can we expect
> something similar for the kernel, and in particular, should we start
> typedefing structs now?

No, never typedef a struct.  That's just wrong.  gcc should warn you
just the same if you pass the wrong struct pointer (and all of your code
builds without warnings, right?)

> (Documentation/CodingStyle doesn't mention typedef at all).

If it does, it should say not to use it at all :)

Except for this case, it's special...

thanks,

greg k-h
