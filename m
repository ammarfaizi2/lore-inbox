Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272441AbRIPQXo>; Sun, 16 Sep 2001 12:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272418AbRIPQXe>; Sun, 16 Sep 2001 12:23:34 -0400
Received: from adsl-209-182-168-213.value.net ([209.182.168.213]:16653 "EHLO
	draco.foogod.com") by vger.kernel.org with ESMTP id <S272527AbRIPQX3>;
	Sun, 16 Sep 2001 12:23:29 -0400
Message-ID: <3BA4D554.4030203@foogod.com>
Date: Sun, 16 Sep 2001 09:37:40 -0700
From: Alex Stewart <alex@foogod.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lazy umount (1/4)
In-Reply-To: <Pine.GSO.4.21.0109141427070.11172-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:

> It's _very_ useful in a lot of situations - basically, that's what
> umount -f should have been.


Actually, I personally would still like a 'umount -f' (or 'umount 
--yes-I-know-what-Im-doing-and-I-really-mean-it-f' or whatever) that 
actually works for something other than NFS.  In this age of 
hot-pluggable (and warm-pluggable) storage it's increasingly annoying to 
me that I should have to reboot the whole system to fix an otherwise 
hot-fixable hardware problem just because some processes got stuck in a 
disk-wait state before the problem was detected.

I want an operation that will:

1. Interrupt/Abort any processes disk-waiting on the filesystem
2. Unmount the filesystem, immediately and always.
3. Release any filesystem-related holds on the underlying device.
4. Allow me to mount it again later (when problems are fixed).

Basically, I want a 'kill -KILL' for filesystems.

Now, admittedly, this is only something one would want to do in a last 
resort, but currently when one gets to that point of last resort, linux 
has no tools available for them.  This is one of the areas that I've 
always considered linux (and most unixes) to have a gaping hole in the 
"sysadmin should be able to control their system, not vice-versa" 
philosophy, and really is needed in addition to any nifty tricks with 
"lazy umounting", etc. IMO (though the lazy umount thing is kinda nifty, 
and I can see other uses for it).

Just my $.02..

-alex

