Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751209AbWANQNy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbWANQNy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 11:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbWANQNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 11:13:54 -0500
Received: from uproxy.gmail.com ([66.249.92.205]:43860 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751060AbWANQNx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 11:13:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=WY9oxQW7CF0gwOTKgPj11eT3x5HjpLIoVGzA+ZJet5WB+/GKrW2xwDFqV1mwxqmUBUypOZj1bNkBW/XXcxjLHj9QKchbg5h91k+vP3/uloarueKLGhVYNVLtdh2lganl9RxLpkieOGhCTDY4btnrDhyAmX+Peiew5DSQfR/sfuM=
Message-ID: <43C9233A.20504@gmail.com>
Date: Sat, 14 Jan 2006 18:13:46 +0200
From: Matan Peled <chaosite@gmail.com>
Reply-To: chaosite@gmail.com
Organization: Chaosite Destruction, inc.
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20051014 Thunderbird/1.0.7 Mnenhy/0.7.2.0
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: David Singleton <daviado@gmail.com>, mingo@elte.hu,
       linux-kernel@vger.kernel.org, drepper@gmail.com,
       robustmutexes@lists.osdl.org
Subject: Re: Robust futex patch for Linux 2.6.15
References: <b324b5ad0601131316m721f959eu37b741f9e5557a2e@mail.gmail.com> <20060113132704.207336d7.akpm@osdl.org>
In-Reply-To: <20060113132704.207336d7.akpm@osdl.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Please send the patch to this mailing list with a full description, as per
> http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt.  And by "full" I
> mean something which tells us what a "robust futex" actually is (it's been
> a year since I thought about them) and why we would want such a thing.
> 
> This code looks racy:
> 
> +static int futex_deadlock(struct rt_mutex *lock)
> +{
> +	DEFINE_WAIT(wait);
> +
> +	_raw_spin_unlock(&lock->wait_lock);
> +	_raw_spin_unlock(&current->pi_lock);
> +
> +	prepare_to_wait(&deadlocked_futex, &wait, TASK_INTERRUPTIBLE);
> +	schedule();
> +	finish_wait(&deadlocked_futex, &wait);
> +
> +	return -EDEADLK;
> +}
> 
> If the spin_unlocks happened after the prepare_to_wait then it would be
> more idoimatic, but without having analysed the wakeup path, I wonder if a
> wakeup which occurs after the spin_unlocks and before the prepare_to_wait()
> will get lost.

Andrew, I'm looking at this:

http://source.mvista.com/~dsingleton/robust-futex-1

And it doesn't seem to have a futex_deadlock function at all. In fact, its seems 
to have a rather lengthy description about robust futexes and why they're a Good 
Thing(TM).

What are you looking at?

-- 
[Name      ]   ::  [Matan I. Peled    ]
[Location  ]   ::  [Israel            ]
[Public Key]   ::  [0xD6F42CA5        ]
[Keyserver ]   ::  [keyserver.kjsl.com]
encrypted/signed  plain text  preferred

