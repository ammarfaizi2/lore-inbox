Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268152AbTBNA3M>; Thu, 13 Feb 2003 19:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268153AbTBNA3M>; Thu, 13 Feb 2003 19:29:12 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36368 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S268152AbTBNA3L>;
	Thu, 13 Feb 2003 19:29:11 -0500
Message-ID: <3E4C3A8A.3030207@pobox.com>
Date: Thu, 13 Feb 2003 19:38:34 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Ion Badulescu <ionut@badula.org>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [net drvr] starfire driver update for 2.5.60
References: <Pine.LNX.4.44.0302131859550.13539-100000@guppy.limebrokerage.com>
In-Reply-To: <Pine.LNX.4.44.0302131859550.13539-100000@guppy.limebrokerage.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm curious about the ring-wrapping code... the comments indicate you 
may not have fully investigated the ring-wrapping semantics?

There are two predominant styles, the "Becker style", which relies on 
proper unsigned integer subtraction even when your buffer-head index is 
numerically less than your buffer-tail, and the "DaveM" style which hide 
a couple masks behind NEXT_TX() style macros.  Either of these work, and 
are quite well thought out and well tested.

Neither style requires any special handling of "wrap" cases, which your 
patch adds..  Your patch adds things like arbitrary padding of 4 tx 
slots, where you might as well add a comment "/* for luck! */".  Why not 
actually nail down the problems the code is obvious working around? 
Such "knobs" may be tweaked enough to be stable in test setups, but 
without actually knowing why you are having problems with Tx start/stop 
at the edge cases, the driver won't begin to approach true stability.

A minor style point too, "s/struct foodesc/foodesc/" is going the 
opposite of preferred.

This is why I have not applied your patch when it was sent to me...

	Jeff



