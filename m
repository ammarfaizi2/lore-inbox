Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S131756AbRC1MJc>; Wed, 28 Mar 2001 07:09:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S131772AbRC1MJX>; Wed, 28 Mar 2001 07:09:23 -0500
Received: from mailproxy.de.uu.net ([192.76.144.34]:55272 "EHLO mailproxy.de.uu.net") by vger.kernel.org with ESMTP id <S131756AbRC1MJK>; Wed, 28 Mar 2001 07:09:10 -0500
Date: Wed, 28 Mar 2001 14:11:35 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: Larger dev_t
Message-ID: <20010328141135.B1716@tjansen.de>
References: <UTC200103270929.LAA29224.aeb@vlet.cwi.nl> <Pine.LNX.4.31.0103271028280.24734-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.31.0103271028280.24734-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Mar 27, 2001 at 10:48:13AM -0800
From: Tim Jansen <tim@tjansen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2001 at 10:48:13AM -0800, Linus Torvalds wrote:
> So in /dev, there are two problems: we are getting painfully close to
> major numbers with 8 bits, and we've run out of minors several times. In
> fact, a lot of the reason for the dearthness of major numbers is the fact
> that we use multiple majors for some stuff that really wants many minors.

Are the major/minor numbers neccessary at all? They were a kludge to
represent devices in the file system because there wasnt something like
DevFS in the dark ages of Unix. But if you take DevFS as given you can get
rid of all these problems that major/minor numbers cause, just register your
file_operation structure directly instead of your maj/min pair (plus, maybe, 
some private data that replaces any information that was encoded in the
minor number). 

While DevFS may not be very popular this could actually reduce the amount of
code in the kernel, which was one of the main arguments against DevFS AFAIK. 
And if you dont like the fact that DevFS assignes the file names you could
mount DevFS in a different directory and use symlinks from /dev to the
device tree (like Solaris does?). 


bye...

