Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267515AbRGMRng>; Fri, 13 Jul 2001 13:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267514AbRGMRn1>; Fri, 13 Jul 2001 13:43:27 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:4873 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S267513AbRGMRnP>;
	Fri, 13 Jul 2001 13:43:15 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200107131743.f6DHhGc186373@saturn.cs.uml.edu>
Subject: Re: tty->name conversion?
To: taral@taral.net (Taral)
Date: Fri, 13 Jul 2001 13:43:16 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010705023647.A18014@taral.net> from "Taral" at Jul 05, 2001 02:36:47 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Taral writes:

> I noticed that ps still relies on device numbers to determine tty, since
> /proc/*/stat only exports the device number. Is there any way to get the
> device name? I noticed that it is not present in tty_struct anywhere
> (proc_pid_stat() uses task->tty->device, which is a kdev_t).
>
> This would be useful to consider if we ever intend to create real
> unnumbered character/block devices.

This isn't quite true, at least for the version shipped with Debian.

The non-existant /proc/*/tty link is examined first. This is
because several people have agreed that such a link would be
good, even though it is difficult to implement with the current
code. I think viro, hpa, and tytso have all looked into this.

The ps code also looks at /proc/*/fd/* when possible. This often
gives a real filename. Otherwise, ps has to guess a name based
on the device number and either a hard-coded table or information
from /proc/tty/drivers.
