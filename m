Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262942AbUKRTqs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262942AbUKRTqs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 14:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262938AbUKRTob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 14:44:31 -0500
Received: from fw.osdl.org ([65.172.181.6]:38528 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262935AbUKRTnx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 14:43:53 -0500
Date: Thu, 18 Nov 2004 11:43:41 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Miklos Szeredi <miklos@szeredi.hu>
cc: hbryan@us.ibm.com, akpm@osdl.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, pavel@ucw.cz
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
In-Reply-To: <E1CUs2R-0004Nr-00@dorka.pomaz.szeredi.hu>
Message-ID: <Pine.LNX.4.58.0411181140110.2222@ppc970.osdl.org>
References: <OF28252066.81A6726A-ON88256F50.005D917A-88256F50.005EA7D9@us.ibm.com>
 <E1CUq57-00043P-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.58.0411180959450.2222@ppc970.osdl.org>
 <E1CUquZ-0004Az-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.58.0411181027070.2222@ppc970.osdl.org>
 <E1CUrS0-0004Hi-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.58.0411181108140.2222@ppc970.osdl.org>
 <E1CUs2R-0004Nr-00@dorka.pomaz.szeredi.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 18 Nov 2004, Miklos Szeredi wrote:
> 
> OK, sorry.  I'd rephrase it then to say will the system allow _all_
> it's pages to be used for file data?

Yup, pretty much.

It's actually even _normal_ behaviour for many of the core users of shared 
files. People who really do databases get quite upset if you don't let 
them mmap as much memory as they want, because for them, they really tune 
their cache sizes for the size of memory, and they think the OS (and 
anything else, for that matter) just gets in their way. They want 99% of 
memory to be used for the shared mapping, and the remaining 1% for their 
code.

(That's a bit extreme, but you get the idea).

Historically, we've often tried to "partition" memory in various ways (ie 
"the buffer cache can only grow up to 40% of real memory" etc). It ends up 
being good for some things (watermarks etc), but almost ever time it ends 
up being bad as a hard _limit_. So yes, the kernel tends to let people 
do what they think they want to do.

"Give them rope",

			Linus
