Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261599AbSKCDyI>; Sat, 2 Nov 2002 22:54:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261595AbSKCDyI>; Sat, 2 Nov 2002 22:54:08 -0500
Received: from mail.gurulabs.com ([208.177.141.7]:25754 "EHLO
	mail.gurulabs.com") by vger.kernel.org with ESMTP
	id <S261599AbSKCDyH>; Sat, 2 Nov 2002 22:54:07 -0500
Date: Sat, 2 Nov 2002 21:00:38 -0700 (MST)
From: Dax Kelson <dax@gurulabs.com>
X-X-Sender: dkelson@mooru.gurulabs.com
To: Oliver Xymoron <oxymoron@waste.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Alexander Viro <viro@math.psu.edu>,
       Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>,
       "Theodore Ts'o" <tytso@mit.edu>, Rusty Russell <rusty@rustcorp.com.au>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "davej@suse.de" <davej@suse.de>
Subject: Re: Filesystem Capabilities in 2.6?
In-Reply-To: <20021103035017.GD18884@waste.org>
Message-ID: <Pine.LNX.4.44.0211022052180.20616-100000@mooru.gurulabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Nov 2002, Oliver Xymoron wrote:

> # mv ping ping.real
> # chmod -s ping.real
> # mkcapwrap +net_raw ping.real
> # chmod +s ping
> # showcapwrap ping
> invokes /bin/ping
> grants net_raw
> #

Do you mean?

# mv ping ping.real
# chmod -s ping.real
# mkcapwrap +net_raw ping
# chmod +s ping
# showcapwrap ping
invokes /bin/ping.real
grants net_raw
#

The wrapper needs to setuid/gid to the uid/gid that invokes it.

uid root with no caps (or few caps) is still very powerful (replace 
binaries owned by root, read /etc/shadow, etc).

Currently all capabilities are cleared when non-root app does a execp. 
This would need to be addressed.

Dax

