Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751298AbWCTSv4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbWCTSv4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 13:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbWCTSv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 13:51:56 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:59033 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id S1751281AbWCTSvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 13:51:55 -0500
Date: Mon, 20 Mar 2006 10:44:00 -0800 (PST)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Pekka Enberg <penberg@cs.helsinki.fi>
cc: Benjamin LaHaise <bcrl@kvack.org>,
       Oliver Neukum <neukum@fachschaft.cup.uni-muenchen.de>,
       linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>
Subject: Re: [PATCH]micro optimization of kcalloc
In-Reply-To: <84144f020603200815o66cb689cv239cbe190f9e6f30@mail.gmail.com>
Message-ID: <Pine.LNX.4.62.0603201043060.17740@qynat.qvtvafvgr.pbz>
References: <Pine.LNX.4.58.0603201542250.17461@fachschaft.cup.uni-muenchen.d
 e> <20060320151433.GE16108@kvack.org> <84144f020603200815o66cb689cv239cbe190f9e6f30@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Mar 2006, Pekka Enberg wrote:

> Hi,
>
> On Mon, Mar 20, 2006 at 03:45:23PM +0100, Oliver Neukum wrote:
>>>  static inline void *kcalloc(size_t n, size_t size, gfp_t flags)
>>>  {
>>> -     if (n != 0 && size > INT_MAX / n)
>>> +     if (unlikely(size != 0 && n > INT_MAX / size ))
>>>               return NULL;
>>>       return kzalloc(n * size, flags);
>>>  }
>
> On 3/20/06, Benjamin LaHaise <bcrl@kvack.org> wrote:
>> This function shouldn't be inlined.  We have no need to optimize the
>> unlikely case like this.
>
> IIRC, I made it static inline in the first place because that actually
> reduced kernel text size. (And I think it was Adrian who made me do it
> :-).

I wonder if this is still needed with the new inline changes that were 
made to allow GCC to make the decision (for recent GCC's)

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare

