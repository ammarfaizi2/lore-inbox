Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932267AbWA3NbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbWA3NbN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 08:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbWA3NbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 08:31:13 -0500
Received: from nutty.inf.ed.ac.uk ([129.215.216.3]:44987 "EHLO
	nutty.inf.ed.ac.uk") by vger.kernel.org with ESMTP id S932267AbWA3NbM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 08:31:12 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17374.5399.546606.933186@palau.inf.ed.ac.uk>
Date: Mon, 30 Jan 2006 13:31:03 +0000
From: Julian Bradfield <jcb@inf.ed.ac.uk>
To: linux-kernel@vger.kernel.org
cc: od@suse.de, lhofhansl@yahoo.com
Subject: TIOCCONS security revisited
X-Mailer: VM 7.18 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In August 2004, Olaf Dabrunz posted a patch, which appears to have got
into 2.6.10, restricting TIOC_CONS to CAP_SYS_ADMIN .

He justified this by claiming that normal users don't need to grab the
console output.

I disagree. Normal users log into the desktop of their machine, and
should expect to be able to see the console output just as much as if
they logged into "the console" and worked without graphics.
For example, I want to know when the machine I'm working on has
problems, when somebody is probing sshd, and simply when one of my
batch jobs wants to tell me something.

Further, on our systems, I own the console (ownership is transferred
to the user by the login procedure), so it's daft that I can't call TIOCCONS
on it.

I propose that a better security test would be:
user owns /dev/console OR has CAP_SYS_ADMIN .

It should then be the responsibility of the log-out procedure to
cancel redirections when it changes the ownership of devices back to
root.

In December '04, Lars posted about this breakage, and proposed a
simpler patch, allowing general TIOCCONS but restricting cancellation
(as per documentation), but I didn't see anything happen to this.

Any comments? If none, I'll propose a patch.
