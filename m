Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317347AbSHTUy6>; Tue, 20 Aug 2002 16:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317334AbSHTUy6>; Tue, 20 Aug 2002 16:54:58 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:63249 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317326AbSHTUy5>; Tue, 20 Aug 2002 16:54:57 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: automount doesn't "follow" bind mounts
Date: 20 Aug 2002 13:58:38 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <ajuahu$hf$1@cesium.transmeta.com>
References: <Pine.LNX.4.44.0208201752430.23681-100000@r2-pc.dcs.qmul.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.44.0208201752430.23681-100000@r2-pc.dcs.qmul.ac.uk>
By author:    Matt Bernstein <mb/lkml@dcs.qmul.ac.uk>
In newsgroup: linux.dev.kernel
>
> I tried to subscribe to the autofs list, but majordomo isn't replying to 
> me! I think this is a problem in the automount daemon rather than the 
> kernel autofs code itself.
> 
> I'm trying to automount our home dirs as
> 	/homes/$USERNAME
> which should bind mount to
> 	:/home/$SERVER/$HOMENAME/$USERNAME
> which should bind mount to
> 	:/home/$SERVER/$VOLUME/$PATH/$USERNAME
> which (phew!) will be an NFS mount to
> 	$SERVER:/$VOLUME/$PATH/$USERNAME
> 
> The idea is that:
> 	(1) `/bin/pwd` = "/homes/$USERNAME"
> 	(2) when you run "quota" it'll only report for $SERVER:/$VOLUME
> 
> Now.. this all works perfectly if before looking at /homes/$USERNAME you
> look at firstly /home/$SERVER/$VOLUME/$PATH/$USERNAME and then secondly
> /home/$SERVER/$HOMENAME/$USERNAME, because the bind mounts have something
> to bind to. Of course you shouldn't need to know the middle bits, but you
> could look them up. Currently the binds mount fail and automount drops in
> symlinks; this satisfies (2)  above, but unfortunately not (1).
> 
> I hope someone can make sense of this. Is it different in autofs4?
> 

This is unfortunately nearly impossible to solve.  It's a known bug,
but it's questionable if anything can be done about it.

For right now, autofs cannot bind-mount to a mount from the same
automount point (the problem is with the double-use of /home/$SERVER
in your case.)

   	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
