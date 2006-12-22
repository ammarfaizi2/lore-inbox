Return-Path: <linux-kernel-owner+w=401wt.eu-S1752871AbWLVVbw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752871AbWLVVbw (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 16:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752869AbWLVVbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 16:31:52 -0500
Received: from sccrmhc14.comcast.net ([204.127.200.84]:61616 "EHLO
	sccrmhc14.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752816AbWLVVbv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 16:31:51 -0500
X-Greylist: delayed 470 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Dec 2006 16:31:51 EST
Message-ID: <458C4CEF.3090505@comcast.net>
Date: Fri, 22 Dec 2006 16:23:59 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: evading ulimits
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've set up some stuff on my box where /etc/security/limits.conf
contains the following:

@users          soft    nproc           3072
@users          hard    nproc           4096

I'm in group users, and a simple fork bomb is easily quashed by this:

bluefox@icebox:~$ :(){ :|:; };:
bash: fork: Resource temporarily unavailable
Terminated

Oddly enough, trying this again and again yields the same results; but,
I can kill the box (eventually; about 1 minute in I managed to `/exec
killall -9 bash` from x-chat, since I couldn't get a new shell open)
with the below:

bluefox@icebox:~$ :(){ :|:|:; };:

How exactly does the ulimit work?  Why do I seem to be able to evade
limits on maximum number of processes by doing a bigger fork bomb?  I
would have thought that the above would have terminated much sooner,
since it was spawning x^3 processes instead of x^2 for iteration x and
should have hit 4096 a lot sooner.


-- 
    We will enslave their women, eat their children and rape their
    cattle!
             -- Bosc, Evil alien overlord from the fifth dimension
Anti-Spam:  https://bugzilla.mozilla.org/show_bug.cgi?id=229686
