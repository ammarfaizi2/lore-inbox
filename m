Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272648AbRIGNXQ>; Fri, 7 Sep 2001 09:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272649AbRIGNXH>; Fri, 7 Sep 2001 09:23:07 -0400
Received: from [195.89.159.99] ([195.89.159.99]:13301 "EHLO
	kushida.degree2.com") by vger.kernel.org with ESMTP
	id <S272648AbRIGNW7>; Fri, 7 Sep 2001 09:22:59 -0400
Date: Fri, 7 Sep 2001 02:47:46 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: notion of a local address [was: Re: ioctl SIOCGIFNETMASK: ip alias bug 2.4.9 and 2.2.19]
Message-ID: <20010907024746.C7329@kushida.degree2.com>
In-Reply-To: <20010906212303.A23595@castle.nmd.msu.ru> <20010906173948.502BFBC06C@spike.porcupine.org> <9n8ev1$qba$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <9n8ev1$qba$1@cesium.transmeta.com>; from hpa@zytor.com on Thu, Sep 06, 2001 at 11:23:29AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> In autofs, I use the following technique to determine if the IP number
> for a host is local (and therefore vfsbinds can be used rather than
> NFS mounts):
> 
> connect a datagram socket (which won't produce any actual traffic) to
> the remote host with INADDR_ANY as the local address, and then query
> the local address.  If the local address is the same as the remote
> address, the address is local.

Nice.  Gives false negatives in some cases (e.g. a local tunnel) but
that doesn't really matter.

I've considered this technique for deciding whether it's safe to use the
MIT-SHM extension with X:

Open a SHM segment; write fairly secure random data into it; ask the X
server to connect to that segment and read it back as an image over the
X protocol; check whether they match.

If the X server reports an error, it's remote.  If it finds a SHM
segment it may still be remote, hence the random data check.

-- Jamie
