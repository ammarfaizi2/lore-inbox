Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965184AbVKGTgI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965184AbVKGTgI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 14:36:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965188AbVKGTgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 14:36:08 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:61138 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S965184AbVKGTgF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 14:36:05 -0500
Date: Mon, 7 Nov 2005 13:36:00 -0600
To: Greg KH <greg@kroah.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc64-dev@ozlabs.org,
       johnrose@austin.ibm.com, linux-pci@atrey.karlin.mff.cuni.cz,
       bluesmoke-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: typedefs and structs [was Re: [PATCH 16/42]: PCI:  PCI Error reporting callbacks]
Message-ID: <20051107193600.GE19593@austin.ibm.com>
References: <20051103235918.GA25616@mail.gnucash.org> <20051104005035.GA26929@mail.gnucash.org> <20051105061114.GA27016@kroah.com> <17262.37107.857718.184055@cargo.ozlabs.ibm.com> <20051107175541.GB19593@austin.ibm.com> <20051107182727.GD18861@kroah.com> <20051107185621.GD19593@austin.ibm.com> <20051107190245.GA19707@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051107190245.GA19707@kroah.com>
User-Agent: Mutt/1.5.6+20040907i
From: linas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 11:02:45AM -0800, Greg KH was heard to remark:
> 
> > I'm not to clear on what "sparse" can do; however, in the good old days,
> > gcc allowed you to commit great sins when passing "struct blah *" to 
> > subroutines, whereas it stoped you cold if you tried the same trick 
> > with a typedef'ed "blah_t *".  This got me into the habit of turning
> > all structs into typedefs in my personal projects.  Can we expect
> > something similar for the kernel, and in particular, should we start
> > typedefing structs now?
> 
> No, never typedef a struct.  That's just wrong.  

Its a defacto convention for most C-language apps, see, for 
example Xlib, gtk and gnome.  Also, "grep typedef include/linux/*"
shows that many kernel device drivers use this convention.

> gcc should warn you
> just the same if you pass the wrong struct pointer 

There were many cases where it did not warn (I don't remember 
the case of subr calls). I beleive this had to do with ANSI-C spec
issues dating to the 1990's; traditional C is weakly typed.

Its not just gcc; anyoe who coded for a while eventually discovered
that tyedefs where strongly typed, but "struct blah *" were not.

> (and all of your code
> builds without warnings, right?)

:-/  Yes, of course.

--linas
