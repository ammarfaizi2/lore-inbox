Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261174AbVAHO0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbVAHO0H (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 09:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbVAHO0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 09:26:07 -0500
Received: from smtp.andrew.cmu.edu ([128.2.10.82]:48600 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S261174AbVAHO0C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 09:26:02 -0500
Message-ID: <41DFEBFE.1030602@andrew.cmu.edu>
Date: Sat, 08 Jan 2005 09:19:42 -0500
From: James Bruce <bruce@andrew.cmu.edu>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jake Moilanen <moilanen@austin.ibm.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE 0/4][RFC] Genetic Algorithm Library
References: <20050106100844.53a762a0@localhost> <41DFE8B7.9070909@andrew.cmu.edu>
In-Reply-To: <41DFE8B7.9070909@andrew.cmu.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok I've read the patch and see you do indeed have crossover; Now I have 
a different question.  What is the motivation for generating two 
children at once, instead of just one?    Genes values shouldn't get 
"lost" since the parents are being kept around anyway.  Also, since the 
parameters in general will not have a meaningful ordering, it might make 
sense for the generic crossover to be the "each gene randomly picked 
from one of the two parents" approach.  In practice  I've found that to 
mix things up a bit better in the parameter optimization problems I've 
done with GAs.
   - Jim

James Bruce wrote:
> Do you have any crossover?  This is critical for GA to work well - 
> without it, the algorithm is really only a parallel random search.  More 
> specifically, is step 6 pure copies of a single parents, or can children 
> inherit tunables from multiple parents?
>  - Jim
> 
> Jake Moilanen wrote:
> 
>> ...
>> The basic flow of the genetic algorithm is as follows:
>>
>> 1.) Start w/ a broad list of initial tunable values (each set of
>>     tunables is called a child) 2.) Let each child run for a 
>> timeslice. 3.) Once the timeslice is up, calculate the fitness of the 
>> child (how
>> well performed).
>> 4.) Run the next child in the list.
>> 5.) Once all the children have run, compare the fitnesses of each child
>>     and throw away the bottom-half performers. 6.) Create new children 
>> to take the place of the bottom-half performers
>>     using the tunables from the top-half performers.
>> 7.) Mutate a set number of children to keep variance.
>> 8.) Goto step 2.
>>
>> Over time the tunables should converge toward the optimal settings for
>> that workload.  If the workload changes, the tunables should converge to
>> the new optimal settings (this is part of the reason for mutation). 
>> This algorithm is used extensively in AI.
> 
>  > ...
> 

