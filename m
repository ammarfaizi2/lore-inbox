Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286687AbSAIOA2>; Wed, 9 Jan 2002 09:00:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286692AbSAIOAS>; Wed, 9 Jan 2002 09:00:18 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:28687 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S286672AbSAIOAG>;
	Wed, 9 Jan 2002 09:00:06 -0500
Date: Wed, 9 Jan 2002 14:59:52 +0100
From: Jens Axboe <axboe@suse.de>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: Mark Hahn <hahn@physics.mcmaster.ca>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] Error reading multiple large files
Message-ID: <20020109145952.D19814@suse.de>
In-Reply-To: <Pine.LNX.4.33.0201071413250.5017-100000@coffee.psychology.mcmaster.ca> <Pine.LNX.4.30.0201091454060.6953-100000@mustard.heime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0201091454060.6953-100000@mustard.heime.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09 2002, Roy Sigurd Karlsbakk wrote:
> > you really should try akpm's "[patch, CFT] improved disk read latency"
> > patch.  it sounds almost perfect for your application.
> 
> hi
> 
> It seemed like it helped first, but after a while, some 99 processes went
> Defunct, and locked. After this, the total 'bi' as reported from vmstat
> went down to ~ 900kB per sec

Bad news for Andrew's patch, however I really don't think it would have
helped you much in the first place. The problem seems to be down to
loosing read-ahead when cache ends up eating all of available memory,
I've seen this effect myself too. Maybe the vm needs to be more
aggressive about tossing out pages when this happens, I'm quite sure
that would help tremendously for this workload.

-- 
Jens Axboe

