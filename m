Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319139AbSHMT4p>; Tue, 13 Aug 2002 15:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319143AbSHMT4p>; Tue, 13 Aug 2002 15:56:45 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:5049 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S319139AbSHMT4o>;
	Tue, 13 Aug 2002 15:56:44 -0400
Date: Tue, 13 Aug 2002 12:57:32 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>,
       Matthew Dobson <colpatch@us.ibm.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       Michael Hohnbaum <hohnbaum@us.ibm.com>, Greg KH <gregkh@us.ibm.com>
Subject: Re: [patch] PCI Cleanup
Message-ID: <2011880000.1029268652@flay>
In-Reply-To: <Pine.LNX.4.44.0208131013060.7411-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0208131013060.7411-100000@home.transmeta.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Quite frankly, to me it looks like the real issue is that you don't want 
> to have the byte/word/dword stuff replicated three times.

Exactly - we can do that, but it just seems messy.
 
> And your cleanup avoids the replication, but I think it has other badness 
> in it: in particular it depends on those two global pointers. Which makes 
> it really hard to have (for example) per-segment functions, or hard for 
> drivers to hook into it (there's one IDE driver in particular that wants 
> to do conf2 accesses, and nothing else. So it duplicates its own conf2 
> functions right now, because it has no way to hook into the generic ones).

OK, that IDE thing smacks of unmitigated evil to me, but if things are relying 
on it, we shouldn't change it.
 
>   And I'd suggest multiplexing them at a higher level. Instead of 
>   six different pcibios_read_config_byte etc functions, move the 
>   multiplexing up, make make them just two functions at _that_ level (and 
>   make siz #defines to make it compatible with existing users).

Yup, that sounds like ultimately the correct thing to do. Will try to get
that way done instead. Should clean things up nicely ....

M.



