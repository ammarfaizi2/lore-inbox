Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262058AbRGDKRg>; Wed, 4 Jul 2001 06:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261561AbRGDKR0>; Wed, 4 Jul 2001 06:17:26 -0400
Received: from metastasis.f00f.org ([203.167.249.89]:46977 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S261425AbRGDKRT>;
	Wed, 4 Jul 2001 06:17:19 -0400
Date: Wed, 4 Jul 2001 22:16:58 +1200
To: Ben LaHaise <bcrl@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] first cut 64 bit block support
Message-ID: <20010704221658.D18972@weta.f00f.org>
In-Reply-To: <Pine.LNX.4.33.0107010040540.3950-100000@toomuch.toronto.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0107010040540.3950-100000@toomuch.toronto.redhat.com>
User-Agent: Mutt/1.3.18i
From: cw@f00f.org (Chris Wedgwood)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 01, 2001 at 12:53:25AM -0400, Ben LaHaise wrote:

> Ugly bits: I had to add libgcc.a to satisfy the need for 64 bit
> division.  Yeah, it sucks, but RAID needs some more massaging before
> I can remove the 64 bit division completely.  This will be fixed.

I would rather see this code removed from libgcc and put into a
function (optionally inline) such that code like:

__u64 foo(__u64 a, __u64 b)
{
        __u64 t;


        t = a * SOME_CONST + b;

        return t / BLEM;
}

would really look like:

__64 foo(__u64 a, __u64 b)
{
        __u64 t;

        t = 64b_mul(a, SOME_CONST) + b;

        return 64b_udiv(t, BLEM);
}


such that for peopel to use 64-bit operations on the kernel, they have
to explicity code them in, not just accidentialyl change a variable
type and have gcc/libgcc hide this fact from them.

Note, I use __u64 not "long long" as I'm not 100% "long long" will
mean 64-bits on all future architectures (it would be cool, for
example, if it was 128-bit on some!).


What do you think? Would you accept patches for either of these?




  --cw
