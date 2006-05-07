Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751076AbWEGFrc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbWEGFrc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 01:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbWEGFrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 01:47:32 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:12512
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751076AbWEGFrc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 01:47:32 -0400
Date: Sat, 06 May 2006 22:46:39 -0700 (PDT)
Message-Id: <20060506.224639.91383490.davem@davemloft.net>
To: mpm@selenic.com
Cc: tytso@mit.edu, mrmacman_g4@mac.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/14] random: Remove SA_SAMPLE_RANDOM from network
 drivers
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060507045920.GH15445@waste.org>
References: <20060506164808.GY15445@waste.org>
	<20060506.170810.74552888.davem@davemloft.net>
	<20060507045920.GH15445@waste.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matt Mackall <mpm@selenic.com>
Date: Sat, 6 May 2006 23:59:20 -0500

> First, since the existence of /dev/random's entropy accounting scheme
> is predicated on the assumption that we can break the hash function at
> will, I'll replace SHA1 with, oh, say, CRC-16. This'll be illustrative
> until someone has a nice preimage attack against SHA1.

I don't understand why you're changing one of the preconditions
in order to "prove" that what we have now can be broken.  This
is more swiss cheese theory.

We use SHA1 right now, so you have to use SHA1 in your reproducable
attack.  Since there is no preimage attack for SHA1 you can't
prove that it can be done.

> Then I'll run my test on one of the various arches where HZ=~100 and
> we don't have a TSC. Like Sparc?
> 
>   /* XXX Maybe do something better at some point... -DaveM */
>   typedef unsigned long cycles_t;
>   #define get_cycles()    (0)

You're really stretching things here, using a platform that is
basically in almost no usage at all.  Sure if you use a silly
example, almost anything is possible.  CRC-16 and sparc 32-bit,
give me a break.

And the remote person has to know that the machine is a 32-bit sparc
box, good luck with that.  And this is yet another variable amongst
all of the highly variable and unpredictable delays between packet
visibility on the wire and the actual interrupt being serviced, which
you have not addressed at all.

You haven't addressed the real case that matters, the ones on
platforms that have a TSC that works and with SHA1.

Until you prove that can be broken, you are simply still spewing
more of your incredible swiss cheese theory.  Don't give me any
crap about an almost entirely abandoned architecture that doesn't
implement TSC, and using algorithms other than SHA1.  The real code
uses SHA1, so that's what you have to prove can be broken.

You're just circling around the real issues and trying to be "right"
and this is what I dislike so much about theoretical people.  They
show you what can be done theoretically, yet never in practice with
what we really have now.
