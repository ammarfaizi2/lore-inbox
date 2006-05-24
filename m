Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964784AbWEXWlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbWEXWlH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 18:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964787AbWEXWlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 18:41:07 -0400
Received: from nz-out-0102.google.com ([64.233.162.200]:2397 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964784AbWEXWlF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 18:41:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=o0IihDe4WNWEehEOw5bTOpLeMbpnJJMF/2Fjh9rElrauK1ea44o7cpuJiW9I5bS4Rhcqoc/zCptQ97fCymRAkFYVBJDOu97IG+hEx+UY2IE1B/JdoZohpwqLItIHYvOey0C9WPgJCnOetO7mgk56v2NzykFw2ANs0Hra0bw13JE=
Message-ID: <9e4733910605241541w1c4257bej79d40ff7fff40d6f@mail.gmail.com>
Date: Wed, 24 May 2006 18:41:05 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Matthew Garrett" <mjg59@srcf.ucam.org>
Subject: Re: OpenGL-based framebuffer concepts
Cc: "Matthew Garrett" <mgarrett@chiark.greenend.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org, "D. Hazelton" <dhazelton@enter.net>
In-Reply-To: <20060524220827.GA12192@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <44700ACC.8070207@gmail.com>
	 <A78F7AE7-C3C2-43DA-9F17-D196CCA7632A@mac.com>
	 <200605230048.14708.dhazelton@enter.net>
	 <9e4733910605231017g146e16dfnd61eb22a72bd3f5f@mail.gmail.com>
	 <E1Fifom-0003qk-00@chiark.greenend.org.uk>
	 <9e4733910605231638t4da71284oa37b66a88c60cf8a@mail.gmail.com>
	 <20060524220827.GA12192@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/06, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> On Tue, May 23, 2006 at 07:38:40PM -0400, Jon Smirl wrote:
>
> > 2) The ROM support in the kernel knows about the shadow RAM copy at
> > C000::0. When you request the ROM from a laptop video system it
> > returns a map to the shadow RAM copy, not to a physical ROM. You need
> > access to the shadow RAM copy to get to things the BIOS left there
> > when it ran.
>
> My experience is that, on some laptops, the code at c000:0003 may jump
> into some other address block that isn't necessarily shadowed. There's
> no reason to assume that POSTing an ancilliary ROM will work after the
> system has left the BIOS. Further, my laptop doesn't appear to have a
> rom entry in sysfs, which makes getting at stuff that way rather more
> awkward...

As outlined in the previous mail, you don't repost a primary adapter
that has already been posted. Adapters should only get posted once.
Laptop adapters are always primary. However, you may need access to
the shadow ROM copy to get info out of it and to run non-post
functions.

A missing sysfs ROM entry is probably a bug. There is a quirk in
arch/i386 that detects shadow video ROMs and tracks the primary video
adapter. It probably needs some special case code added for your
chipset. You're the first report of it being missing. Since I don't
have your laptop you'll need to debug this yourself. It shouldn't be
hard, it is a tiny piece of code.

The ROM attribute feature is not well tested on all platforms since
not much of the user space code that should be using it hasn't been
changed yet.

-- 
Jon Smirl
jonsmirl@gmail.com
