Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261303AbTCYAdn>; Mon, 24 Mar 2003 19:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261304AbTCYAdn>; Mon, 24 Mar 2003 19:33:43 -0500
Received: from rth.ninka.net ([216.101.162.244]:54446 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S261303AbTCYAdm>;
	Mon, 24 Mar 2003 19:33:42 -0500
Subject: Re: [CHECKER] potential dereference of user pointer errors
From: "David S. Miller" <davem@redhat.com>
To: Raja R Harinath <harinath@cs.umn.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <d9llz4v1qh.fsf@bose.cs.umn.edu>
References: <200303041112.h24BCRW22235@csl.stanford.edu>
	 <Pine.GSO.4.44.0303202226230.24869-100000@elaine24.Stanford.EDU>
	 <d9llz4v1qh.fsf@bose.cs.umn.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048553088.7097.2.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 24 Mar 2003 16:44:48 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-03-24 at 14:28, Raja R Harinath wrote:
> Something like
> 
>   /* struct user_space should never be defined.  */
>   typedef struct user_space user_space;
> 
>   int copy_to_user (user_space *to, char *from, size_t len);
>   int copy_from_user (char *to, user_space *from, size_t len);
>   /* ... */
> 
>   #define TREAT_AS_USER_SPACE_POINTER(p) \
>             ({                                  \
>               BUG_ON(get_fs() != get_gs());     \
>               (user_space *)p;                  \
>             })

A great idea, we'd need to use this struct user_space at every
system call, and it doesn't work to well when pointers are
embedded inside of a structure.

This is why a GCC attribute of some sort would be more useful.
But I don't see the GCC folks offering a user-definable attribute
+ checking system any time soon.

-- 
David S. Miller <davem@redhat.com>
