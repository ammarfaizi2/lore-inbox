Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135296AbRDRUT0>; Wed, 18 Apr 2001 16:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135297AbRDRUTH>; Wed, 18 Apr 2001 16:19:07 -0400
Received: from mail.ettnet.se ([212.109.4.7]:18698 "HELO mail.ettnet.se")
	by vger.kernel.org with SMTP id <S135296AbRDRUSz>;
	Wed, 18 Apr 2001 16:18:55 -0400
Date: Thu, 19 Apr 2001 00:28:52 +0200
From: Joel Eriksson <jen@ettnet.se>
To: linux-kernel@vger.kernel.org
Subject: Socket hack question.
Message-ID: <20010419002852.A24647@seth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Phone: +46-736-256517
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am a kernel hacking newbie and am struggling to understand the
networking subsystem. I would like to be able to add a systemcall,
preferably asynchronous, that connects a socket with a filedescriptor
(proxy(srcsd, dstfd)) so that everything received on srcsd is directly
written to dstfd. The proxy should close when srcsd is closed or when
a zero-size packet is sent (or something like that..).

I started digging in the source yesterday, and have read a little
in "The Linux Kernel" document and a few others, but can't say I
feel much wiser. :-) I was thinking about creating a custom "data_ready"
function that I set for the socket to be forwarded (in "struct sock"),
does this make sense? How would I go about to write the data to the
destination file/socket descriptor?

I am of course fully aware that it is not of public interest and
have certainly not intended to try getting it into the mainstream
kernel. :-) I'm just going to use it for a web server I am developing
that communicates with applications via sockets (UNIX domain for
local apps and TCP for remote), portability is not an issue in this
particular case. Another obvious use is for bouncers.

I would like to avoid the kernel -> userspace -> kernel copying
of data just to forward a packet.. The web server should be able
to scale up to a couple of thousands simultaneous connections
without significant performance penalty, so I plan to use multiple
processes or perhaps threads to avoid the bad scalability of
select()/poll().

When I (or if I :-) get more proficient in kernel hacking I will
perhaps try adding support for fully event-driven I/O handling.
Or are there perhaps any similar patches available from somewhere
already?

-- 
Joel Eriksson
