Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262086AbVDFDOz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262086AbVDFDOz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 23:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262090AbVDFDOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 23:14:55 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:54519 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262086AbVDFDOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 23:14:52 -0400
Date: Tue, 5 Apr 2005 23:21:25 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Prakash Punnoor <prakashp@arcor.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Robert Love <rml@novell.com>
Subject: Re: [patch] inotify for 2.6.11
Message-ID: <20050405232125.A18969@mail.kroptech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4252C8D8.9040109@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been meaning to play with inotify for a while now and finally made
time for it tonight. I'm not much of a GUI guy, so I'm mostly interested
in exploring the command line applications of inotify --i.e., what sort of
havoc can I wreak with it in a script.

To that end I sat down tonight a threw together a simple command line
interface. Before I tell you where the code is, please note that I wrote
it while half asleep and more than a little high on cough syrup, so it's
undoubtedly chock full of buffer overflows, infinite loops, segfaults,
and other gremlins just waiting to eat your data, so PLEASE FOR THE LOVE
OF MIKE don't use it on, around, under, or in the general vicinity of,
anything important.

    http://www.kroptech.com/~adk0212/watchf.c

The basic usage is...

    watchf [-i] [-e<events>] <file-to-watch> [-- <command-to-run>...>]	

        -i says stay in an infinite loop, don't exit after one event
	-e gives the list of events to wait for (see the code)
	<file-to-watch> is the file or directory to be watched
	Everything after -- is taken as a command to run each time an
	event ocurrs with any ocurrences of {} being replaced with the
	name of the affected file, as returned in the inotify_event
	structure.

So what's it good for? Well, besides making fun of my coding skills,
it can be used to watch a directory and run a command when something
changes. For example, a one-line auto-gzip daemon that will haul off and
gzip anything you drop into ./gzipme:

    watchf -i -eWT gzipme -- gzip gzipme/{}

Where to go from here? The code is relatively half-baked at the moment,
but I imgaine this could be turned into a relatively useful generic
tool. For example, it should send the filename to stdout and return the
event mask when in single-shot mode. That would make it useful as part
of a longer pipeline.  You should be able to use it to wait for a specific
file to be created --although that will be interesting if one or more 
segments of the path don't exist yet.  Ultimately I'd like to get rid of
the <command-to-run> argument(s), but I can't think of any way to do it
that isn't going to end up missing events.

--Adam

