Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268500AbTBWPXR>; Sun, 23 Feb 2003 10:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268501AbTBWPXQ>; Sun, 23 Feb 2003 10:23:16 -0500
Received: from [195.223.140.107] ([195.223.140.107]:20870 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S268500AbTBWPXP>;
	Sun, 23 Feb 2003 10:23:15 -0500
Date: Sun, 23 Feb 2003 16:34:39 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [ak@suse.de: Re: iosched: impact of streaming read on read-many-files]
Message-ID: <20030223153439.GE29467@dualathlon.random>
References: <20030222054307.GA22074@wotan.suse.de> <20030221230716.630934cf.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030221230716.630934cf.akpm@digeo.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2003 at 11:07:16PM -0800, Andrew Morton wrote:
> request within ten milliseconds is an impossibility.  Attempting to 
> achieve it will result in something which seeks all over the place.

This is called SFQ, or CFQ with 0 dispatch queue level and it works
fine (given a fixed amount of tasks doing I/O). You still don't
understand you don't care about throughput and seeks if you only need to
read 1 block with the max fairness and you don't mind to read another
block within 1 second. seeking is the last problem here, waiting more
than 1 second is the only problem here.

Andrea
