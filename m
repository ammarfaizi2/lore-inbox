Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130949AbRA2PWA>; Mon, 29 Jan 2001 10:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131421AbRA2PVv>; Mon, 29 Jan 2001 10:21:51 -0500
Received: from mail.rd.ilan.net ([216.27.80.130]:38416 "EHLO mail.rd.ilan.net")
	by vger.kernel.org with ESMTP id <S130949AbRA2PVi>;
	Mon, 29 Jan 2001 10:21:38 -0500
Message-ID: <3A758A57.CB019330@holly-springs.nc.us>
Date: Mon, 29 Jan 2001 10:20:55 -0500
From: Michael Rothwell <rothwell@holly-springs.nc.us>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mo McKinlay <mmckinlay@gnu.org>
CC: Peter Samuelson <peter@cadcamlab.org>, linux-kernel@vger.kernel.org
Subject: Re: named streams, extended attributes, and posix
In-Reply-To: <Pine.LNX.4.30.0101191633200.2331-100000@nvws005.nv.london>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mo McKinlay wrote:
> I would too, but POSIX won't let us unless we start enforcing side-effect
> rules for all filesystems. Hence why I came up with openstream() :)

So, openstream() is probably the most painless way to get named streams
support into Linux in the immediate future. Openstream() will have to
fail on filesystems that do not support streams, ideally without
changing those filesystems. And as long as we're adding a system call to
deal with streams, we should consider adding the functions for extended
attributes at the same time.

>From http://www.flyingbuttmonkeys.com/streams-on-posix.txt ...

Minimum VFS Support
vop_eattr_get - read an EA
vop_eattr_set - set an EA
vop_eattr_remove - remove an EA
vop_eattr_list - list the EAs like vop_readdir would a directory.

Optional Support
vop_eattr_create - Create an EA or error if it exists.
vop_eattr_multi - perform a sequence of EA vops atomically.
vop_eattr_rename - change the name of an EA
vop_eattr_serialize - export all the EAs as a stream of entries.

Thoughts? You mught want to refer back to the paper to get the whole EAs
proposal...

-M
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
