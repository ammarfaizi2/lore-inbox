Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133007AbRDREjl>; Wed, 18 Apr 2001 00:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133008AbRDREjb>; Wed, 18 Apr 2001 00:39:31 -0400
Received: from csl.Stanford.EDU ([171.64.66.149]:32646 "EHLO csl.Stanford.EDU")
	by vger.kernel.org with ESMTP id <S133007AbRDREjR>;
	Wed, 18 Apr 2001 00:39:17 -0400
From: Dawson Engler <engler@csl.Stanford.EDU>
Message-Id: <200104180439.VAA21983@csl.Stanford.EDU>
Subject: [CHECKER] copy_*_user length bugs?
To: linux-kernel@vger.kernel.org
Date: Tue, 17 Apr 2001 21:39:15 -0700 (PDT)
Cc: engler@csl.Stanford.EDU (Dawson Engler)
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

at the suggestion of Chris (chris@ferret.lmh.ox.ac.uk) I wrote a simple
checker to warn when the length parameter to copy_*_user was (1) an
integer and (2) not checked < 0.    

As an example, the ipv6 routine rawv6_geticmpfilter gets an integer 'len'
from user space, checks that it is smaller than a struct size and then
uses length as an argument to copy_to_user: 

                if (get_user(len, optlen))
                        return -EFAULT;
                if (len > sizeof(struct icmp6_filter))
                        len = sizeof(struct icmp6_filter);
                if (put_user(len, optlen))
                        return -EFAULT;
                if (copy_to_user(optval, &sk->tp_pinfo.tp_raw.filter, len))
                        return -EFAULT;

Is this a real bug?  Or is the checked rule only applicable to
__copy_*_user routines rather than copy_*_user routines?  (If its a real
bug, theres about 8 others that we found).

Thanks,
Dawson
