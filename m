Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264113AbUDBRBz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 12:01:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264111AbUDBRBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 12:01:54 -0500
Received: from chaos.analogic.com ([204.178.40.224]:1927 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264113AbUDBRBo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 12:01:44 -0500
Date: Fri, 2 Apr 2004 12:04:00 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Ron Gage <ron@rongage.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Correction: 2.4 - can't open a custom char device file
In-Reply-To: <1080923435.406d952b2e786@webmail.rongage.org>
Message-ID: <Pine.LNX.4.53.0404021203290.32287@chaos>
References: <1080923435.406d952b2e786@webmail.rongage.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Apr 2004, Ron Gage wrote:

> Previous message had the link wrong - sorry about that.
>
> Try this: ftp://ftp.rongage.org/pub/pcmk/pcmk-v0.0.0.tar.gz
>
> --
> Ronald R. Gage
> MCP, LPIC1, A+, Net+
> Pontiac, Michigan


struct file_operations pcmk_fops requires the owner
initializer, i.e., THIS_MODULE.

At line 784, where do you get your open()? From the
'C' runtime library in user-space?

At line 791, where do you get your read() function?
>From the 'C' runtime library in user-space?

At line 802, where do you get your close() function?
Ditto.

The correct way to put the contents of files into
your driver is with a ioctl() control function that
gets data from user-space files and puts it into
the proper place(s) in your driver.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


