Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261770AbTILRKM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 13:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261772AbTILRKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 13:10:12 -0400
Received: from [139.30.44.2] ([139.30.44.2]:57308 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S261770AbTILRKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 13:10:07 -0400
Date: Fri, 12 Sep 2003 19:10:01 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Tabris <tabris@tabris.net>
cc: lkml <linux-kernel@vger.kernel.org>, <bero@arklinux.org>,
       <saint@arklinux.org>, Alan Cox <alan@redhat.com>
Subject: Re: Jiffies_64 for 2.4.22-ac
In-Reply-To: <200309121200.55038.tabris@tabris.net>
Message-ID: <Pine.LNX.4.33.0309121903150.23028-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Sep 2003, Tabris wrote:

> this one is changed as per my current running kernel, and compile tested.
> sorry about the last one... -ENOCAFFEINE

still one knit:

>  #if HZ!=100
>         len = sprintf(page,"%lu.%02lu %lu.%02lu\n",
> -               uptime / HZ,
> -               (((uptime % HZ) * 100) / HZ) % 100,
> -               idle / HZ,
> -               (((idle % HZ) * 100) / HZ) % 100);
> +               (unsigned long) uptime,
> +               (uptime_remainder * 100) / HZ,
> +               (unsigned long) idle / HZ,
> +               (idle_remainder * 100) / HZ);

the last lines should read

+               (unsigned long) idle,
+               (idle_remainder * 100) / HZ);

since idle already got divided by HZ a couple of lines earlier.


Btw., the common convention used by kernel hackers is that you can do

  > cd linux-2.4.22-ac1
  > patch -p1 < ../whatever.patch

while with your patches one has to use -p2.

Tim

