Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283112AbRK2JHr>; Thu, 29 Nov 2001 04:07:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283113AbRK2JHh>; Thu, 29 Nov 2001 04:07:37 -0500
Received: from okcforum.org ([207.43.150.207]:41487 "EHLO okcforum.org")
	by vger.kernel.org with ESMTP id <S283112AbRK2JHW>;
	Thu, 29 Nov 2001 04:07:22 -0500
Subject: Re: Unresponiveness of 2.4.16 revisited
From: "Nathan G. Grennan" <ngrennan@okcforum.org>
To: linux-kernel@vger.kernel.org
In-Reply-To: <3C05EE56.A06C6FB9@zip.com.au>
In-Reply-To: <3C05D608.6D06190D@zip.com.au>,
	<1006928344.2613.2.camel@cygnusx-1.okcforum.org> 
	<3C05D608.6D06190D@zip.com.au>
	<1007021221.1739.0.camel@cygnusx-1.okcforum.org> 
	<3C05EE56.A06C6FB9@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 29 Nov 2001 03:07:00 -0600
Message-Id: <1007024821.1528.3.camel@cygnusx-1.okcforum.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-11-29 at 02:14, Andrew Morton wrote:

> 
> If you can generate hard numbers (just time the RP command, for a start)
> and they show regression, then go ahead and post!
> 
> Let's put the atime thing down as a known ext3 problem for a
> while.  (does it happen with ext2?  You sure?).
> 
> Running noatime won't hurt a thing.  It just prevents the kernel
> from recording when a file was last accessed, within the file's
> inode.  It's a feature whichis used by backup/archiving programs,
> and probably by mailbox monitoring programs (xbiff, etc).  People
> turn it off all the time...

ok, I doubled checked things. It seems mounting an ext3 filesystem as
ext2 is somewhat a myth. If the kernel supports ext3 it still mounts it
as ext3 even if /etc/fstab says ext2. When I tried 2.4.16 with ext3
support, but with the journal exactly removed to make it a ext2
filesystem the --rebuild worked just like it does in 2.4.9-13. So it
does seem to be a problem with just ext3, and I guess they changed the
journaling of atimes between the version in 2.4.9-13 and 2.4.16. It all
now makes sense. Thank you for your help.

As for my comment before and Rik's VM vs AA's VM on cache agressiveness,
it looks like I was off. It just seems to vary on some dynamic. I
thought I checked them at the same points after boot, but between
different boots seemed to get different results, who knows.

