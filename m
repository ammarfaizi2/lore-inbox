Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269937AbRHSDMr>; Sat, 18 Aug 2001 23:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269936AbRHSDMg>; Sat, 18 Aug 2001 23:12:36 -0400
Received: from odyssey.netrox.net ([204.253.4.3]:47516 "EHLO t-rex.netrox.net")
	by vger.kernel.org with ESMTP id <S269930AbRHSDM3>;
	Sat, 18 Aug 2001 23:12:29 -0400
Subject: Re: [PATCH] let Net Devices feed Entropy, updated (1/2)
From: Robert Love <rml@tech9.net>
To: Oliver Xymoron <oxymoron@waste.org>
Cc: linux-kernel@vger.kernel.org, riel@conectiva.com.br
In-Reply-To: <Pine.LNX.4.30.0108181839130.31188-100000@waste.org>
In-Reply-To: <Pine.LNX.4.30.0108181839130.31188-100000@waste.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99+cvs.2001.08.18.07.08 (Preview Release)
Date: 18 Aug 2001 23:12:39 -0400
Message-Id: <998190772.8307.8.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Aug 2001 18:41:30 -0500, Oliver Xymoron wrote:
> Why don't those who aren't worried about whether they _really_ have enough
> entropy simply use /dev/urandom?

because there still is no entropy.  /dev/urandom and /dev/random are
from the same source - /dev/random will just block if the entropy count
drops to 0.  note that entropy != bytes in pool.  the "entropy" is an
estimate of the randomness of the pool.  it decrements as bytes are
pulled from the pool.  the byte count does not, thus the pool is not
empty when /dev/random blocks, it just has no "entropy".

on a diskless/headless system, there are no devices to feed the entropy
pool.  thus this patch, which is a lifesaver for some, as Rik pointed
out.

or maybe you are like me, and on a personal LAN or dont care about
external attackers trying to guess your /dev/random, and just want
another source of entropy to boost your self-esteem.

i would like to see this in the mainline kernel. i posted a 2.4.8-pre
patch early, i will rediff for 2.4.9 asap.

fyi, i am considering rewriting the patch. Alex Bligh and I had a
discussion where he suggested a sysctl/proc interface to toggle the
option. this would add post-compile code to the kernel, but allow
greater flexibility.  

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

