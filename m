Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271809AbRHRLV3>; Sat, 18 Aug 2001 07:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271811AbRHRLVT>; Sat, 18 Aug 2001 07:21:19 -0400
Received: from adsl-64-175-255-50.dsl.sntc01.pacbell.net ([64.175.255.50]:3775
	"HELO kobayashi.soze.net") by vger.kernel.org with SMTP
	id <S271809AbRHRLVG>; Sat, 18 Aug 2001 07:21:06 -0400
Date: Sat, 18 Aug 2001 03:30:59 -0700 (PDT)
From: Justin Guyett <justin@soze.net>
X-X-Sender: <tyme@kobayashi.soze.net>
To: Jim Roland <jroland@roland.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Aliases
In-Reply-To: <00df01c127a8$c354ad20$bb1cfa18@JimWS>
Message-ID: <Pine.LNX.4.33.0108180245070.27721-100000@kobayashi.soze.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Aug 2001, Jim Roland wrote:

> Having recently gone from 2.2 to 2.4 what's the device convention now?  I
> thought it was eth0 (example) and eth0:0 .. eth0:255, but knew kernel 2.4
> would take it further.

presuming this isn't an ifconfig limit instead of a kernel limit, trying
"ifconfig eth0:x" works for x < 10000, anything > 10000 and x becomes
x%10000.

However, 2.4 also has multiple addresses of the same type per device;
unfortunately it's fairly slow.  Adding or deleting addresses seems to
take ~5 seconds per 255 addresses on my machine, and listing addresses
takes about 1 second / 300 addresses on the same machine.

Also, listing addresses for another interface isn't any faster, which is
unfortunate; ip shouldn't need to check addresses of all interfaces just
to get the ones for the requested interface.

At least listing time seems to increase linearly with the number of
addresses.  IIRC someone posted a patch a few weeks ago to speed this up
(no longer sits for a long time before listing addresses).

time ip addr show dev eth1 | wc -l
  37766
ip addr show dev eth1  113.17s user 1.82s system 99% cpu 1:55.38 total

Also, ifconfig, which has no idea about any but the first address in an
address class, also does nothing for the same amount of time before
listing interfaces.

Anyway, it seems ip and the 2.4 scheme with multiple addresses per
interface can handle many more addresses than ifconfig and the device
alias scheme.


justin

