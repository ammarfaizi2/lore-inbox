Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280882AbRKBXjz>; Fri, 2 Nov 2001 18:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280885AbRKBXjf>; Fri, 2 Nov 2001 18:39:35 -0500
Received: from femail20.sdc1.sfba.home.com ([24.0.95.129]:31197 "EHLO
	femail20.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S280882AbRKBXjd>; Fri, 2 Nov 2001 18:39:33 -0500
Message-ID: <3BE32E24.E89E83CD@didntduck.org>
Date: Fri, 02 Nov 2001 18:37:08 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ken Ashcraft <kash@Stanford.EDU>
CC: linux-kernel@vger.kernel.org
Subject: Re: null pointer questions
In-Reply-To: <Pine.GSO.4.33.0111021433590.6907-100000@saga18.Stanford.EDU>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ken Ashcraft wrote:
> 
> > > 2. What happens if I pass a null pointer as the destination parameter
> > > to copy_from_user?  Does copy_from_user handle it safely or will the
> > > kernel seg fault?
> >
> > The kernel won't crash, but it might fail (depending on whether 0 is a
> > valid user space address or not).
> 
> Why does it matter if 0 is a valid user space or not?  If I make the call
> 
> copy_from_user(0, user_ptr, 4);
> 
> the null pointer is the kernel address, not the user address.  Can you
> clarify please?

copy_from_user uses the string move instruction on the x86, so the
exception code would assume the source faulted not the dest.  It would
return -EFAULT instead of causing an oops.

-- 

						Brian Gerst
