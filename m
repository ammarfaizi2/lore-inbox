Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132531AbRDATDv>; Sun, 1 Apr 2001 15:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132534AbRDATDb>; Sun, 1 Apr 2001 15:03:31 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:28164 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S132531AbRDATD3>; Sun, 1 Apr 2001 15:03:29 -0400
Date: 01 Apr 2001 13:48:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <7z0azVOXw-B@khms.westfalen.de>
In-Reply-To: <E14jdkF-0007Ps-00@tytlal>
Subject: Re: [RFC] sane access to per-fs metadata (was Re: [PATCH] Documentatio
X-Mailer: CrossPoint v3.12d.kh5 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <OF791BBBC5.E3FCBEEE-ON87256A18.005BA3B7@LocalDomain> <E14jdkF-0007Ps-00@tytlal>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

chip@valinux.com (Chip Salzenberg)  wrote on 01.04.01 in <E14jdkF-0007Ps-00@tytlal>:

> Why not have a kernel thread and use standard RPC techniques like
> sockets?  Then you'd not have to invent anything unimportant like
> Yet Another IPC Technique.

You can, of course, transfer the exact same RPC messages over a file  
descriptor on your metadata fs. It doesn't *have* to be ASCII, especially  
not for purely internal-use interfaces.

And for ioctl() fans, you could transfer the exact same data via read()/ 
write() again. That's not significantly harder. Especially if you write a  
wrapper around the calls. If you want to be perverse, you can probably  
even transmit user space pointers.

But I suspect there are really only two generally useful interfaces:

1. A text based interface for generally-useful stuff you might want to  
manipulate from the shell, or random user programs. (From the shell _is_  
random user programs.)

2. A RPC based interface for tightly-coupled fs utilities. (I don't know  
off the top of my head what the kernel already has - ISTR networking has  
_something_.)

Don't forget a version marker of some kind. Sooner or later, you'll be  
glad you have it.

MfG Kai
