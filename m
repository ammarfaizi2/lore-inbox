Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264302AbTKMOiT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 09:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264303AbTKMOiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 09:38:19 -0500
Received: from chaos.analogic.com ([204.178.40.224]:131 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264302AbTKMOiR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 09:38:17 -0500
Date: Thu, 13 Nov 2003 09:39:53 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "martin.knoblauch " <"martin.knoblauch "@mscsoftware.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: nfs_statfs: statfs error = 116
In-Reply-To: <3FB391FC.2090406@mscsoftware.com>
Message-ID: <Pine.LNX.4.53.0311130927280.30784@chaos>
References: <3FB391FC.2090406@mscsoftware.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Nov 2003, martin.knoblauch  wrote:

> Hi,
>
>   sorry if OT, but what is above message trying to tell me? Where can I
> find a translation of the numbers? We are seeing 116 very frequently,
> 512 and 5 on occasion.
>

ESTALE is "errno" 116
EIO  is "errno" 5
ERESTARTSYS is "errno" 512

You can find these in /usr/include/asm/errno.h (not good to
directly include in a program).

The program reporting these errors should have included:

<errno.h>
<string.h>

Then used...
	strerror(errno);
or
	perror("");
etc.


Errno 512 should never be seen by user-mode program, so the
header file, /usr/include/linux/errno.h, states...

ESTALE happens when a mounted file-system is on a server that
went down or re-booted. The file-handles are then "stale".

EIO is a general catch-all for an I/O error.

ERESTARTSYS is the error returned by a server that has
re-booted that is supposed to tell the client-side software
to get a new file-handle because of an attempt to access with
a stale file-handle. When getting this error, the client
should have reopened the file(s) to obtain a new handle.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


