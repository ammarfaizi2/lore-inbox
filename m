Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbTEHNla (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 09:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261446AbTEHNla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 09:41:30 -0400
Received: from dyn-ctb-203-221-72-237.webone.com.au ([203.221.72.237]:24836
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S261500AbTEHNl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 09:41:29 -0400
Message-ID: <3EBA615E.9040003@cyberone.com.au>
Date: Thu, 08 May 2003 23:53:34 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Szonyi Calin <sony@etc.utt.ro>
CC: linux-kernel@vger.kernel.org
Subject: Re: Q: Anticipatory scheduler docs
References: <52559.194.138.39.56.1052389206.squirrel@webmail.etc.utt.ro>
In-Reply-To: <52559.194.138.39.56.1052389206.squirrel@webmail.etc.utt.ro>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Szonyi Calin wrote:

>Hello everyone
>
>Where can I find documentation about the anticipatory scheduler
>and about tuning it ?
>
Ahh heh... when I write them :P
Seriously, its been under quite a bit of work, I've tried to
keep some docs up to date but its not worth it at the moment.
Its getting more stable now, but I have some auto tuning
stuff on the cards which changes things again...

Anyway in brief there are 5 parameters under /sys/block/*/iosched/
all are set in milliseconds.
* read_expire
Controls how long until a request becomes "expired". It also controls
the interval between which expired requests are served, so set to 50,
a request might take anywhere < 100ms to be serviced _if_ it is the
next on the expired list. Obviously it can't make the disk go faster.
Result is basically the timeslice a reader gets in the presence of
other IO. 100*((seek time / read_expire) + 1) is very roughly the
% streaming read efficiency your disk should get in the presence of
multiple readers.
* read_batch_expire
Controls how much time a batch of reads is given before pending writes
are served. Higher value is more efficient. Shouldn't really be below
read_expire.
* write_ versions of the above
* antic_expire
Controls the maximum amount of time we can anticipate a good read
before giving up. Many other factors may cause anticipation to be
stopped early, or some processes will not be "anticipated" at all.
Should be a bit higher for big seek time devices though not a
linear correspondance - most processes have only a few ms thinktime.

Hows that? Let me know of any benchmark results you might happen upon.

