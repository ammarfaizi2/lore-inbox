Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263267AbTCYSoP>; Tue, 25 Mar 2003 13:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263270AbTCYSoP>; Tue, 25 Mar 2003 13:44:15 -0500
Received: from main.gmane.org ([80.91.224.249]:19371 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S263267AbTCYSoO>;
	Tue, 25 Mar 2003 13:44:14 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Raja R Harinath <harinath@cs.umn.edu>
Subject: Re: [CHECKER] potential dereference of user pointer errors
Date: Tue, 25 Mar 2003 12:52:14 -0600
Organization: Dept. of Computer Science, Univ. of Minnesota
Message-ID: <d9u1drqnxd.fsf@bose.cs.umn.edu>
References: <200303041112.h24BCRW22235@csl.stanford.edu> <Pine.GSO.4.44.0303202226230.24869-100000@elaine24.Stanford.EDU>
 <d9llz4v1qh.fsf@bose.cs.umn.edu> <1048553088.7097.2.camel@rth.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@main.gmane.org
User-Agent: Gnus/5.090017 (Oort Gnus v0.17) Emacs/21.3.50 (gnu/linux)
Cancel-Lock: sha1:hvE4/ugb5SUBGwwmkb+Z1KQANRo=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

"David S. Miller" <davem@redhat.com> writes:

> On Mon, 2003-03-24 at 14:28, Raja R Harinath wrote:
>> Something like
>> 
>>   /* struct user_space should never be defined.  */
>>   typedef struct user_space user_space;
>> 
>>   int copy_to_user (user_space *to, char *from, size_t len);
>>   int copy_from_user (char *to, user_space *from, size_t len);
>>   /* ... */
>> 
>>   #define TREAT_AS_USER_SPACE_POINTER(p) \
>>             ({                                  \
>>               BUG_ON(get_fs() != get_gs());     \
>>               (user_space *)p;                  \
>>             })
>
> A great idea, we'd need to use this struct user_space at every
> system call, 

Which is good, I think.  It annotates the source.

> and it doesn't work to well when pointers are embedded inside of a
> structure.

I don't understand this point.  'struct user_space' will never be
defined.  The C compiler ensure that 'struct user_space *p' cannot be
dereferenced then, since it will be a pointer to an incomplete type.

I don't see any difference between

  struct foo { char *p; };

and 

  struct foo { user_space *p; };

in terms of the code generated.  (On second reading, I don't think
this was your point though).

- Hari
-- 
Raja R Harinath ------------------------------ harinath@cs.umn.edu

