Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265897AbTF3VRR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 17:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265899AbTF3VRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 17:17:17 -0400
Received: from as6-4-8.rny.s.bonet.se ([217.215.27.171]:8197 "EHLO
	pc2.dolda2000.com") by vger.kernel.org with ESMTP id S265897AbTF3VRQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 17:17:16 -0400
Content-Type: text/plain; charset=US-ASCII
From: Fredrik Tolf <fredrik@dolda2000.cjb.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PTY DOS vulnerability?
Date: Mon, 30 Jun 2003 23:31:38 +0200
User-Agent: KMail/1.4.3
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200306301613.11711.fredrik@dolda2000.cjb.net> <1056995729.17590.19.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1056995729.17590.19.camel@dhcp22.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200306302331.38071.fredrik@dolda2000.cjb.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'll summarize some of the answers:

On Monday 30 June 2003 19:55, Alan Cox wrote:
> On Llu, 2003-06-30 at 15:18, Fredrik Tolf wrote:
> > Shouldn't PTYs be a per-user resource limit?
>
> It depends to what degree you consider your users hostile. But
> yes its possibly one of the things to do per user counting on.

It isn't necessarily an entitled user; see below. But even if it 
is, I think it should be able to limit it, just as it is 
possible to put a limit on processes.

On Monday 30 June 2003 17:52, Marcelo Bezerra wrote:
> On Mon, 2003-06-30 at 11:18, Fredrik Tolf wrote:
> > Shouldn't PTYs be a per-user resource limit?
>
> This would help, but not solve.
>
> Once he roots your box, he can easly change the script to
> setuid each uid possible and request all ptys it can.
>
> Or he could run it as root, without the limit.

That is provided that he is able to root the system. Take for 
example Apache, a program that is relatively often cracked. It, 
as many other programs, doesn't run as root. If the attacker 
could tie up all PTYs, though, he could go on his business 
(extracting confidential information, subnet scanning, etc.) 
without root being able to log in to stop him. Instead, the 
admimistrator might have to call the datacenter to get them to 
reboot the box.
Of course, if the attacker is able to root the box, it doesn't 
help very with a resource limit, but that's more of an issue for 
the grsecurity project, isn't it?

On Monday 30 June 2003 16:24, Mark Hahn wrote:
> pty's are not required for ssh activity, though they would
> make it tricker.

That is true, though, of course. Stupid me not to think about 
that. However, that means that an administrator who could find 
himself being under such an attack might not think about it 
either. Also, from the outside, the ssh client just does 
nothing, making it look as if the server is unresponsive. Of 
course, the exact error is logged to the server's syslog, but if 
you can't view it, then you won't know about it.

So all in all, do you think I should implement a per-user 
resource limit on PTYs?

Fredrik Tolf

