Return-Path: <linux-kernel-owner+w=401wt.eu-S937434AbWLKUQb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937434AbWLKUQb (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 15:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937532AbWLKUQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 15:16:31 -0500
Received: from thunk.org ([69.25.196.29]:35926 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937434AbWLKUQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 15:16:30 -0500
Date: Mon, 11 Dec 2006 15:15:52 -0500
From: Theodore Tso <tytso@mit.edu>
To: Andy Whitcroft <apw@shadowen.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Herbert Poetzl <herbert@13thfloor.at>,
       Olaf Hering <olaf@aepfle.de>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Steve Fox <drfickle@us.ibm.com>
Subject: Re: 2.6.19-git13: uts banner changes break SLES9 (at least)
Message-ID: <20061211201552.GB20960@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Andy Whitcroft <apw@shadowen.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Herbert Poetzl <herbert@13thfloor.at>, Olaf Hering <olaf@aepfle.de>,
	Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Steve Fox <drfickle@us.ibm.com>
References: <457D750C.9060807@shadowen.org> <20061211163333.GA17947@aepfle.de> <Pine.LNX.4.64.0612110840240.12500@woody.osdl.org> <Pine.LNX.4.64.0612110852010.12500@woody.osdl.org> <20061211180414.GA18833@aepfle.de> <20061211181813.GB18963@aepfle.de> <Pine.LNX.4.64.0612111022140.12500@woody.osdl.org> <20061211182908.GC7256@MAIL.13thfloor.at> <Pine.LNX.4.64.0612111040160.12500@woody.osdl.org> <457DAF99.4050106@shadowen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <457DAF99.4050106@shadowen.org>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2006 at 07:20:57PM +0000, Andy Whitcroft wrote:
> I am afraid to report that this second version also fails for me, as you 
> point out CIFS can break us if defined.  In fact we used to get away 
> with this on my test system due to ordering magic luck, I presume the 
> move to __initdata has triggered this.  Much as I agree that this is 
> wrong we are still going to break people with this.

But does your problem go away if you compile CIFS as a module?  If so,
then we're no worse off than before.  Still, whoever wrote the SLES
initrd needs to receive 100 lashes with a wet noodle for not proposing
a more robust solution.  

As far as whether or not it should be _mandatory_, to be able to pull
out the version information from an arbitrary bzImage file, can folks
agree that it would at least be a nice-to-have feature?  Sometimes
when you're out in the field you don't know what you're faced with,
especially if you're dealing with a customer who likes to build their
own kernels, and who might not have, ah, a very well defined release
process.  Sure, you can _call_ them incompetent, and it might even be
true, but wouldn't be nice if there was an easy way to look at a
bzImage file and be able to tell what kernel version it was built
from?

Clearly, if the goal is to make it easy to pull out, it will be
architecture specific, since it depends on the layout of the kernel
image file.  At least for x86 and x86_64, though, there's an obvious
place for it --- in the first 512 bytes of the image, in what was
previously the floppy bootstrap code.  Plenty of space there for a
100-150 bytes worth of version information.

						- Ted
