Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270121AbRHRMfN>; Sat, 18 Aug 2001 08:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271817AbRHRMfE>; Sat, 18 Aug 2001 08:35:04 -0400
Received: from u-134-18.karlsruhe.ipdial.viaginterkom.de ([62.180.18.134]:45952
	"EHLO dea.waldorf-gmbh.de") by vger.kernel.org with ESMTP
	id <S270121AbRHRMe6>; Sat, 18 Aug 2001 08:34:58 -0400
Date: Sat, 18 Aug 2001 14:32:32 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Justin Guyett <justin@soze.net>
Cc: Jim Roland <jroland@roland.net>, linux-kernel@vger.kernel.org
Subject: Re: Aliases
Message-ID: <20010818143232.A11687@bacchus.dhis.org>
In-Reply-To: <00df01c127a8$c354ad20$bb1cfa18@JimWS> <Pine.LNX.4.33.0108180245070.27721-100000@kobayashi.soze.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0108180245070.27721-100000@kobayashi.soze.net>; from justin@soze.net on Sat, Aug 18, 2001 at 03:30:59AM -0700
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 18, 2001 at 03:30:59AM -0700, Justin Guyett wrote:

> > Having recently gone from 2.2 to 2.4 what's the device convention now?  I
> > thought it was eth0 (example) and eth0:0 .. eth0:255, but knew kernel 2.4
> > would take it further.
> 
> presuming this isn't an ifconfig limit instead of a kernel limit, trying
> "ifconfig eth0:x" works for x < 10000, anything > 10000 and x becomes
> x%10000.

For various reasons interfaces aliases are deprecated.  The recommended
way of doing things these days is just adding more addresses to an
interface with the ip(8) program from the iproute package.  It works like:

  ip addr add 192.168.2.0/24 broadcast 192.168.2.255 scope host dev eth0

> However, 2.4 also has multiple addresses of the same type per device;
> unfortunately it's fairly slow.  Adding or deleting addresses seems to
> take ~5 seconds per 255 addresses on my machine, and listing addresses
> takes about 1 second / 300 addresses on the same machine.

It seems you've tried to add individual addresses, one by one.  That's not
necessary, you can add the addresses of a whole subnet to the kernel.  If
you have a large network that's dramatically faster and easier to
administrate.

> Also, listing addresses for another interface isn't any faster, which is
> unfortunate; ip shouldn't need to check addresses of all interfaces just
> to get the ones for the requested interface.
> 
> At least listing time seems to increase linearly with the number of
> addresses.  IIRC someone posted a patch a few weeks ago to speed this up
> (no longer sits for a long time before listing addresses).
> 
> time ip addr show dev eth1 | wc -l
>   37766
> ip addr show dev eth1  113.17s user 1.82s system 99% cpu 1:55.38 total

That's crude abuse unless your IPs are actually non-contiguous in address
space - which they're almost certainly not.

> Also, ifconfig, which has no idea about any but the first address in an
> address class, also does nothing for the same amount of time before
> listing interfaces.

ifconfig is deprecated as it permits you only access to a small part of
power of the current Linux networking; ip is the recommended replacement.

> Anyway, it seems ip and the 2.4 scheme with multiple addresses per
> interface can handle many more addresses than ifconfig and the device
> alias scheme.

Try ``ip addr add 10.0.0.0/8 broadcast 10.255.255.255 scope host dev eth0''
with interface aliases :-)

  Ralf
