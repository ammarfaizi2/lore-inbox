Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263737AbTHWREi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 13:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263443AbTHWRBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 13:01:33 -0400
Received: from mail.north-cyprus.net ([212.175.247.6]:43732 "EHLO
	mail.north-cyprus.net") by vger.kernel.org with ESMTP
	id S262936AbTHWQnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 12:43:15 -0400
Date: Sat, 23 Aug 2003 19:47:42 +0300
From: Mehmet Ali Suzen <msuzen@mail.north-cyprus.net>
To: Dan Kegel <dank@kegel.com>, linux-kernel@vger.kernel.org
Subject: Re: Running SMP 2.4.21 #2 SMP Kernel on single processor : Memory Leakage?
Message-ID: <20030823194742.A15662@mail.north-cyprus.net>
References: <3F46511D.9080108@kegel.com> <20030823152455.A1771@mail.north-cyprus.net> <3F4798B5.7040109@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3F4798B5.7040109@kegel.com>; from dank@kegel.com on Sat, Aug 23, 2003 at 09:39:17AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 23, 2003 at 09:39:17AM -0700, Dan Kegel wrote:
> > it was a compiled kernel.
> 
> Ah, if you were running a kernel.org kernel, apologies.

No need. And we didn't want to apply rc in the production.

> I haven't seen the problem you describe, so I'm shooting in
> the dark, but:
> 
> How long does the problem take to occur after boot?

Actually machine was up about 2 weeks for testing. After 
we got to production. It gets mad.

> What kind of load are you putting on the system?

Radiusd, mysqld, named and httpd are the most active processes.

> Have you checked the output of ps and /proc/slabinfo to
> look for obvious bloats?

Nothing in the process table generates expanding memory.
2-3 hours ago problem suddenly smears out. 

We suspect that  commenting in named.conf log options and reload rncd
has solved the problem. Which is bizzare, because we have already
tried without named.

Mehmet

PS: from named.conf
logging {
 //channel syslog_errors {
 // Syslog logging: typically daemon, if we choose local1,
 // some message still go to daemon (bug), so we leave daemon for now .
 // syslog daemon;
 //syslog local1; severity info;
 //};
 //category default {
 //     syslog_errors; // you can log to as many channels
 //      default_syslog; // by default goes to daemon in syslog
 //};
 // ignore all "lame server" errors (only do this if none of the lame
 // servers belong to you; otherwise, fix them)

 category lame-servers{ null; };
 //category statistics { null; }; // We don't need stats for this server

 // enable for testing/debugging:
 //category default { file_log; syslog_errors; };
 //category panic { file_log; };
 //category packet { file_log; };
 //category eventlib { file_log; };
 //other categories; queries, cname, config, load, notify, parser,
 //response-checks, security, statistics, update, xfer-in, xfer-out
};


