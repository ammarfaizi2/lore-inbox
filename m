Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278574AbRJSSWN>; Fri, 19 Oct 2001 14:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278576AbRJSSWD>; Fri, 19 Oct 2001 14:22:03 -0400
Received: from zero.aec.at ([195.3.98.22]:7176 "HELO zero.aec.at")
	by vger.kernel.org with SMTP id <S278574AbRJSSVt>;
	Fri, 19 Oct 2001 14:21:49 -0400
To: Simon Kirby <sim@netnation.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Awfully slow /proc/net/tcp, netstat, in.identd in 2.4 (updated)
In-Reply-To: <20011018094222.A31919@netnation.com> <20011019145750.A22193@zero.firstfloor.org> <20011019085944.A16467@netnation.com>
From: Andi Kleen <ak@muc.de>
Date: 19 Oct 2001 20:22:21 +0200
In-Reply-To: Simon Kirby's message of "Fri, 19 Oct 2001 08:59:44 -0700"
Message-ID: <k23d4fwkv6.fsf@zero.aec.at>
User-Agent: Gnus/5.0700000000000003 (Pterodactyl Gnus v0.83) Emacs/20.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011019085944.A16467@netnation.com>,
Simon Kirby <sim@netnation.com> writes:

> TCP: Hash tables configured (established 262144 bind 65536)

No it means you have 512+k buckets  (*4 on UP; *8 on SMP for bytes = ~4MB) 
for the established hash and 64k for the bind hash (the later is only 
used internally and searched for netstat).

4MB for a hash table looks ridiculously large to me.

> ...but shrinking the size slightly won't really fix the problem, it will
> just make it less obvious.

the size is the problem. walking an 4MB table will be always slow.

-Andi
