Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277550AbRJKAEg>; Wed, 10 Oct 2001 20:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277549AbRJKAE0>; Wed, 10 Oct 2001 20:04:26 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:18582 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S277541AbRJKAEX>;
	Wed, 10 Oct 2001 20:04:23 -0400
Message-ID: <3BC50BDD.6AA9642E@us.ibm.com>
Date: Wed, 10 Oct 2001 17:02:53 -1000
From: Mingming cao <cmm@us.ibm.com>
Organization: Linux Technology Center
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>, Al Viro <viro@math.psu.edu>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]Fix bug:rmdir could remove current working directory
In-Reply-To: <Pine.GSO.4.21.0110101743140.21168-100000@weyl.math.psu.edu> <3BC4EFFC.42ACE59E@us.ibm.com> <200110102317.f9ANHjN03120@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> In article <3BC4EFFC.42ACE59E@us.ibm.com>,
> Mingming cao  <cmm@us.ibm.com> wrote:
> >
> >I thought about the case when rmdir() on the cwd of other processes,
> >but, as you said, that is implementation dependent. However rmdir() on
> >"." does returns EBUSY error.
> 
> That's a completely different thing, though - even though the difference
> is rather subtle.
> 
> You can remove pretty much any empty directory (if the filesystem
> permits it - some don't). HOWEVER, you can not use "." as the final
> component of your pathname.
> 
> It has nothing to do with home directory: you can try just doing
> 
>         mkdir /tmp/hello
>         rmdir /tmp/hello/.
> 
> and you'll get the same error (and it _should_ return EINVAL, not EBUSY.
> EBUSY is for the "this filesystem doesn't allow you to remove a
> directory that is in use" case).
> 
>                         Linus

I misunderstanded the rule.  Thanks for clarifying!

-- 
Mingming Cao
