Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313477AbSDPPd3>; Tue, 16 Apr 2002 11:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313533AbSDPPd1>; Tue, 16 Apr 2002 11:33:27 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:20495 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S313477AbSDPPdX>; Tue, 16 Apr 2002 11:33:23 -0400
Date: Tue, 16 Apr 2002 08:30:12 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: David Lang <david.lang@digitalinsight.com>
cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Vojtech Pavlik <vojtech@suse.cz>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.8 IDE 36
In-Reply-To: <Pine.LNX.4.44.0204160215570.389-100000@dlang.diginsite.com>
Message-ID: <Pine.LNX.4.33.0204160825160.1167-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 16 Apr 2002, David Lang wrote:
> 
> It sounds as if you are removing this capability, am I misunderstaning you
> or is there some other way to do this? (and duplicating the drive to use
> dd to byteswap is not practical for 100G+)

Doing it with a loopback like interface at a higher level is the much 
saner operation - I understand why Martin removed the byteswap support, 
and agree with it 100%. It just didn't make any sense from a driver 
standpoint.

In fact, the byteswapping was actively incorrect, in that it swapped data 
in-place - which means that it corrupts the data area while IO is in 
progress. It also only works for PIO.

The only reason byteswapping exists is a rather historical one: Linux did 
the wrong thing for "insw/outsw" on big-endian architectures at one point 
(it byteswapped the data).

(Oh, and coupled with the fact that the IDE ID string is in a "big-endian"  
word order, which may have been one more reason to add a "do byteswapped 
IO" thing).

		Linus

