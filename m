Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316223AbSGQSu0>; Wed, 17 Jul 2002 14:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316604AbSGQSu0>; Wed, 17 Jul 2002 14:50:26 -0400
Received: from dsl-213-023-038-064.arcor-ip.net ([213.23.38.64]:59069 "EHLO
	starship") by vger.kernel.org with ESMTP id <S316223AbSGQSuZ>;
	Wed, 17 Jul 2002 14:50:25 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] new module format
Date: Wed, 17 Jul 2002 20:54:48 +0200
X-Mailer: KMail [version 1.3.2]
References: <Pine.LNX.4.44.0207161446400.8911-100000@serv>
In-Reply-To: <Pine.LNX.4.44.0207161446400.8911-100000@serv>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17Utwm-0004Oy-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 July 2002 15:04, Roman Zippel wrote:
> 1. Properly fixing module races: I'm playing with a init/start/stop/exit
> model, this has the advantage that we can stop anyone from reusing a
> module and we only have to wait for remaining users to go away until we
> can safely unload the module.

I'm satisfied that, for filesystems at least, all the module races can be 
solved without adding start/stop, and I will present code in due course.
However, Rusty tells me there are harder cases than filesystems.  At this
point I'm waiting for a specific example.

For filesystems, we rely on the filesystem code itself to know when all users 
have gone away.  If somebody is still executing in a filesystem module after 
all umounts are done, it's a horrible nasty bug.  We might still want to play 
games with checking execution addresses of processes to see if anybody is 
still in a module, but that would just be for debug; sys_delete_module can 
rely on the filesystem's opinion about whether a module is quiescent or not.

Somebody please give me an example of why this same strategy will not
work for all types of modular code.

-- 
Daniel
