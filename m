Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750911AbWHJVxn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911AbWHJVxn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 17:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbWHJVxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 17:53:42 -0400
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:30143 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1750806AbWHJVxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 17:53:41 -0400
From: Grant Coady <gcoady.lk@gmail.com>
To: Willy Tarreau <w@1wt.eu>
Cc: Xin Zhao <uszhaoxin@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
Subject: Re: What's the NFS OOM problem?
Date: Fri, 11 Aug 2006 07:53:37 +1000
Organization: http://bugsplatter.mine.nu/
Reply-To: Grant Coady <gcoady.lk@gmail.com>
Message-ID: <tcand21vjh38gbrkegin7079n3lrdiaggp@4ax.com>
References: <4ae3c140608081524u4666fb7x741734908c35cfe6@mail.gmail.com> <20060810045711.GI8776@1wt.eu>
In-Reply-To: <20060810045711.GI8776@1wt.eu>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2006 06:57:11 +0200, Willy Tarreau <w@1wt.eu> wrote:

>On Tue, Aug 08, 2006 at 06:24:47PM -0400, Xin Zhao wrote:
>> I often heard of the OOM probelm in NFS, but don't know what it is.
>> Now I am developing a NFS based system and found my system memory
>> (server side) is used too fast. I checked the code but didn't find
>> memory leaking. So I suspect I run into OOM issue.
>
>I simply think that you're cache is filling while your clients access
>a lot of files. That's expected. You might also get quite a bunch of
>dentries cached which will not be accounted for in meminfo. Check
>/proc/meminfo for the cache+buffer size, and check /proc/slabinfo for
>the number of dentries. The usual way to ensure this is only cache is
>to allocate a large amount of memory (let's say all the system RAM
>provided that everything can get swapped), then free it. You'll see
>a lot of free memory after that.
>
>> Can someone help me and give me a brief description on OOM issue?
>
>I don't know about any OOM issue related to NFS. At most it might happen
>on the client (eg: stating firefox from an NFS root) which might not have
>enough memory for new network buffers, but I don't even know if it's
>possible at all.

I once wrote a silly test script that put way too much work into ksoftirqd 
and the system slowed right down, it was some time ago, I forget details.

You could see the problem by monitoring `top` on both client and server, 
watching the thing choking.  I didn't document it, seemed like a "don't 
do that" situation at the time.

Grant.
