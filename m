Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263376AbTKCUct (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 15:32:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263386AbTKCUct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 15:32:49 -0500
Received: from chaos.analogic.com ([204.178.40.224]:7552 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263376AbTKCUcq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 15:32:46 -0500
Date: Mon, 3 Nov 2003 15:32:56 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Tomas Szepe <szepe@pinerecords.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: how to restart userland?
In-Reply-To: <20031103193940.GA16820@louise.pinerecords.com>
Message-ID: <Pine.LNX.4.53.0311031519050.2654@chaos>
References: <20031103193940.GA16820@louise.pinerecords.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Nov 2003, Tomas Szepe wrote:

> Hi,
>
> Would anyone know of a proven way to completely restart the userland
> of a Linux system?
>
> i.e. something like
> # echo whatever-restart >/proc/wherever
>
> Killing all processes.
> Killing init.
> Unmounting all filesystems.
> VFS: Mounted root (ext2 filesystem).
> INIT: v2.84 booting
> ...
>
> Thanks for any pointers,
> --
> Tomas Szepe <szepe@pinerecords.com>
> -

If you have an 'old' sys-V installation, you as root can execute
`init 0`. Then, after everything has stopped, you can execute
`init 5` or `init 6` to restart to the runlevel you had. More
modern versions from (probably all) distributions won't allow
this. But... you may be able to make a script. The problem is
in fooling init to start all over again. You really need to modify
init (perhaps runlevel 10) to, after everything is unmounted and
all the gettys are killed, do:

	char *argv[3];
        argv[0] ="/sbin/init";
        argv[1] ="auto";
        argv[2] = NULL;
        execve(argv[0], argv, __environ);

That will overlay and restart init from scratch.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


