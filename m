Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314048AbSDKNWW>; Thu, 11 Apr 2002 09:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314049AbSDKNWV>; Thu, 11 Apr 2002 09:22:21 -0400
Received: from mx1.toplink-plannet.de ([212.126.200.57]:15117 "EHLO
	mx1.toplink-plannet.de") by vger.kernel.org with ESMTP
	id <S314048AbSDKNWU> convert rfc822-to-8bit; Thu, 11 Apr 2002 09:22:20 -0400
From: Marc Haber <mh+linux-kernel@zugschlus.de>
To: linux-kernel@vger.kernel.org
Subject: tulip and VLAN tagging - accepting larger frames without affecting higher layers?
Date: Thu, 11 Apr 2002 15:22:21 +0200
Organization: private site, see http://www.zugschlus.de/ for details
X-Mailer: Forte Agent 1.8/32.548
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Message-Id: <E16veWm-00052F-00@janet.int.toplink-plannet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

VLAN-Tagging on Linux seems still to be problematic, despite the dot1q
patch being in the kernel since a few months. Problems arise when a
system running on an untagged switch port sends a frame using full MTU
to a system that runs VLAN tagging. The switch adds the VLAN tag to
the frame which then exceeds the MTU and is then dropped by the
receiving Linux system.

Googling for this reveals that it is thought that this is not a
hardware, but a software issue and all network cards running under
linux can be made to accept oversized frames.

For the tulip driver that we use, there are two patches available that
claim to make the card accept oversized frames. Since I am not an
experienced kernel programmer, I don't know which of these two patches
to use.

Both patches seem to tweak the MTU size by changing a few constants
and allocating a larger buffer. I am concerned that this will probably
not solve the problem in a clean way since the card will show MTU 1504
in the interface data, and application software will probably start
using the four additional bytes instead of leaving them free for the
VLAN tag.

This has been brought up on various mailing lists, but the threads
discussing this matter are usually quite short, with nobody really
knowledgeable caring to comment about this.

IMO, the clean way to do this would be to program the hardware to
receive larger frames, and to allocate the larger buffer, but to
refrain from reporting the larger MTU to higher layers, saving the
buffer space for the VLAN tag. Are patches in the works that can do
this?

OTOH, there are mailing list submissions in the archive that claim
that the tulip driver can be made to accept larger frames, thus
solving the VLAN problem without patches, by enabling support for
jumbo frames. Unfortunately, I can't find any docs how to enable that
feature.

I would appreciate any comments. Thanks in advance.

Greetings
Marc

-- 
-------------------------------------- !! No courtesy copies, please !! -----
Marc Haber          |   " Questions are the         | Mailadresse im Header
Karlsruhe, Germany  |     Beginning of Wisdom "     | Fon: *49 721 966 32 15
Nordisch by Nature  | Lt. Worf, TNG "Rightful Heir" | Fax: *49 721 966 31 29
