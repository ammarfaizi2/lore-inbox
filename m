Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030407AbWAXJHj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030407AbWAXJHj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 04:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030403AbWAXJHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 04:07:39 -0500
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:17305 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S1030399AbWAXJHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 04:07:37 -0500
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest) (was:   Rationale for RLIMIT_MEMLOCK?)
To: Joerg Schilling <schilling@fokus.fraunhofer.de>, rlrevell@joe-job.com,
       matthias.andree@gmx.de, schilling@fokus.fraunhofer.de,
       linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Tue, 24 Jan 2006 10:14:39 +0100
References: <5y7B5-1dw-15@gated-at.bofh.it> <5y7KL-1DZ-31@gated-at.bofh.it> <5yddh-1pA-47@gated-at.bofh.it> <5ydni-1Qq-3@gated-at.bofh.it> <5yek1-3iP-53@gated-at.bofh.it> <5yeth-3us-33@gated-at.bofh.it> <5yf5O-4iF-19@gated-at.bofh.it> <5yfI4-5kU-11@gated-at.bofh.it> <5ygE4-6LK-35@gated-at.bofh.it> <5yhqg-7ZR-5@gated-at.bofh.it> <5yi2X-zm-7@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1F1KG8-0000v7-3Q@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling <schilling@fokus.fraunhofer.de> wrote:

[...]
> On Solaris, you (currently) use a profile enabled shell (pfsh, pfksh or pfcsh)
> that calls getexecuser() in order to find whether there is a specific
> treatment needed. If this specific treatment is needed, then the shell calls
> execve(/usr/bin/pfexec cmd <args>)
> else it calls  execve(cmd <args>)
> 
> I did recently voted to require all shells to be profile enabled by default.

Why? I asume there will only be few programs requiring to be run by a
wrapper, and mv /usr/bin/foo to /usr/pfexec-bin/foo;
echo $'#!/bin/sh\n/usr/sbin/pfexec /usr/pfexec-bin/foo "$@"' > /usr/bin/foo;
chmod 755 /usr/bin/foo
should be easier than patching e.g. all callers of cdrecord, and it won't
slow down starting non-profiled applications.

Possibly the pfexec can tell the application to be run by the basename (like
su1), in this case you'd add something like
"alias cdrecord /opt/schily/bin/cdrecord" to it's configuration and link it
to /usr/bin/cdrecord.

> With the future plans for extending fine grained privs on Solaris, sending
> SCSI commands will become more than one priv.
> 
> I proposed to have a low priv right to send commands like inquiry and test
> unit ready. These commands may e.g. be send without interfering a concurrent
> CD/DVD write operation.
> 
> The next priv could be the permission for sending simple SCSI commands that
> allow reading from the device.
> 
> The next priv could be the permission for sending simple SCSI Commands that
> allow writing.
> 
> The final priv would allow even vendor specific commands: this is what
> cdrecord needs.

That sounds reasonable, but I wonder how you can get access to a device
file descriptor in order to do unprivileged access.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
