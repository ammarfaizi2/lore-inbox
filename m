Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965114AbVITUPz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965114AbVITUPz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 16:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965115AbVITUPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 16:15:55 -0400
Received: from [81.2.110.250] ([81.2.110.250]:16315 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S965114AbVITUPz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 16:15:55 -0400
Subject: Re: p = kmalloc(sizeof(*p), )
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: rmk+lkml@arm.linux.org.uk, penberg@cs.Helsinki.FI, viro@ftp.linux.org.uk,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
In-Reply-To: <20050920105939.3c9c5e39.akpm@osdl.org>
References: <20050918100627.GA16007@flint.arm.linux.org.uk>
	 <84144f0205092004187f86840c@mail.gmail.com>
	 <20050920114003.GA31025@flint.arm.linux.org.uk>
	 <Pine.LNX.4.58.0509201501440.9304@sbz-30.cs.Helsinki.FI>
	 <20050920123149.GA29112@flint.arm.linux.org.uk>
	 <20050920101128.70fec697.akpm@osdl.org>
	 <1127239361.7763.3.camel@localhost.localdomain>
	 <20050920105939.3c9c5e39.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 20 Sep 2005 21:41:36 +0100
Message-Id: <1127248896.7763.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-09-20 at 10:59 -0700, Andrew Morton wrote:
> umm, the three reasons which you deleted from the mail to which you're
> replying?

There were no reasons given in the mail I replied to. Perhaps I missed
another mail from you earlier.

I'm also puzzled by the one comemnt you made. You seem to imply that
seeing

foo = malloc(sizeof(*foo))

means it doesn't need checking. That is false on various grounds

1.	A lot of stuff is using void *, char * etc
2.	You've no idea that foo is the full object not a generic object with
stuff tacked on.

So thats very much false. You have to know what is really being
allocated in both cases. In the sizeof(*foo) case you also have to go
back, work out wtf foo really is and check that its not an array pointer
because sizeof char[40] is not the same as sizeof(* char *).

Thankfully Linus hates typedefs so that removes many of those

