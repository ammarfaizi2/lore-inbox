Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266721AbUIMUyg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266721AbUIMUyg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 16:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267703AbUIMUyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 16:54:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:3305 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266721AbUIMUyd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 16:54:33 -0400
Message-ID: <41460906.9080307@redhat.com>
Date: Mon, 13 Sep 2004 16:54:30 -0400
From: Neil Horman <nhorman@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0; hi, Mom) Gecko/20020604 Netscape/7.01
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Felipe W Damasio <felipewd@terra.com.br>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] close race condition in shared memory mapping/unmapping
References: <4146041F.2040106@redhat.com> <414607C7.4000801@terra.com.br>
In-Reply-To: <414607C7.4000801@terra.com.br>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe W Damasio wrote:
>     Hi Neil,
> 
> Neil Horman wrote:
> 
>> +    down(&shm_ids.sem);
>>      shp = shm_lock(shmid);
>>      if(shp == NULL) {
>> +        shm_unlock(shp);
>> +        up(&shm_ids.sem);
>>          err = -EINVAL;
>>          goto out;
>>      }
> 
> 
>     Trying to unlock a NULL pointer?
> 
>     Cheers,
> 
> Felipe
Crap, good catch.  I'll repost with that fixed.  Anything else you see a 
problem with?
Regards
Neil

-- 
/***************************************************
  *Neil Horman
  *Software Engineer
  *Red Hat, Inc.
  *nhorman@redhat.com
  *gpg keyid: 1024D / 0x92A74FA1
  *http://pgp.mit.edu
  ***************************************************/
