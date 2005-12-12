Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751088AbVLLEsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbVLLEsR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 23:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbVLLEsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 23:48:17 -0500
Received: from smtp103.mail.sc5.yahoo.com ([66.163.169.222]:32384 "HELO
	smtp103.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751088AbVLLEsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 23:48:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=0/bB2RHqDevUDWkzyEvKhIZDJGLeMxFxoQXpgILTxy6BOIS1eKVbq4mPCC1vjY3+b3mqRcBhViHfO3vs9hY82B5XEvJUMV3zhpGaLlOdw7otdPJTboiXOj5fEiijF8O7T6LdWB1Fi2p2AJqxjEIoXRWPaOQm8kh5aMo3nDrN8F0=  ;
Message-ID: <439D00FB.9000909@yahoo.com.au>
Date: Mon, 12 Dec 2005 15:47:55 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: akpm@osdl.org, paulmck@us.ibm.com, oleg@tv-sign.ru, vatsa@in.ibm.com,
       linux-kernel@vger.kernel.org, dipankar@in.ibm.com
Subject: Re: [PATCH] Fix RCU race in access of nohz_cpu_mask
References: <439B24A7.E2508AAE@tv-sign.ru>	<20051212031053.GA8748@us.ibm.com>	<20051211203226.4deafd59.akpm@osdl.org> <20051211.203809.127057416.davem@davemloft.net>
In-Reply-To: <20051211.203809.127057416.davem@davemloft.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> From: Andrew Morton <akpm@osdl.org>
> Date: Sun, 11 Dec 2005 20:32:26 -0800
> 
> 
>>So foo_mb() in preemptible code is potentially buggy.
>>
>>I guess we assume that a context switch accidentally did enough of the
>>right types of barriers for things to work OK.
> 
> 
> A trap ought to flush all memory operations.
> 
> There are some incredibly difficult memory error handling cases if the
> cpu does not synchronize all pending memory operations when a trap
> occurs.
> 
> Failing that, yes, to be absolutely safe we'd need to have some
> explicit memory barrier in the context switch.

But it isn't that mbs in preemptible code are buggy. If they are
scheduled off then back on the same CPU, the barrier will still
be executed in the expected instruction sequence for that process.

I think the minimum needed is for cpu *migrations* to be memory
barriers. Again, this isn't any particular problem of mb()
instructions - if cpu migrations weren't memory barriers, then
preemptible code isn't even guaranteed ordering with its own memory
operations, which would be quite interesting :)

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
