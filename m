Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262045AbUKDEgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262045AbUKDEgX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 23:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbUKDEgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 23:36:23 -0500
Received: from koto.vergenet.net ([210.128.90.7]:6870 "HELO koto.vergenet.net")
	by vger.kernel.org with SMTP id S262045AbUKDEgA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 23:36:00 -0500
Date: Thu, 4 Nov 2004 13:35:46 +0900
From: Horms <horms@verge.net.au>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Siep Kroonenberg <siepo@cybercomm.nl>,
       278068@bugs.debian.org
Subject: Re: chmod messes up permissions on hfs filesystem
Message-ID: <20041104043543.GA9634@verge.net.au>
References: <20041101043559.GA12500@verge.net.au> <Pine.LNX.4.61.0411011721560.877@scrub.home> <20041102035635.GA28481@verge.net.au> <Pine.LNX.4.61.0411031639250.877@scrub.home> <20041104033129.GQ4511@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104033129.GQ4511@verge.net.au>
X-Cluestick: seven
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2004 at 12:31:31PM +0900, Horms wrote:
> On Wed, Nov 03, 2004 at 05:00:35PM +0100, Roman Zippel wrote:
> > Hi,
> > 
> > On Tue, 2 Nov 2004, Horms wrote:
> > 
> > > Thanks for the patch, though the behaviour of the umask still seems
> > > rather odd. I would like to offer an updated patch which I believe
> > > makes the umask behave in the expected way. It also ensures
> > > that the write_lock bit is read from/written to disk correctly.
> > 
> > You apply the umask before updating the write bit, which is incorrect.
> 
> I tried to account for that, but perhaps I missed.

Hi,

I think that I am a little confused here.
By applying the umask after any write bits set from
disk or by the user they are overridden.
I thought the intention of the umask was to provide
a default, not to override user-derived values.

In the case of msdos, which I believe is where this came from
there are no user or disk inputs as the file system does
not have any permissions as such. So the umask can just be
unilaterally applied.

But in the case of hfs, where there is one permission bit,
I think it would make sense for user requests, which are subsequently
written to disk, to override the umask. Does that make sense?

-- 
Horms
