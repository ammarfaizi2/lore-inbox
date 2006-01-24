Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964921AbWAXOjQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964921AbWAXOjQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 09:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964966AbWAXOjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 09:39:15 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:23680 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S964921AbWAXOjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 09:39:15 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Tue, 24 Jan 2006 15:38:16 +0100
To: schilling@fokus.fraunhofer.de, rlrevell@joe-job.com,
       matthias.andree@gmx.de, linux-kernel@vger.kernel.org, 7eggert@gmx.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest) (was:   
 Rationale for RLIMIT_MEMLOCK?)
Message-ID: <43D63BD8.nailCPI11XBZ8@burner>
References: <5y7B5-1dw-15@gated-at.bofh.it>
 <5y7KL-1DZ-31@gated-at.bofh.it> <5yddh-1pA-47@gated-at.bofh.it>
 <5ydni-1Qq-3@gated-at.bofh.it> <5yek1-3iP-53@gated-at.bofh.it>
 <5yeth-3us-33@gated-at.bofh.it> <5yf5O-4iF-19@gated-at.bofh.it>
 <5yfI4-5kU-11@gated-at.bofh.it> <5ygE4-6LK-35@gated-at.bofh.it>
 <5yhqg-7ZR-5@gated-at.bofh.it> <5yi2X-zm-7@gated-at.bofh.it>
 <E1F1KG8-0000v7-3Q@be1.lrz>
In-Reply-To: <E1F1KG8-0000v7-3Q@be1.lrz>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org> wrote:

> Joerg Schilling <schilling@fokus.fraunhofer.de> wrote:
>
> [...]
> > On Solaris, you (currently) use a profile enabled shell (pfsh, pfksh or pfcsh)
> > that calls getexecuser() in order to find whether there is a specific
> > treatment needed. If this specific treatment is needed, then the shell calls
> > execve(/usr/bin/pfexec cmd <args>)
> > else it calls  execve(cmd <args>)
> > 
> > I did recently voted to require all shells to be profile enabled by default.
>
> Why? I asume there will only be few programs requiring to be run by a
> wrapper, and mv /usr/bin/foo to /usr/pfexec-bin/foo;
> echo $'#!/bin/sh\n/usr/sbin/pfexec /usr/pfexec-bin/foo "$@"' > /usr/bin/foo;
> chmod 755 /usr/bin/foo
> should be easier than patching e.g. all callers of cdrecord, and it won't
> slow down starting non-profiled applications.

Because the architecture review commitee decided this would be the right way.

Note that we are on a migration from the classical root/non-root UNIX to a fine 
grained privileges handling. The current documentation says that you need to 
have a profile enabled shell as your SHELL in order to be able to use a 
root-less Solaris.

> Possibly the pfexec can tell the application to be run by the basename (like
> su1), in this case you'd add something like
> "alias cdrecord /opt/schily/bin/cdrecord" to it's configuration and link it
> to /usr/bin/cdrecord.

But you are right that another way would be to use something like "isaexec"

> > The final priv would allow even vendor specific commands: this is what
> > cdrecord needs.
>
> That sounds reasonable, but I wonder how you can get access to a device
> file descriptor in order to do unprivileged access.

This is something that needs to be discussed. Last night, I found that there 
should be a way to run cdrecord without the need to have the "file_dac_read"
provilege. I'll discuss this with the security group.



Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
