Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282511AbSBJV4U>; Sun, 10 Feb 2002 16:56:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280975AbSBJV4L>; Sun, 10 Feb 2002 16:56:11 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:32710 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id <S279798AbSBJVzz>;
	Sun, 10 Feb 2002 16:55:55 -0500
To: <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, davem@redhat.com,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: My HDLC patch and the recent discussion...
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 10 Feb 2002 21:58:22 +0100
Message-ID: <m36655m4up.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Does anybody have additional comments on the HDLC (SIOCDEVICE etc)?

A copy of my previous lkml message follows.
-- 
Krzysztof Halasa
Network Administrator



Jeff Garzik <garzik@havoc.gtf.org> writes:

> "SIOCDEVICE" as a constant is unacceptable, so it would need to be
> SIOCWANDEVICE or something similar.

Well, I was probably under impression it should be used for Ethernet
as well (see the Dec 2000 thread)... Now I think I know people
using Ethernet (with full duplex over SM fibre) for WAN connections
- so SIOCWANDEVICE is ok. Not sure about TR, though - anyone using
it for WAN networking?

> SIOCETHTOOL, for example, is an ioctl which actually provides
> sub-ioctls, so that is probably a good model to follow.

SIOCDEVICE^WSIOCWANDEVICE of course has sub-ioctls as well. It is
obviously impossible without them.


I do _not_ want to fight any ETHTOOL vs SIOCDEVICE etc. battle here.
What I want is creating the best interface for controlling network
devices. Including Token Ring and Ethernet, unless there are valid
reasons to do otherwise.

I think we should concentrate on the interface first, then I will
patch the HDLC implementation.

If we're here... maybe we should really drop using the ifreq structure
and _replace_ it with better one (variable-sized)? It can be done
gradually, as both are quite compatible.
-- 
Krzysztof Halasa
