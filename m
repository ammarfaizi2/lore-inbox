Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274424AbRIYCQd>; Mon, 24 Sep 2001 22:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274429AbRIYCQX>; Mon, 24 Sep 2001 22:16:23 -0400
Received: from domino1.resilience.com ([209.245.157.33]:47556 "EHLO
	intranet.resilience.com") by vger.kernel.org with ESMTP
	id <S274424AbRIYCQI>; Mon, 24 Sep 2001 22:16:08 -0400
Mime-Version: 1.0
Message-Id: <p0510030eb7d598d54e0f@[10.128.7.49]>
In-Reply-To: <3BAFDF16.4BD38E7C@sun.com>
In-Reply-To: <3BAFDF16.4BD38E7C@sun.com>
Date: Mon, 24 Sep 2001 19:16:36 -0700
To: Tim Hockin <thockin@sun.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: read() called twice for /proc files
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 6:34 PM -0700 2001-09-24, Tim Hockin wrote:
>Is there a general solution to the case of read() being called minimum
>twice for a file in /proc?  I have a small file in /proc, whose data takes
>a fair time to generate.  My read() handler gets called once for the data,
>and once so I can return 0 to terminate read().

I'm guessing you mean that the user is calling read once (and not a 
second time to get the 0/eof return), and that proc_file_read() is 
calling your read_proc twice. If that's the case, you can just set 
the eof flag on the first call (on which you return the data), and 
you won't be called again unless the user reads again.

And of course, as David Miller suggests, you can check the offset 
first, before generating data.
-- 
/Jonathan Lundell.
