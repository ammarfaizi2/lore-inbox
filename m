Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313184AbSDULlu>; Sun, 21 Apr 2002 07:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313238AbSDULlt>; Sun, 21 Apr 2002 07:41:49 -0400
Received: from secure.tummy.com ([216.17.150.2]:9669 "HELO tummy.com")
	by vger.kernel.org with SMTP id <S313184AbSDULls>;
	Sun, 21 Apr 2002 07:41:48 -0400
Date: Sun, 21 Apr 2002 05:41:45 -0600
From: Sean Reifschneider <jafo@tummy.com>
To: Anton Altaparmakov <aia21@cantab.net>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: eNBD on loopback [was Re: [PATCH] 2.5.8 IDE 36]
Message-ID: <20020421054145.H2866@tummy.com>
In-Reply-To: <20020420212833.G2866@tummy.com> <5.1.0.14.2.20020421113007.04012810@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 21, 2002 at 11:40:09AM +0100, Anton Altaparmakov wrote:
>I haven't tried RAID... Interesting idea though.

My use for it was in a high availability cluster, where I was using NBD to
set up shared storage between the two machines.

Another challenge I ran into, which DRBD solves well, is that it was hard
to get the RAID to operate in degraded mode.  It would try to access the
block device on the first startup of the md device after the primary
failure, even if the raidtab told it the drive was dead...  I finally just
set up a noop nbd server that would return the proper size on startup, but
any subsequent read/writes would fail...

>nbd is also actively developed. The only problem is nobody has bothered to 
>update the kernel documentation to point to the website where development 
>happens. )-:

Updates to the Configuration documentation would really help.  I've asked
google to index nbd.sf.net, and also asked Alan Robertson to add it to his
list of shared storage alternatives on the linux-ha.com site.  When I was
trying to get NBD going, I was unable to find nbd.sf.net through google,
though this may have changed in month since I was doing the work...

Sean
-- 
 Got Source?
Sean Reifschneider, Inimitably Superfluous <jafo@tummy.com>
tummy.com - Linux Consulting since 1995. Qmail, KRUD, Firewalls, Python
