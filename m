Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261611AbSKCEbN>; Sat, 2 Nov 2002 23:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261615AbSKCEbN>; Sat, 2 Nov 2002 23:31:13 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:50578 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261611AbSKCEbM>;
	Sat, 2 Nov 2002 23:31:12 -0500
Date: Sat, 2 Nov 2002 23:37:42 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Oliver Xymoron <oxymoron@waste.org>,
       Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>,
       "Theodore Ts'o" <tytso@mit.edu>, Dax Kelson <dax@gurulabs.com>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       davej@suse.de
Subject: Re: Filesystem Capabilities in 2.6?
In-Reply-To: <Pine.LNX.4.44.0211022004510.2503-100000@home.transmeta.com>
Message-ID: <Pine.GSO.4.21.0211022333241.25010-100000@steklov.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 2 Nov 2002, Linus Torvalds wrote:

> However, I think there is a problem with Al's original approach: the bind 
> can _not_ be just a mask that takes away capabilities from a suid 
> application, since that would imply that the app has to be marked suid in 
> the first place (and accessing it _without_ going through the bind will 
> give it elevated privileges, which is what we're trying to avoid).

No, that's OK -

mount --bind /usr/bin/foo.real /usr/bin/foo.real
mount -o remount,nosuid /usr/bin/foo.real

or equivalent couple of mount(2) calls will do the trick nicely (and that,
BTW, we have right now - you can selectively disable/enable suid on files
and entire subtrees).

