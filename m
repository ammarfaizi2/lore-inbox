Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277847AbRJLT4D>; Fri, 12 Oct 2001 15:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277849AbRJLTzo>; Fri, 12 Oct 2001 15:55:44 -0400
Received: from zero.aec.at ([195.3.98.22]:29456 "HELO zero.aec.at")
	by vger.kernel.org with SMTP id <S277847AbRJLTzc>;
	Fri, 12 Oct 2001 15:55:32 -0400
To: Simon Kirby <sim@netnation.com>
cc: linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru
Subject: Re: Really slow netstat and /proc/net/tcp in 2.4
In-Reply-To: <20011011114736.A13722@netnation.com> <200110111930.XAA28404@ms2.inr.ac.ru> <20011011125538.C10868@netnation.com>
From: Andi Kleen <andi@firstfloor.org>
Date: 12 Oct 2001 21:56:01 +0200
In-Reply-To: Simon Kirby's message of "Thu, 11 Oct 2001 12:55:38 -0700"
Message-ID: <k2sncok4z2.fsf@zero.aec.at>
User-Agent: Gnus/5.0700000000000003 (Pterodactyl Gnus v0.83) Emacs/20.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011011125538.C10868@netnation.com>,
Simon Kirby <sim@netnation.com> writes:
> On Thu, Oct 11, 2001 at 11:30:25PM +0400, kuznet@ms2.inr.ac.ru wrote:
>> Hello!
>> 
>> > Is there something that changed from 2.2 -> 2.4 with regards to the
>> > speed of netstat and /proc/net/tcp?
>> 
>> Incredibly high size of hash table, I think.
>> At least here size is ~1MB. And all this is read each 1K of data read
>> via /proc/ :-)

> So it's walking the hash table per block read, and the hash table is very
> large?  Hmm.  I notice it's a bit faster if I use dd if=/proc/net/tcp
> of=/dev/null bs=1024k, but not much.

> Is it possible to fix this?  Was the 2.2 hash table just that much
> smaller?

The hash table is likely to big anyways; eating cache and not helping that
much. If you're interested in some testing
I can send you patches to change it by hand and collect statistics for
average hash queue length. Then you can figure out a good size for your
workload with some work. Longer time I think the table sizing heuristics
are far too aggressive and need to be throttled back; but that needs more
data from real servers.

-Andi

