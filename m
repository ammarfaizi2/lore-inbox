Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267993AbRGZOhu>; Thu, 26 Jul 2001 10:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268000AbRGZOhk>; Thu, 26 Jul 2001 10:37:40 -0400
Received: from spring.webconquest.com ([66.33.48.187]:4113 "HELO
	mail.webconquest.com") by vger.kernel.org with SMTP
	id <S267993AbRGZOhY>; Thu, 26 Jul 2001 10:37:24 -0400
Date: Thu, 26 Jul 2001 10:37:21 -0400 (EDT)
From: <sentry21@cdslash.net>
To: <linux-kernel@vger.kernel.org>
Subject: Weird ext2fs immortal directory bug
Message-ID: <Pine.LNX.4.30.0107261028000.18300-100000@spring.webconquest.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

A long long time ago, I can still remember... My computer hosed itself
(power out as I recall), and then when it was coming back up and running
e2fsck, the power went out again - perhaps not the exact situation, but
suffice to say, init ended up running e2fsck on my drive, and filling
/lost+found/ with lots of garbage, most of which I needed.

I managed to easily clean it out, with one exception. And a friend
recently suggested posting it to this list. Can anyone here
explain what on earth is going on, and how to get rid of it?

Incidentally, it's been around since a custom-compiled 2.3.x (where x > 40
I believe), and has been impervious to my fixing ever since.

Also, I'm not subscribed, so please, any replies CC'ed to
dan@cdslash.net, I'd appreciate it.

Here's the problem(s) (or at least, the symptoms):

sentry21@Petra:1:/lost+found$ ls -l
total 0
lr----S---    1 52       12337           0 Nov  1  2022 #3147 ->

sentry21@Petra:0:/lost+found$ file \#3147/
#3147/: directory

sentry21@Petra:0:/lost+found$ rm -rf \#3147/
rm: cannot unlink `#3147': Permission denied

sentry21@Petra:1:/lost+found$ sudo rm -rf \#3147/
rm: cannot unlink `#3147': Operation not permitted

sentry21@Petra:1:/lost+found$ sudo chown sentry21.sentry21 \#3147/
chown: changing ownership of `#3147': Operation not permitted

sentry21@Petra:1:/lost+found$ cd \#3147/

sentry21@Petra:0:/lost+found/#3147$ ls
#3147@

sentry21@Petra:0:/lost+found/#3147$ cd \#3147/

sentry21@Petra:0:/lost+found/#3147/#3147$ ls
#3147@

sentry21@Petra:0:/lost+found/#3147/#3147$ cd
\#3147/#3147/#3147/#3147/#3147/#3147/#3147/#3147/

sentry21@Petra:0:/lost+found/#3147/#3147/#3147/#3147/#3147/#3147/#3147/#3147/#3147/#3147$ ls
#3147@

sentry21@Petra:0:/lost+found/#3147/#3147/#3147/#3147/#3147/#3147/#3147/#3147/#3147/#3147$ pwd
/lost+found/#3147/#3147/#3147/#3147/#3147/#3147/#3147/#3147/#3147/#3147

sentry21@Petra:0:/lost+found/#3147/#3147/#3147/#3147/#3147/#3147/#3147/#3147/#3147/#3147$ file \#3147/
#3147/: directory


Weird, ne? I -did- manage to make it -not rwxrwxrwx, suid, sgid, sticky,
and every other bloody FS flag you can stick on a directory (and lots you
can't), but it's still impervious to my sk|llz. It's not hurting anything,
but cron whines about it every day.

Thanks.

--Dan

