Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262103AbTDAHdJ>; Tue, 1 Apr 2003 02:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262107AbTDAHdJ>; Tue, 1 Apr 2003 02:33:09 -0500
Received: from modemcable226.131-200-24.mtl.mc.videotron.ca ([24.200.131.226]:9212
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S262103AbTDAHdJ>; Tue, 1 Apr 2003 02:33:09 -0500
Date: Tue, 1 Apr 2003 02:40:09 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org, "" <gibbs@scsiguy.com>
Subject: Re: aic7(censored) use after free in 2.5.66
In-Reply-To: <20030331232227.3f9c9c5f.akpm@digeo.com>
Message-ID: <Pine.LNX.4.50.0304010236270.8773-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0304010141200.8773-100000@montezuma.mastecende.com>
 <Pine.LNX.4.50.0304010155470.8773-100000@montezuma.mastecende.com>
 <20030331232227.3f9c9c5f.akpm@digeo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Mar 2003, Andrew Morton wrote:

> The corruption was at offset 52 decimal into struct ahc_linux_device. 
> Without knowing your config it is hard for me to work out what you have at
> that offset.   Rebuild your kernel with -g and do:
> 
> (gdb) p/d &(((struct ahc_linux_device *)0)->maxtags)
> 
> until you find which member is at offset 52.
> 
> Something incremented that field by one after it was freed.

(gdb) p/d &(((struct ahc_linux_device *)0)->timer.lock)
$4 = 52

That would be a lock free it appears.

-- 
function.linuxpower.ca
