Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261549AbUKGHCh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261549AbUKGHCh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 02:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261550AbUKGHCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 02:02:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:50369 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261549AbUKGHCf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 02:02:35 -0500
Date: Sat, 6 Nov 2004 23:02:28 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Christian Kujau <evil@g-house.de>
cc: LKML <linux-kernel@vger.kernel.org>, alsa-devel@lists.sourceforge.net,
       perex@suse.cz
Subject: Re: Oops in 2.6.10-rc1
In-Reply-To: <418D7959.4020206@g-house.de>
Message-ID: <Pine.LNX.4.58.0411062244150.2223@ppc970.osdl.org>
References: <4180F026.9090302@g-house.de> <Pine.LNX.4.58.0410281526260.31240@pnote.perex-int.cz>
 <4180FDB3.8080305@g-house.de> <418A47BB.5010305@g-house.de>
 <418D7959.4020206@g-house.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 7 Nov 2004, Christian Kujau wrote:
> 
> if someone could give me a hint here what to do next or perhaps tell me
> that the whole things was totally pointless - please say so.
> i am somehow lost as to which is the right person to bug here.

Since you seem to be a BK user, try doing a

	bk revtool sound/pci/ens1370.c 

and see if you can find the change that caused your problem. Of course, 
the real change might be somewhere else in the sound driver initialization 
path, so it's not like just that one file might be the cause. Regardöess, 
the more you can pinpoint when the problem started, the better.

Also, if you enable frame pointers (under kernel debugging), the traceback
will look a bit better. As it is, your oops looks looks like something has
jumped off into la-la-land by jumping through a bad pointer (the value is
still in %ecx), but it's definitely not clear _where_ that happened.  
Your trace points to pci_enable_device_bars(), but that may well be just
stale stack contents.

		Linus
