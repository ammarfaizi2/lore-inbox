Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275031AbRJNJsn>; Sun, 14 Oct 2001 05:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275042AbRJNJsX>; Sun, 14 Oct 2001 05:48:23 -0400
Received: from max.tat.physik.uni-tuebingen.de ([134.2.170.93]:32148 "HELO
	master.kde.org") by vger.kernel.org with SMTP id <S275012AbRJNJsN>;
	Sun, 14 Oct 2001 05:48:13 -0400
Date: Sun, 14 Oct 2001 11:48:44 +0200
To: linux-kernel@vger.kernel.org
Subject: vfat permissions (umask, noexec) brokeness (once more ...)
Message-ID: <20011014114844.A8807@ugly.wh8.tu-dresden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22i
From: Oswald Buddenhagen <ossi@kde.org>
X-Spam-Rating: max.tat.physik.uni-tuebingen.de 300/1000/N
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

as we all know, the noexec handling was changed in 2.4.10.  now some
people claim, that using umask=111 is the right way to get the old
behaviour - but that's _wrong_. as opposed to their statements, vfat's
umask= does _not_ apply only to regular files, but also to directories
(you just don't notice it when you run as root) - and it's right that
way, as otherwise you could not specify umask=77 to lock out all users
but the owner specified by uid= & gid=.
i see two possible solutions: a new flag "noexecbits" which works like
the old (=broken) "noexec" or two different umasks (like samba does):
one for directories and one for regular files.
btw, the "showexec" flag is a big improvement to the situation, but i
still don't like it, as the files just are not executable without major
magic ...

greetings

ps: cc me, i'm not on the list.

-- 
Hi! I'm a .signature virus! Copy me into your ~/.signature, please!
--
Nothing is fool-proof to a sufficiently talented fool.
