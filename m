Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132021AbRASAiB>; Thu, 18 Jan 2001 19:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135463AbRASAhv>; Thu, 18 Jan 2001 19:37:51 -0500
Received: from felix.convergence.de ([212.84.236.131]:58637 "EHLO
	convergence.de") by vger.kernel.org with ESMTP id <S132021AbRASAhi>;
	Thu, 18 Jan 2001 19:37:38 -0500
Date: Fri, 19 Jan 2001 01:36:49 +0100
From: Felix von Leitner <leitner@convergence.de>
To: linux-kernel@vger.kernel.org
Subject: Off-Topic: how do I trace a PID over double-forks?
Message-ID: <20010119013649.A30163@convergence.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is more a Unix API question than a Linux question.

I hope the issue is interesting enough to be of interest to some of you.

Basically, I am writing an init which features process watching
capabilities.  My init has a management channel with which you can tell
it "the PID of the ssh process is really 123 instead of 12".

When init forks a getty and that getty exits, it is restarted.  So far
so good.  But I want my init to be able to restart uncooperative
processes like sendmail that fork in the background.  sendmail may be a
bad example because the sources are available, but please imagine you
didn't have the sources to sendmail or didn't want to touch them.

Now, the back channel for my init has a function that allows to set the
PID of a process.  The idea is that the init does not start sendmail but
a wrapper.  The wrapper forks, runs sendmail, does some magic trickery
to find the real PID of the daemonized sendmail and tells init this PID
so init will know it has to restart sendmail when it exits and won't
restart the wrapper when that exits.

Follow me this far?  Great!  The real problem at hand is: what kind of
trickery can I employ in that wrapper.  I was hoping for something that
is not Linux specific, but I haven't found anything yet.  I was also
hoping that I could find a method that does not rely on /proc being
there or on any filesystem being mounted read-write (yes, my back
channel works if the filesystem is mounted read-only).  So, using
/proc and relying on something like /var/run/sendmail.pid are out.

Someone suggested using fcntl to create a lock and then use fcntl again
to see who holds the lock.  That sounded good at first, but fork() does
not seem to inherit locks.  Does anyone have another idea?

In case I made you wonder: http://www.fefe.de/minit/

Felix
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
