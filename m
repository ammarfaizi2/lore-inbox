Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261627AbSKCEsd>; Sat, 2 Nov 2002 23:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261641AbSKCEsd>; Sat, 2 Nov 2002 23:48:33 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:27150 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261627AbSKCEsb>; Sat, 2 Nov 2002 23:48:31 -0500
Date: Sat, 2 Nov 2002 20:54:45 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Oliver Xymoron <oxymoron@waste.org>,
       Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>,
       "Theodore Ts'o" <tytso@mit.edu>, Dax Kelson <dax@gurulabs.com>,
       Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>,
       <davej@suse.de>
Subject: Re: Filesystem Capabilities in 2.6?
In-Reply-To: <Pine.GSO.4.21.0211022333241.25010-100000@steklov.math.psu.edu>
Message-ID: <Pine.LNX.4.44.0211022040140.2541-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 2 Nov 2002, Alexander Viro wrote:
> 
> No, that's OK -
> 
> mount --bind /usr/bin/foo.real /usr/bin/foo.real
> mount -o remount,nosuid /usr/bin/foo.real

Ehh. With the nosuid mount that will remove the effectiveness of the suid
bit (not just the user change - it will also mask off the elevation of the
capabilities), so the bind-mount with the capability mask will now mask
off nothing to start with.

Wouldn't it be much nicer to have:

  /usr/bin/foo - no suid bits, no capabilities by default

  mount --bind --capability=xx,yy /usr/bin/foo /usr/bin/foo

where the mount actually adds capabilities? Looks more understandable to
me.

			Linus

