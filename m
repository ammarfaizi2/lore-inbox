Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932309AbWHGWYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbWHGWYX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 18:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbWHGWYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 18:24:23 -0400
Received: from relay00.pair.com ([209.68.5.9]:62986 "HELO relay00.pair.com")
	by vger.kernel.org with SMTP id S932285AbWHGWYW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 18:24:22 -0400
X-pair-Authenticated: 71.197.50.189
Date: Mon, 7 Aug 2006 17:24:08 -0500 (CDT)
From: Chase Venters <chase.venters@clientec.com>
X-X-Sender: root@turbotaz.ourhouse
To: Edgar Toernig <froese@gmx.de>
cc: Pekka Enberg <penberg@cs.helsinki.fi>, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       akpm@osdl.org, viro@zeniv.linux.org.uk, alan@lxorguk.ukuu.org.uk,
       tytso@mit.edu, tigran@veritas.com
Subject: Re: [RFC/PATCH] revoke/frevoke system calls V2
In-Reply-To: <20060807224144.3bb64ac4.froese@gmx.de>
Message-ID: <Pine.LNX.4.64.0608071720510.29055@turbotaz.ourhouse>
References: <Pine.LNX.4.58.0607271722430.4663@sbz-30.cs.Helsinki.FI>
 <20060805122936.GC5417@ucw.cz> <20060807101745.61f21826.froese@gmx.de>
 <84144f020608070251j2e14e909v8a18f62db85ff3d4@mail.gmail.com>
 <20060807224144.3bb64ac4.froese@gmx.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Aug 2006, Edgar Toernig wrote:

>
> Your implementation is much cruder - it simply takes the fd
> away from the app; any future use gives EBADF.  As a bonus,
> it works for regular files and even goes as far as destroying
> all mappings of the file from all processes (even root processes).
> IMVHO this is a disaster from a security and reliability point
> of view.
>

I can see the value in these system calls, but I agree that the 
implementation is crude. "EBADF" is not something that applications are 
taught to expect. Someone correct me if I'm wrong, but I can think of no 
situation under which a file descriptor currently gets yanked out from 
under your feet -- you should always have to formally abandon it with 
close().

This kind of thing only looks proper if it leaves the file descriptor in 
place and just returns errors / EOF when you attempt to access it.

Thanks,
Chase
