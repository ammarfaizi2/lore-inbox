Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270779AbRHSU6c>; Sun, 19 Aug 2001 16:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270783AbRHSU6W>; Sun, 19 Aug 2001 16:58:22 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:42211 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S270779AbRHSU6G>;
	Sun, 19 Aug 2001 16:58:06 -0400
Date: Sun, 19 Aug 2001 21:58:17 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Oliver Xymoron <oxymoron@waste.org>, Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: [PATCH] let Net Devices feed Entropy, updated (1/2)
Message-ID: <477033435.998258297@[169.254.45.213]>
In-Reply-To: <Pine.LNX.4.30.0108181839130.31188-100000@waste.org>
In-Reply-To: <Pine.LNX.4.30.0108181839130.31188-100000@waste.org>
X-Mailer: Mulberry/2.1.0b3 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> obviously some people fear NICs feeding entropy provides a hazard.  for
>> those who dont, or are increadibly low on entropy, enable the
>> configuration option.
>
> Why don't those who aren't worried about whether they _really_ have enough
> entropy simply use /dev/urandom?

This is not the issue; some of use _are_ worried whether or not we
have enough entropy (and want a read that blocks until sufficient
additional entropy arrives if entropy is insufficient), but don't have
sources of enough sources of entropy (e.g. on an idling machine where
everything is cached) if one does not allow network IRQ's to
generate entropy. In doing the latter, we do (admittedly) make
the assumption that they are valid sources of entropy (see discussion
past as to why this might or might not be the case), but using /dev/urandom
rather /dev/random will ALWAYS give a less random result in low entropy
situations.

IE I want to use the entropy calcs; I consider network IRQ spacing to be
sufficiently random and unobservable for them to be a valid source
of entropy, and (as the advantages doing so for various configs have
been widely documentated elsewhere) think that there should be a
config option (or /proc option) to support this. I do /not/ want to
ignore entropy calcs entirely (i.e. use /dev/urandom).

--
Alex Bligh
