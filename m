Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264419AbUGAK5v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264419AbUGAK5v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 06:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264443AbUGAK5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 06:57:50 -0400
Received: from chaos.analogic.com ([204.178.40.224]:40589 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264419AbUGAK5t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 06:57:49 -0400
Date: Thu, 1 Jul 2004 06:57:33 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: michael trimarchi <trimarchi@gandalf.sssup.it>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Real time 
In-Reply-To: <40E3C9AF.4000306@gandalf.sssup.it>
Message-ID: <Pine.LNX.4.53.0407010650240.13048@chaos>
References: <40E3C9AF.4000306@gandalf.sssup.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jul 2004, michael trimarchi wrote:

> Hi,
> I'm working on porting modular real time scheduler on linux layer ...
> I'm using only kernel thread... Actually I dont't call the
> kernel_thread(init, .... and I inizialize my scheduler and OS struct...
> I schedule my kernel thread... I'm trying to use the printk in the
> kernel_thread but sometimes I dont't having result on the console. The
> console does't print my debug on screen... Is there an unburred printk?
>
> Best regards
> Michael Trimarchi
>

You probably need to set up your kernel thread correctly. You should
use:
	kernel_thread(your_thread, NULL, CLONE_FS|CLONE_FILES);

your_thread(void *whatever)
{
    exit_files(current);
    daemonize();
    /.../ fix up signals, etc.
}

Without CLONE_FILES, the file-descriptors and handles ultimately
used for printk() may not work.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


