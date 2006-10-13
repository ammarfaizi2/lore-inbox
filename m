Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751897AbWJMUyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751897AbWJMUyU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 16:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751902AbWJMUyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 16:54:19 -0400
Received: from 1wt.eu ([62.212.114.60]:36868 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1751897AbWJMUyT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 16:54:19 -0400
Date: Fri, 13 Oct 2006 22:52:47 +0200
From: Willy Tarreau <w@1wt.eu>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Kay Sievers <kay.sievers@vrfy.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.19-rc2
Message-ID: <20061013205247.GG5050@1wt.eu>
References: <Pine.LNX.4.64.0610130941550.3952@g5.osdl.org> <200610131840.28411.s0348365@sms.ed.ac.uk> <452FD305.6070902@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <452FD305.6070902@zytor.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2006 at 10:55:17AM -0700, H. Peter Anvin wrote:
> Alistair John Strachan wrote:
> >On Friday 13 October 2006 17:49, Linus Torvalds wrote:
> >>Ok, it's a week since -rc1, so -rc2 is out there.
> >
> >Does anybody know what's up with the git server? Hopefully it's just my 
> >connection...
> >
> >[alistair] 18:38 [~/linux-git] git pull
> >fatal: unexpected EOF
> >Fetch failure: 
> >git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> >
> 
> No, this is the result of a serious problem with gitweb.
> 
> We run gitweb behind a cache (otherwise it would be unacceptably 
> expensive), but when httpd starts timing out on gitweb, it spawns gitweb 
> over and over and over again, and the load on the machine skyrockets, 
> throttling other services.
> 
> This happens every time we're on one server instead of two (one server 
> is down right now for network rewiring.)
> 
> I think for now I'm just going to put a loadavg cap on running gitweb...

I encountered a similar problem (to a far lower scale) when putting
gitweb on my poor parisc server behind my ADSL line. The machine used
to OOM several times a week. So I've set up an haproxy instance in
front of it with a limit on the number of concurrent connections per
backend. All excess connections are queued and served as soon as one
slot frees up. The machine has never crashed since. Would you be
interested in some help in trying to set it up ? Assuming that epoll
is available, I have absolutely no worries about the load. As an added
benefit, it could also provide HA and LB but I understand it's not the
main concern right now.

Willy

