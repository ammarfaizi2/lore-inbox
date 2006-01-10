Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750878AbWAJGeE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbWAJGeE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 01:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbWAJGeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 01:34:04 -0500
Received: from smtpout.mac.com ([17.250.248.86]:41427 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1750878AbWAJGeC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 01:34:02 -0500
In-Reply-To: <Pine.LNX.4.64.0601091845160.5588@g5.osdl.org>
References: <20060109225143.60520.qmail@web31807.mail.mud.yahoo.com> <Pine.LNX.4.64.0601091845160.5588@g5.osdl.org>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <99D82C29-4F19-4DD3-A961-698C3FC0631D@mac.com>
Cc: "Brown, Len" <len.brown@intel.com>, "Luck, Tony" <tony.luck@intel.com>,
       Junio C Hamano <junkio@cox.net>,
       Martin Langhoff <martin.langhoff@gmail.com>,
       Linus Torvalds <torvalds@osdl.org>,
       "David S. Miller" <davem@davemloft.net>, linux-acpi@vger.kernel.org,
       LKML Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Git Mailing List <git@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: git pull on Linux/ACPI release tree
Date: Tue, 10 Jan 2006 01:33:27 -0500
To: Luben Tuikov <ltuikov@yahoo.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 09, 2006, at 21:50, Linus Torvalds wrote:
> if we  have three independent features/development trees, they can  
> be debugged independently too, while any linkages inevitably also  
> mean that any bugs end up being interlinked..

One example:

If I have ACPI, netdev, and swsusp trees change between an older  
version and a newer one, and my net driver starts breaking during  
suspend, I would be happiest debugging with the following set of  
patches/trees (Heavily simplified):

            ^
            |
           [5]
            |
          broken
         ^  ^   ^
       [2] [3]  [4]
       /    |     \
netdev3  acpi3   swsusp3
    ^       ^        ^
    |       |        |
netdev2  acpi2   swsusp2
    ^       ^        ^
    |       |        |
netdev1  acpi1   swsusp1
       ^    ^    ^
        \   |   /
         \  |  /
          \ | /
           \|/
            |
           [1]
            |
          works


If the old version [1] works and the new one [5] doesn't, then I can  
immediately test [2], [3], and [4].  If one of those doesn't work,  
I've identified the problematic patchset and cut the debugging by  
2/3.  If they all work, then we know precisely that it's the  
interactions between them, which also makes debugging a lot easier.

Cheers,
Kyle Moffett

--
There are two ways of constructing a software design. One way is to  
make it so simple that there are obviously no deficiencies. And the  
other way is to make it so complicated that there are no obvious  
deficiencies.  The first method is far more difficult.
   -- C.A.R. Hoare


