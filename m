Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131588AbRC0VO5>; Tue, 27 Mar 2001 16:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131578AbRC0VOs>; Tue, 27 Mar 2001 16:14:48 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:11280 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S131589AbRC0VOj>; Tue, 27 Mar 2001 16:14:39 -0500
Date: Tue, 27 Mar 2001 23:13:47 +0200
From: Andreas Rogge <lu01@rogge.yi.org>
To: Andreas Dilger <adilger@turbolinux.com>,
        Martin Dalecki <dalecki@evision-ventures.com>
cc: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Jonathan Morton <chromi@cyberspace.org>,
        Rogier Wolff <R.E.Wolff@bitwizard.nl>, linux-kernel@vger.kernel.org
Subject: Re: OOM killer???
Message-ID: <237970000.985727627@hades>
In-Reply-To: <200103271955.f2RJtoH05928@webber.adilger.int>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Tuesday, March 27, 2001 12:55:50 -0700 Andreas Dilger 
<adilger@turbolinux.com> wrote:

> Every time this subject comes up, I point to AIX and SIGDANGER - a signal
> sent to processes when the system gets OOM.  If the process has registered
> a SIGDANGER handler, it has a chance to free cache and such (or do a clean
> shutdown), otherwise the default signal handler will kill the process.

Having a SIGDANGER would be a fine thing, but this will need patching in all
current daemons and there has to be a possibility to configure the behaviour
of the process when recieving a SIGDANGER. i.e. it is a good idea to kill
apache on a workstation, but a very bad idea to kill apache on a webserver.
Generally I'd like to see such an implementation, but wouldn't it be better
to have a pre-seclction of the processes getting SIGDANGER?

For example: if OOM occours, send SIGDANGER to all non-root-processes with a
nice-level of n or higher (where n should be discussed).

This would make it easy to "configure" SIGDANGER-unaware Applications - in 
the meantime, until all applications are SIGDANGER-aware -  to deal with
OOM-situations. You just do an "nice -n -1 httpd" and one's httpd won't
get killed when OOM occours.

IMO this would dramatically improve the OOM-Problems right now.

--
Andreas Rogge <lu01@rogge.yi.org>
Available on IRCnet:#linux.de as Dyson
