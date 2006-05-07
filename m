Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932193AbWEGQgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbWEGQgP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 12:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932194AbWEGQgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 12:36:15 -0400
Received: from waste.org ([64.81.244.121]:46561 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S932193AbWEGQgP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 12:36:15 -0400
Date: Sun, 7 May 2006 11:31:14 -0500
From: Matt Mackall <mpm@selenic.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: tytso@mit.edu, mrmacman_g4@mac.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/14] random: Remove SA_SAMPLE_RANDOM from network drivers
Message-ID: <20060507163114.GN15445@waste.org>
References: <20060506164808.GY15445@waste.org> <20060506.170810.74552888.davem@davemloft.net> <20060507045920.GH15445@waste.org> <20060506.224639.91383490.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060506.224639.91383490.davem@davemloft.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 06, 2006 at 10:46:39PM -0700, David S. Miller wrote:
> You're just circling around the real issues and trying to be "right"
> and this is what I dislike so much about theoretical people.  They
> show you what can be done theoretically, yet never in practice with
> what we really have now.

What you're missing is this:

/dev/random's entropy counting scheme sole reason to exist is to
defend against theoretical future attacks against its cryptographic
primitives. Thus _any_ discussion of its correctness must perforce be
theoretical.

By substituting CRC-16 for SHA1, I've simply brought the future 
attack we're concerned about to today.

As I said at the beginning of this thread, I'm perfectly happy to
continue taking samples from network devices. My concerns are entirely
with how we account their entropy, which is strictly in the realm of
theory to start with.

I will instead change the entropy estimator to be more conservative
and to note the presence of high resolution clocks so that we can feed
it garbage more safely.

-- 
Mathematics is the supreme nostalgia of our time.
