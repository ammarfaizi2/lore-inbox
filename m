Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265913AbTGLPJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 11:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265917AbTGLPJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 11:09:28 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:53395 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S265913AbTGLPJ1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 11:09:27 -0400
Date: Sat, 12 Jul 2003 16:24:06 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 'what to expect'
Message-ID: <20030712152406.GA9521@mail.jlokier.co.uk>
References: <20030711140219.GB16433@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030711140219.GB16433@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> - Some people seem to have trouble running rpm, most notably Red Hat 9 users.
>   This is a known bug of rpm.
>   Workaround: run "export LD_ASSUME_KERNEL=2.2.5", before running rpm.

Ah, _thank you_.

It's not an rpm bug, as such; it's a problem/bug with DB4, the
Berkeley DB library.

I just spent 2 hours trying to figure out why rpm was failing.
write() returning EINVAL for no reason?  Finally spotted that O_DIRECT
was the significant bit.

I don't raise any eyebrows when rpm has a bug - after all, it's had
quite a few.  But I was disappointed to find Berkeley DB's own db_dump
unable to read the rpm database too.

End result: I copied an rpm database from another machine.  It's wrong
for this machine, but nearly right.  Ah well.

If I'd only known about the LD_ASSUME_KERNEL fix sooner.

Can this go into Documentation/Changes, please?

-- Jamie
