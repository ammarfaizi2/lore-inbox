Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278321AbRJMQHh>; Sat, 13 Oct 2001 12:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278342AbRJMQH1>; Sat, 13 Oct 2001 12:07:27 -0400
Received: from zero.aec.at ([195.3.98.22]:30226 "HELO zero.aec.at")
	by vger.kernel.org with SMTP id <S278321AbRJMQHN>;
	Sat, 13 Oct 2001 12:07:13 -0400
To: Hugh Dickins <hugh@veritas.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Really slow netstat and /proc/net/tcp in 2.4
In-Reply-To: <Pine.LNX.4.21.0110131537470.931-100000@localhost.localdomain>
From: Andi Kleen <ak@muc.de>
Date: 13 Oct 2001 18:07:43 +0200
In-Reply-To: Hugh Dickins's message of "Sat, 13 Oct 2001 16:07:12 +0100 (BST)"
Message-ID: <k2adyvjzg0.fsf@zero.aec.at>
User-Agent: Gnus/5.0700000000000003 (Pterodactyl Gnus v0.83) Emacs/20.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.21.0110131537470.931-100000@localhost.localdomain>,
Hugh Dickins <hugh@veritas.com> writes:
> On Sat, 13 Oct 2001, Andi Kleen wrote:
>> 
>> I attached a patch. It allows you to get some simple statistics from
>> /proc/net/sockstat (unfortunately costly too). It also adds a new kernel
>> boot argument tcpehashgoal=order. Order is the log2 of how many pages you
>> want to use for the hash table (so it needs 2^order * 4096 bytes on i386) 
>> You can experiment with various sizes and check which one gives still 
>> reasonable hash distribution under load.

> Wouldn't something like "tcpehashbuckets" make a better boot tunable
> than "tcpehashorder"?  Rounded up to next power of two before used.
[...]

I just hacked something quickly together so that people can test what
impact different hash tables sizes have on their workload, and for
that using the order was easiest. The goal is of course to do
automatic hash table tuning. I don't expect it to be an permanent
tunable. My hope is that it'll turn out that smaller hash tables will
be good enough.

-Andi
