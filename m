Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263803AbTKXRfu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 12:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263806AbTKXRfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 12:35:50 -0500
Received: from mail.jlokier.co.uk ([81.29.64.88]:3968 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S263803AbTKXRft (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 12:35:49 -0500
Date: Mon, 24 Nov 2003 17:35:27 +0000
From: Jamie Lokier <jamie@shareable.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Jakob Lell <jlell@JakobLell.de>, linux-kernel@vger.kernel.org
Subject: Re: hard links create local DoS vulnerability and security problems
Message-ID: <20031124173527.GA1561@mail.shareable.org>
References: <200311241736.23824.jlell@JakobLell.de> <Pine.LNX.4.53.0311241205500.18425@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0311241205500.18425@chaos>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> To prevent this, a user can set his default permissions so that
> neither group nor world can read the files. This is usually done
> by setting the attributes in the user's top directory.

Correct, but the quota problem is genuine: what if I want to create a
lot of files in /home/jamie that are readable by other users, but I
want to be able to delete them at some later time and reuse my quota
for something else?

This is quite a normal scenario on multi-user systems with quotas.

You seem to be suggesting that the only method is to have a separate
partition for each user, which is absurd.

Another method is "tree quotas" which have come up on this list
before.  Hopefully they will be included one day; tree quotas seem
like they would solve this problem and some others.

> A setuid binary created with a hard-link will only work as a setuid
> binary if the directory it's in is owned by root.

That isn't true.

> If you have users that can create files or hard-links within such
> directories, you have users who either know the root password
> already or have used some exploit to become root. In any case, it's
> not a hard-link problem

/tmp is owned by root and anyone can create a hard link in /tmp to
other files, on a system where /tmp doesn't have its own filesystem.

> No. Users must be able to create hard links to files that belong
> to somebody else if they are readable. It's a requirement.

I disagree.  The ability to create files and declare that someone else
can't hard link to them would be useful in a multi-user environment.

-- Jamie
