Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271275AbRHTOks>; Mon, 20 Aug 2001 10:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271265AbRHTOka>; Mon, 20 Aug 2001 10:40:30 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:48613 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S271261AbRHTOk1>;
	Mon, 20 Aug 2001 10:40:27 -0400
Date: Mon, 20 Aug 2001 15:40:34 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Oliver Xymoron <oxymoron@waste.org>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: Theodore Tso <tytso@mit.edu>, David Schwartz <davids@webmaster.com>,
        Andreas Dilger <adilger@turbolinux.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: /dev/random in 2.4.6
Message-ID: <2251207905.998322034@[10.132.112.53]>
In-Reply-To: <Pine.LNX.4.30.0108200903580.4612-100000@waste.org>
In-Reply-To: <Pine.LNX.4.30.0108200903580.4612-100000@waste.org>
X-Mailer: Mulberry/2.1.0b3 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Am I correct in assuming that in the absence of other entropy sources, it
>> would use these (potentially inferior) sources, and /dev/random would
>> then not block? In which case fine, it solves my problem.
>
> No, /dev/random would always keep a conservative estimate of entropy.
> Assuming that network entropy > 0, this would add more real (but
> unaccounted) entropy to the pool, and if you agree with this assumption,
> you would be able to take advantage of it by reading /dev/urandom.

OK; well in which case it doesn't solve the problem. I assert there are
configurations where using the network to generate accounted for entropy
is no worse than the other available options. In that case, if my entropy
pool is low, I want to wait long enough for it to fill up (i.e. have the
/dev/random blocking behaviour) before reading my random number. If your
interpretation of Ted's suggestion is correct, this is no better than
switching to /dev/urandom, which is considerably worse than the effect
of using Robert's patch. I thought what Ted was suggesting was only
accounting for network-IRQ derived entropy when the entropy pool was
mostly empty. This would mean that if there were other sources of entropy
about, the network entropy would not be accounted for (which sounds
reasonable, on the presumption that they were better quality).

An alternative approach to all of this, perhaps, would be to use extremely
finely grained timers (if they exist), in which case more bits of entropy
could perhaps be derived per sample, and perhaps sample them on
more operations. I don't know what the finest resolution timer we have
is, but I'd have thought people would be happier using ANY existing
mechanism (including network IRQs) if the timer resolution was (say)
1 nanosecond.

--
Alex Bligh
