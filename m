Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262653AbVCVL3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262653AbVCVL3l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 06:29:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262654AbVCVL2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 06:28:54 -0500
Received: from vms048pub.verizon.net ([206.46.252.48]:10404 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S262658AbVCVL0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 06:26:30 -0500
Date: Tue, 22 Mar 2005 06:26:28 -0500
From: Hikaru1@verizon.net
Subject: Re: forkbombing Linux distributions
In-reply-to: <e0716e9f05032019064c7b1cec@mail.gmail.com>
To: linux-kernel@vger.kernel.org
Message-id: <20050322112628.GA18256@roll>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-disposition: inline
References: <e0716e9f05032019064c7b1cec@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alright, I noticed this article scared a few of my friends, so I decided to
figure out on my own a way to prevent fork bombing from completely disabling
my machine.

This is only one way to do this, and it's not particularly elegant, but it
gets the job done. If you want something more elegant, try using ulimit or
/etc/limits instead. Me? This is good enough.

Create, or edit the file /etc/sysctl.conf

In the file, find a line or otherwise create one labelled:
kernel.threads-max = 250

Now make sure at startup something runs

sysctl -p

 - on my slackware 10.1 system I had to edit /etc/rc.d/rc.local and add a
line specifically to do this.

Mind that this isn't the best solution. This limits all users, everything to
250 procs, you cannot run more. If your running system or server uses more,
adjust the number accordingly.

An example of an attack this stops in its tracks:
:(){ :|:&};:

(as a command to bash)

Attacks this *limits* and enables the user to do something about:
Create a file, and put in it:

#!/bin/bash
$0 & $0 &

chmod +x it, then run it.

This will prevent it from exceeding the procs limits, but it will *not*
completely stop it. The only way to kill it off successfully is to killall
-9 the script name repeatedly. Note that you'll occasionally be unable to
run killall since the forkbomb will be hitting the limit very often.

Like I said, this is not an elegant solution, however it does increase the
ability of the person owning the machine to do something about it.

Of course, you should always use a bat on the user if nothing else works. ;)

Hikaru
