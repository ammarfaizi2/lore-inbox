Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133114AbRDRNBq>; Wed, 18 Apr 2001 09:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133116AbRDRNBh>; Wed, 18 Apr 2001 09:01:37 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39688 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S133114AbRDRNBX>;
	Wed, 18 Apr 2001 09:01:23 -0400
Date: Wed, 18 Apr 2001 14:00:59 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Chris Evans <chris@scary.beasts.org>
Cc: David Schleef <ds@schleef.org>, Dawson Engler <engler@csl.Stanford.EDU>,
        linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] copy_*_user length bugs?
Message-ID: <20010418140059.A442@flint.arm.linux.org.uk>
In-Reply-To: <20010418015254.A29893@stm.lbl.gov> <Pine.LNX.4.30.0104181206130.28455-100000@ferret.lmh.ox.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0104181206130.28455-100000@ferret.lmh.ox.ac.uk>; from chris@scary.beasts.org on Wed, Apr 18, 2001 at 12:14:56PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2001 at 12:14:56PM +0100, Chris Evans wrote:
> To justify this, consider if len were set to minus 2 billion. This will
> pass the sanity check, and pass the value straight on to copy_to_user. The
> copy_to_user parameter is unsigned, so this value because approximately
> +2Gb.

For ARM, this isn't a problem (we do 33-bit arithmetic in access_ok
specifically to catch this type of thing).  x86 does the same thing (or
did when I wrote the code for ARM.

> Now, providing the malicious user passes a low user space pointer (e.g.
> just above 0), the kernel's virtual address space wrap check will not
> trigger because ~0 + ~2Gb does not exceed 4G. And the result is the user
> being able to read kernel memory.

But ~0 + ~2GB = ~2GB.  Last time I checked, ~2GB is less than 3GB, and 3GB
is the start of kernel memory on x86.  Therefore, I don't see that the
user will be able to read kernel memory.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

