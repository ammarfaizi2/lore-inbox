Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318849AbSICR7s>; Tue, 3 Sep 2002 13:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318861AbSICR60>; Tue, 3 Sep 2002 13:58:26 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:2458 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S318849AbSICR6A>;
	Tue, 3 Sep 2002 13:58:00 -0400
Date: Tue, 3 Sep 2002 20:02:03 +0200
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: One more bio for for floppy users in 2.5.33..
Message-ID: <20020903180203.GD13721@suse.de>
References: <Pine.LNX.4.44.0209031054290.1356-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209031054290.1356-100000@home.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03 2002, Linus Torvalds wrote:
> 
> Ok,
>  I found another major bio-related bug that definitely explains why the 
> floppy driver generated corruption - any partial request completion would 
> be totally messed up by the BIO layer (not the floppy driver).
> 
> Any other block device driver that did partial request completion might 
> also be impacted.
> 
> I'm still looking at the floppy driver itself - some of the request 
> completion code is so messed up as to be unreadable, and some of that may 
> actually be due to trying to work around the bio problem (unsuccessfully, 
> I may add). So this may not actually fix things for you yet, simply 
> because the floppy driver itself still does some strange things. 
> 
> Jens, oops. We should not update the counts by how much was left
> uncompleted, but by how much we successfully completed!

Yeah oops, the most embarassing thing is that Bart and I have both found
this but independently months ago but it seems it got lost at my end (or
your end, but lets not point fingers :-) :-(

Patch is ofcourse correct. I'm not sure other drivers have been hit (of
the used ones), since they would have to use old style completions and
do less than current_nr_sectors in one-go.

-- 
Jens Axboe

