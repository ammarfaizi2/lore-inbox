Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265523AbSKOBRY>; Thu, 14 Nov 2002 20:17:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265532AbSKOBRY>; Thu, 14 Nov 2002 20:17:24 -0500
Received: from pheriche.sun.com ([192.18.98.34]:52873 "EHLO pheriche.sun.com")
	by vger.kernel.org with ESMTP id <S265523AbSKOBRX>;
	Thu, 14 Nov 2002 20:17:23 -0500
Message-ID: <3DD44CC0.40805@sun.com>
Date: Thu, 14 Nov 2002 17:24:16 -0800
From: Tim Hockin <thockin@sun.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH 1/2] Remove NGROUPS hardlimit (resend w/o qsort)
References: <mailman.1037316781.6599.linux-kernel2news@redhat.com> <200211150006.gAF06JF01621@devserv.devel.redhat.com> <3DD43C65.80103@sun.com> <20021114193156.A2801@devserv.devel.redhat.com> <3DD443EC.2080504@sun.com> <3DD44742.2DFE4407@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> What are you actually using the search for?
> 
>>From a quick look, it seems that it's purely to answer
> the question "is this process a member of group X?".  Is
> that correct?
> 
> If so, test_bit() would work nicely.

This could work if we find the max gid, allocate an array of 
max_gid/CHAR_BITS + 1 bytes then test_bit, but given the non-contiguity 
(is that a word) of group memberships, we'll waste a lot of space on 
holes. Now, it could be argued that 10,000 groups are PROBABLY local 
enough.  Getting the groups back out will be nasty nastiness, though.

perhaps:

if (gidsetsize < (2 * EXEC_PAGESIZE)/sizeof(gid_t)) { /* or something */
	/* use kmalloc() */
else
	/* use vmalloc() */

thoughts?

-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Linux Kernel Engineering
thockin@sun.com

