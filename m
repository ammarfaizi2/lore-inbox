Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318065AbSIJTdw>; Tue, 10 Sep 2002 15:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318067AbSIJTdv>; Tue, 10 Sep 2002 15:33:51 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:57356 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318065AbSIJTdt>; Tue, 10 Sep 2002 15:33:49 -0400
Date: Tue, 10 Sep 2002 12:38:09 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Oliver Xymoron <oxymoron@waste.org>
cc: "David S. Miller" <davem@redhat.com>, <jgarzik@mandrakesoft.com>,
       <david-b@pacbell.net>, <mdharm-kernel@one-eyed-alien.net>,
       <greg@kroah.com>, <linux-usb-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34
In-Reply-To: <20020910193228.GL31597@waste.org>
Message-ID: <Pine.LNX.4.44.0209101236270.7106-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 10 Sep 2002, Oliver Xymoron wrote:
> 
> Which still leaves the question, does it really make sense for
> FATAL/BUG to forcibly kill the machine?

No. It should only be "locally fatal", and it should clearly just do what 
BUG() does now - kill the process.

But that implies very much that you really cannot use FATAL() in general
at all, since it would be illegal to use whenever some caller holds some
non-local locks (which is almost always the case for most "peripheral
code").

		Linus

