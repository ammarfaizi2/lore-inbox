Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263522AbTKKPRx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 10:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263565AbTKKPRx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 10:17:53 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:9489 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S263522AbTKKPRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 10:17:52 -0500
Message-ID: <3FB0FFA4.3060107@techsource.com>
Date: Tue, 11 Nov 2003 10:26:28 -0500
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: "H. Peter Anvin" <hpa@zytor.com>, Davide Libenzi <davidel@xmailserver.org>,
       Larry McVoy <lm@bitmover.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel.bkbits.net off the air
References: <3FAFD1E5.5070309@zytor.com> <Pine.LNX.4.44.0311101004150.2097-100000@bigblue.dev.mdolabs.com> <20031110183722.GE6834@x30.random> <3FAFE22B.3030108@zytor.com> <20031110193101.GF6834@x30.random> <3FAFEA34.7090005@zytor.com> <20031110234108.GG6834@x30.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pardon my late intrusion into this discussion of what appears to 
be CVS mirror coherency.  The impression I get, which may be wrong, is 
that one or both of these problems is happening:

- A user is pulling from one CVS mirror, but that mirror is in the 
process of being updated from the BK source, so the user gets some new 
files and some old ones.

- A user is pulling from more than one CVS mirror at the same time, and 
not all mirrors are at the same revision level.


Either way, and I would not be surprised if someone else had suggested 
this already, but being a graphics person, let me suggest a common 
technique for dealing with this problem:  double-buffering.


Let's assume a combination of the two above cases, because the general 
solution applies to all cases.

To begin with, all mirrors serve from the "front buffer", all of which 
are known to be at the same revision level for all files.  While serving 
the front buffers, the "back buffers" are being updated.

At a prescribed time, all servers go off-line (to deal with 
asynchronicity between clocks), swap the front and back buffers, and 
then go back online.

The synchronization problem can be dealt with either by having everyone 
have their clocks set relatively close but go offline for a few seconds 
just in case there is some drift, or there can be a master server which 
signals the others when to swap buffers.


