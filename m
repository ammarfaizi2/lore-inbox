Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261307AbVCINGj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261307AbVCINGj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 08:06:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbVCINGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 08:06:39 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:56592 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S261307AbVCINGf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 08:06:35 -0500
To: linux-kernel@vger.kernel.org
Cc: users@spamassassin.apache.org, misc@list.smarden.org,
       supervision@list.skarnet.org, mkettler@evi-inc.com
Subject: Re: a problem with linux 2.6.11 and sa
References: <20050303214023.GD1251@ixeon.local>
	<6.2.1.2.0.20050303165334.038f32a0@192.168.50.2>
	<20050303224616.GA1428@ixeon.local>
	<871xaqb6o0.fsf@amaterasu.srvr.nix>
	<20050308165814.GA1936@ixeon.local>
From: Nix <nix@esperi.org.uk>
X-Emacs: don't try this at home, kids!
Date: Wed, 09 Mar 2005 13:06:11 +0000
In-Reply-To: <20050308165814.GA1936@ixeon.local> (George Georgalis's message
 of "Tue, 8 Mar 2005 11:58:14 -0500")
Message-ID: <871xap9dfg.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Mar 2005, George Georgalis announced authoritatively:
> Here's what I'm doing that is broken. I use tcpserver (functionally
> similar to inetd) to receive an incoming smtp connection. While the
> smtp session is still open, the message is piped to a temp file which
> is then scanned for spam, if it passes the temp file is piped to my

Both of these sound like redirection, not piping.

>>(I don't see what you mean by `a pipe rom /proc/kmsg', though:
>>pipes connect processes, not files. File redirections are
>>quite different and should work unchanged in 2.6.11.)
> 
> An interesting technique that allows a program (such as a log writer)
> to run as an unprivileged user, while receiving privileged data. (taken
> almost verbatim from Gerrit Pape's socklog)
> 
> #!/bin/sh
> exec </proc/kmsg
> exec 2>&1
> exec softlimit -m 2000000 setuidgid nobody socklog ucspi
> 
> This script, run by root takes its stdin from /proc/kmsg then combines
> its stdout and stderr, and exec-switches to the socklog program run
> as an ucspi application listening to the domain stream socket, as
> nobody:nogroup, with memory consumption limited to 2Mb. (and sends
> log to stdout)

This is definitely redirection, not piping. As far as I know the
implementation of redirection in the kernel remains unchanged: certainly
the need to buffer piped data doesn't exist in this case, and since the
redesign was of the buffering, this is probably not your problem :)

> It worked flawlessly until several kernel revs back when the kernel
> started protecting kmsg and wouldn't allow the user program to receive
> it,

Indeed.

>       result: nothing sent to the logging program and no error. The fix
> was to run socklog as root instead of nobody.

You should be able to open it as root and read from it as another user:
i.e., your technique above shouldn't break. (I'd hope.)

-- 
> ...Hires Root Beer...
What we need these days is a stable, fast, anti-aliased root beer
with dynamic shading. Not that you can let just anybody have root.
 --- John M. Ford
