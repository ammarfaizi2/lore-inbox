Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbTKYACq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 19:02:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbTKYAB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 19:01:58 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:3334 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261807AbTKYABI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 19:01:08 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: hard links create local DoS vulnerability and security problems
Date: 24 Nov 2003 23:50:12 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bpu5fk$vsn$1@gatekeeper.tmr.com>
References: <200311241736.23824.jlell@JakobLell.de>
X-Trace: gatekeeper.tmr.com 1069717812 32663 192.168.12.62 (24 Nov 2003 23:50:12 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200311241736.23824.jlell@JakobLell.de>,
Jakob Lell  <jlell@JakobLell.de> wrote:

| on Linux it is possible for any user to create a hard link to a file belonging 
| to another user. This hard link continues to exist even if the original file 
| is removed by the owner. However, as the link still belongs to the original 
| owner, it is still counted to his quota. If a malicious user creates hard 
| links for every temp file created by another user, this can make the victim 
| run out of quota (or even fill up the hard disk). This makes a local DoS 
| attack possible.

Of course they must be created in a directory when the evil user has
write, from a directory where the evil user has... have to check if
that's read or just evecute.
| 
| Furthermore, users can even create links to a setuid binary. If there is a 
| security whole like a buffer overflow in any setuid binary, a cracker can 
| create a hard link to this file in his home directory.

Not unless the admin is a total bozo... remember hard links must be in
the same filesystem, and I wouldn't expect untrusted users to have write
in /usr, /var, /lib or /opt, which is where the problem might likely to
exist.

|                                                        This link still exists 
| when the administrator has fixed the security whole by removing or replacing 
| the insecure program. This makes it possible for a cracker to keep a security 
| whole open until an exploit is available. It is even possible to create links 
| to every setuid program on the system. This doesn't create new security 
| wholes but makes it more likely that they are exploited.

See above, this is less likely that you make it sound.
| 
| To solve the problem, the kernel shouldn't allow users to create hard links to 
| files belonging to someone else.

While I think you're overblowing the problem, it is an issue which might
be addressed in SE Linux or somewhere. I have an idea on that, but I
want to look before I suggest anything.
| 
| I could reproduce the problem on linux 2.2.19 and 2.4.21 (and found nothing 
| about it in the changelogs to 2.4.23-rc3).

Bear in mind it isn't a "problem" it's 'expected behaviour" for the o/s,
and might even be mentioned in SuS somehow. Interesting topic, but not a
bug, since the behaviour is as intended.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
