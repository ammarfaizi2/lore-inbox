Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261158AbVCVMuf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbVCVMuf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 07:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbVCVMuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 07:50:35 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:24300 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S261158AbVCVMu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 07:50:26 -0500
Date: Tue, 22 Mar 2005 07:50:25 -0500
From: Hikaru1@verizon.net
Subject: Re: forkbombing Linux distributions
In-reply-to: <20050322124812.GB18256@roll>
To: linux-kernel@vger.kernel.org
Message-id: <20050322125025.GA9038@roll>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-disposition: inline
References: <e0716e9f05032019064c7b1cec@mail.gmail.com>
 <20050322112628.GA18256@roll>
 <Pine.LNX.4.61.0503221247450.5858@yvahk01.tjqt.qr>
 <20050322124812.GB18256@roll>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2005 at 12:49:58PM +0100, Jan Engelhardt wrote:
> >
> >This will prevent it from exceeding the procs limits, but it will *not*
> >completely stop it.
> 
> What if the few procs that he may spawn also grab so much memory so your 
> machine disappears in swap-t(h)rashing?
While I have figured out how it'd be possible in theory to prevent things
from grabbing so much memory that your computer enters swap death, I haven't
been able to figure out what reasonable defaults would be for myself or
others. Soooo, I suggest everyone who is worried about this check the
manpage for 'limits' which tells you how to do this. My machine runs various
rediculously large and small programs - I'm not sure a forkbomb could be
stopped without hindering the usage of some of the games on my desktop
machine.

On a server or something with multiple users however, I'm sure you could
configure each user independently with resource limits. Most servers
don't have users that play games which take up 90% of the ram. :)

In any case, I was forced by various smarter-than-I people to come up with a
better solution to our problem as they were able to make forkbombs that did
a much better job of driving me crazy. :)

If you edit or create /etc/limits and set as the only line

* U250

It'll do the same thing as the sysctl hack, except root will still be able
to run programs. Programs like ps and kill/killall.

If you've actually implemented the sysctl.conf hack I spoke of previously, I
suggest setting it back to whatever it used to be before, or deleting the
line from /etc/sysctl.conf altogether.

/etc/limits does a better job at stopping forkbombs.
  
This is an example of a program in C my friends gave me that forkbombs.
My previous sysctl.conf hack can't stop this, but the /etc/limits solution
enables the owner of the computer to do something about it as root.

int main() { while(1) { fork(); } }

Hikaru
