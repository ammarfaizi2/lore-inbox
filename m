Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932436AbWAWWEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbWAWWEn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 17:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbWAWWEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 17:04:43 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:60860 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S932436AbWAWWEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 17:04:42 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Mon, 23 Jan 2006 23:03:47 +0100
To: rlrevell@joe-job.com, matthias.andree@gmx.de
Cc: schilling@fokus.fraunhofer.de, linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest) (was: 
 Rationale for RLIMIT_MEMLOCK?)
Message-ID: <43D552C3.nailC8I1YC3VG@burner>
References: <20060123105634.GA17439@merlin.emma.line.org>
 <1138014312.2977.37.camel@laptopd505.fenrus.org>
 <20060123165415.GA32178@merlin.emma.line.org>
 <1138035602.2977.54.camel@laptopd505.fenrus.org>
 <20060123180106.GA4879@merlin.emma.line.org>
 <1138039993.2977.62.camel@laptopd505.fenrus.org>
 <20060123185549.GA15985@merlin.emma.line.org>
 <43D530CC.nailC4Y11KE7A@burner> <1138048255.21481.15.camel@mindpipe>
 <20060123212119.GI1820@merlin.emma.line.org>
In-Reply-To: <20060123212119.GI1820@merlin.emma.line.org>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree <matthias.andree@gmx.de> wrote:

> S2 Jörg is concerned about the SCSI command filter being too
> restrictive. I'm not sure if it still applies to 2.6.16-rc and what the
> exact commands in question were. I'll let Jörg complete this list.

I am tired today and I need to do other work, so let me parly reply:

Iff there is a user space infrastructure for fine grained privileges,
there is absolutely no problem with a planned and well known restriction.

On Solaris, you (currently) use a profile enabled shell (pfsh, pfksh or pfcsh)
that calls getexecuser() in order to find whether there is a specific treatment 
needed. If this specific treatment is needed, then the shell calls 
execve(/usr/bin/pfexec cmd <args>)
else it calls  execve(cmd <args>)

I did recently voted to require all shells to be profile enabled by default.

With the future plans for extending fine grained privs on Solaris, sending
SCSI commands will become more than one priv.

I proposed to have a low priv right to send commands like inquiry and test unit 
ready. These commands may e.g. be send without interfering a concurrent CD/DVD 
write operation.

The next priv could be the permission for sending simple SCSI commands that 
allow reading from the device.

The next priv could be the permission for sending simple SCSI Commands that
allow writing.

The final priv would allow even vendor specific commands: this is what cdrecord 
needs.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
