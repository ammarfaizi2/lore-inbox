Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263015AbTLJB12 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 20:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263107AbTLJB12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 20:27:28 -0500
Received: from CPE-65-30-34-80.kc.rr.com ([65.30.34.80]:43142 "EHLO
	cognition.home.hanaden.com") by vger.kernel.org with ESMTP
	id S263015AbTLJB10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 20:27:26 -0500
Message-ID: <3FD67678.5050704@hanaden.com>
Date: Tue, 09 Dec 2003 19:27:20 -0600
From: hanasaki <hanasaki@hanaden.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031204 Thunderbird/0.4RC1
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: [BUG 2.4] NFS unlocking operation accesses invalid file struct
References: <200311252000.32094.mita@miraclelinux.com> <200311272054.22316.mita@miraclelinux.com> <16326.9448.320003.775274@charged.uio.no> <200312101006.46157.mita@miraclelinux.com>
In-Reply-To: <200312101006.46157.mita@miraclelinux.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

could this be related to the problem I had?

debian sarge nfs client on 2.4.23
debian sarge nfs server on 2.6test11 - rpc number erros and bad locks

Akinobu Mita wrote:
> Hello Trond,
> 
> I apologize for the delay in responding.
> 
> On Friday 28 November 2003 01:23, Trond Myklebust wrote:
> 
>>So then the correct thing to do is indeed to wrap the call to
>>locks_unlock_delete() with an fget()/fput() pair, and then to remove
>>the test for fl_pid in locks_same_owner().
>>
>>We then need to fix lockd so that it generates correct fl_owners for
>>its locks...
>>
>>Let me see if I can get that right.
>>
> 
> 
> I looked at your patch carefully
> (http://www.fys.uio.no/~trondmy/src/Linux-2.4.x/2.4.23-rc1/linux-2.4.23-01-posix_race.dif)
> and I think it would fix the problem completely.
> 
> Thanks,
> 
> --
> Akinobu Mita
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
