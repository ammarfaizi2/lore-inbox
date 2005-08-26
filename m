Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965098AbVHZQ1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965098AbVHZQ1O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 12:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965099AbVHZQ1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 12:27:14 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:6096 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965098AbVHZQ1N convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 12:27:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=DgxBEf8Qr6Y6IexbRwEfD6IbpaevAJl2+Awd8WL+LPHJiSx4QNJjXp01GNN8t/lnEnDU0xupl7IfcCfCjv6C8wQWziheh/oO/jHUshlJ95gdw0OMcOmq/zFRowGy7RIcdbpgTDE8bWU2kUz+UiGgxk2EuuQph//lAHU9qWP0+RI=
Date: Fri, 26 Aug 2005 18:27:03 +0200
From: Diego Calleja <diegocg@gmail.com>
To: Justin Heesemann <jh@ionium.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: extremely slow disk access due to mremap?
Message-Id: <20050826182703.9c0217f3.diegocg@gmail.com>
In-Reply-To: <200508261709.58671.jh@ionium.org>
References: <200508261709.58671.jh@ionium.org>
X-Mailer: Sylpheed version 2.1.1+svn (GTK+ 2.6.8; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Fri, 26 Aug 2005 17:09:58 +0200,
Justin Heesemann <jh@ionium.org> escribió:

> finally i found a good reproducable way to test this behavior:
> 
> # time grep ^....$ /usr/share/dict/words > /dev/null
> 
> real    0m7.728s
> user    0m7.713s
> sys     0m0.011s

The problem seems (IMO) to be in userspace, your software seems to be doing
too much stuff for no good reason. If grep calls mremap() too many times
that's their problem; and even if it's doing that, the kernel is doing the
mremap() stuff quite fast

> the funny thing is: if i don't grep for a regexp, it's working fine:
> # grep asdf /usr/share/dict/words
[...]
> since right now i'm out of ideas what to look for next, could you please 
> help me?

Maybe a bug in the regexp code in your /bin/grep? Are you using
different distro/versions in your two boxes?

