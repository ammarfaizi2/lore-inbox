Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314961AbSEUPxW>; Tue, 21 May 2002 11:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314987AbSEUPxV>; Tue, 21 May 2002 11:53:21 -0400
Received: from chaos.analogic.com ([204.178.40.224]:12160 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S314961AbSEUPxU>; Tue, 21 May 2002 11:53:20 -0400
Date: Tue, 21 May 2002 11:53:58 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Calin A. Culianu" <calin@ajvar.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Lazy Newbie Question
In-Reply-To: <Pine.LNX.4.33L2.0205211133180.14445-100000@rtlab.med.cornell.edu>
Message-ID: <Pine.LNX.3.95.1020521114635.1232B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 May 2002, Calin A. Culianu wrote:

> 
> Whats the best way to do the equivalent of a stat() on a char * pathname
> from inside a kernel module?  Don't ask why I need to do this.. I know it
> sounds evil but I just need to do it...  Basically I need to find out the
> minor number of a device file.
> 

No. You never "need to do it". Some user-mode task, somewhere, installs
your module. That same task can open your device and via ioctl() tell
it anything it needs to know.

A "file" is something the kernel handles on behalf of a task. That
task has a context which, amongst other things, allows the kernel
to assign file-descriptors. The kernel is not a task. It does not
have a "context". Of course it can create one and it can steal one.
These are the two methods used inside the kernel to handle "files".

And, unless the kernel task "thread" is permanent, it's a dirty
way of corrupting the kernel.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

