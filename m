Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313416AbSE2O7H>; Wed, 29 May 2002 10:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313505AbSE2O7G>; Wed, 29 May 2002 10:59:06 -0400
Received: from [195.63.194.11] ([195.63.194.11]:9990 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S313416AbSE2O7F>;
	Wed, 29 May 2002 10:59:05 -0400
Message-ID: <3CF4DDD0.8090806@evision-ventures.com>
Date: Wed, 29 May 2002 15:55:28 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Jan Kara <jack@suse.cz>
CC: torvalds@transmeta.com, Nathan Scott <nathans@wobbly.melbourne.sgi.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2/3 Quota changes ported to 2.5.18
In-Reply-To: <20020529144510.GB9503@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kara wrote:
>   This second patch changes sysctl interface to use reasonable names in
> /proc/sys/fs/quota/
> 
> 								Honza
> 

Please note that the _dquots suffix for the alocated and
free entires of struct dqstats is:

1. Entierly redundant. (dqstats.allocated counts dquots what else?)

2. Orthogonal to the leak of it for the other fields.

  static inline void put_inuse(struct dquot *dquot)
@@ -238,12 +238,12 @@
  	/* We add to the back of inuse list so we don't have to restart
  	 * when traversing this list and we block */
  	list_add(&dquot->dq_inuse, inuse_list.prev);
- 
++dqstats_array[DQSTATS_ALLOCATED];
+ 
dqstats.allocated_dquots++;
  }


