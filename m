Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964912AbWAWTcY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964912AbWAWTcY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 14:32:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964914AbWAWTcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 14:32:24 -0500
Received: from mail.gmx.net ([213.165.64.21]:5297 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964912AbWAWTcW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 14:32:22 -0500
X-Authenticated: #428038
Date: Mon, 23 Jan 2006 20:32:17 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: John Richard Moser <nigelenki@comcast.net>
Cc: Michael Loftis <mloftis@wgops.com>, linux-kernel@vger.kernel.org
Subject: Re: soft update vs journaling?
Message-ID: <20060123193217.GA21783@merlin.emma.line.org>
Mail-Followup-To: John Richard Moser <nigelenki@comcast.net>,
	Michael Loftis <mloftis@wgops.com>, linux-kernel@vger.kernel.org
References: <43D3295E.8040702@comcast.net> <B78EFD916FFE8034EC546F38@dhcp-2-206.wgops.com> <43D525D8.8080501@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43D525D8.8080501@comcast.net>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jan 2006, John Richard Moser wrote:

> The idea of Soft Update was to make sure that while you may lose
> something, when you come back up the FS is in a safely usable state.

Soft Updates are *extremely* sensitive to reordered writes, and more
likely to be reordered at the same time than streaming to a linear
journal is. Don't even THINK of using softupdates without enforcing
write order. ext3fs, particularly with data=ordered or data=journal, is
much more forgiving in my experience. Not that I'd endorse dangerous use
of file system, but the average user just doesn't know.

FreeBSD (stable@ Cc:d) has no notion of write barriers as of yet as it
seems, wedging the SCSI bus in the middle of a write sequence causes
major devastations with WCE=1, and took me two runs of fsck to repair
(unfortunately I needed the (test) machine back up at once, so no time
to snapshot the b0rked partition for later scrutiny), and found myself
with two hundred files relocated to the lost+found office^Wdirectory.

Of course, it's the "Doctor, doctor, it always hurts my right eye if I'm
drinking coffee" -- "well, remove the spoon from your mug before
drinking then" (don't do that) category of "bug", but it hosts practical
relevance...

-- 
Matthias Andree
