Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264657AbUDVUgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264657AbUDVUgh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 16:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264665AbUDVUge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 16:36:34 -0400
Received: from chaos.analogic.com ([204.178.40.224]:3712 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264657AbUDVUgb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 16:36:31 -0400
Date: Thu, 22 Apr 2004 16:36:28 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Agri <agri@desnol.ru>
cc: linux-kernel@vger.kernel.org
Subject: Re: BUG: fork do not copy /proc/<PID>/cmdline permissions
In-Reply-To: <20040422215322.19475d98@agri-home>
Message-ID: <Pine.LNX.4.53.0404221628300.940@chaos>
References: <20040422215322.19475d98@agri-home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Apr 2004, Agri wrote:

> I expected from fork to make a rather complete copy of a process,
> but it does not copy /proc/<PID>/cmdline access permissions.
> Therefore, the only way (at least i know) to hide all args of
> processes is to start every program within shell script:
> bash -c 'chmod /proc/$$/cmdline; exec userprogramm ...'
>
> Tested on 2.6.5.
>
> Agri

Huh? /proc/$PID/cmdline doesn't exist until after a task is
created. What you did was create a task, change whatever
is in proc, then exec (which doesn't change the PID).

How would you expect fork() to know that you wanted to
do this? The permissions in /proc are file permissions.
They have nothing to do with a task.

Also, any task can read its own command-line without using
/proc at all.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5557.45 BogoMips).
            Note 96.31% of all statistics are fiction.


