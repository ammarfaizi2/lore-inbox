Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265312AbTFFFfQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 01:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265317AbTFFFfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 01:35:16 -0400
Received: from ishtar.tlinx.org ([64.81.58.33]:20937 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S265312AbTFFFfO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 01:35:14 -0400
From: "linda w." <lkml@tlinx.org>
To: "'Albert Cahalan'" <albert@users.sourceforge.net>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>, <lkml@tlinx.org>
Subject: RE: reading links in proc - permission denied
Date: Thu, 5 Jun 2003 22:45:21 -0700
Message-ID: <000101c32bee$d159f410$1403a8c0@sc.tlinx.org>
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
In-Reply-To: <1054865029.22103.6995.camel@cube>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your answer, I guess not many people understand some of
these things.

So...if I'm not allowed to read the link, wouldn't it be a bug
for the permissions to claim it is group/other readable?

lrwxrwxrwx    1 root     root            0 Jun  5 22:29 /proc/2/exe

Exactly "what" is determining the permissions on the ability to read
the link if not the file permissions?

Should it read?
lrwx------    1 root     root            0 Jun  5 22:29 /proc/2/exe



> Please don't try this yourself. I can spot bugs
> in almost any parser for these files. Consider
> processes with names like these:
>
> "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
> ":-) 1 2 3 4 5 6"
> "foo Pid: 42"
> "x State: Z (z)"
---
	Yeah...it could be a mess, but wouldn't you be guaranteed that it
would be a zero terminated string?

> The restricted permission on /proc/*/exe is kind of
> dumb though, considering that /proc/*/maps is wide open.
> Ability to follow the link might need to be restricted,
> since the link is (was?) magic. It acts somewhat like
> a hard link, bypassing permissions along the path.
---
	Well that "could" be handled by an attempt to stat the target in
the user's context and see if the file can be reached through the
directory chain, but hey, what's the point of consistency, anyway?
"Isn't it consistency is the foolish hobgoblin of small minds?"  Er,
something like that....


>
> > Purely from a 'cleanliness' standpoint, is the
> > environment owned by the user-id, or is it a common
> > piece of public, kernel (root) owned data?
>
> It's swappable. The process can muck with it.
---
	So if the process could muck with it, like path, then if it was
able to switch back to ROOT, wouldn't that be a security risk?

> There's nothing wrong with parsing ps output. Be sure to split
> on whitespace, and not by character position. You can also use
> pgrep or pidof. For example:
>
> ps -C foo -opid=
> pgrep -u root sshd
> pidof something
---
some more primitive unix clones (cygwin for example) don't have
such luxuries....now that I mention it....it doesn't have an 'exe'
entry under proc either...*snort*.

Nevermind....:-)

-l


