Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932143AbVJYNoT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbVJYNoT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 09:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbVJYNoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 09:44:19 -0400
Received: from [67.130.105.243] ([67.130.105.243]:1580 "EHLO irobot.com")
	by vger.kernel.org with ESMTP id S932143AbVJYNoS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 09:44:18 -0400
From: Brian Waite <linwoes@gmail.com>
To: chaosite@gmail.com
Subject: Re: /proc/kcore size incorrect ?
Date: Tue, 25 Oct 2005 09:37:12 -0400
User-Agent: KMail/1.8.2
Cc: "J.A. Magallon" <jamagallon@able.es>, jonathan@jonmasters.org,
       jonmasters@gmail.com, "Linux-Kernel," <linux-kernel@vger.kernel.org>
References: <20051023235806.1a4df9ab@werewolf.able.es> <20051024015710.29a02e63@werewolf.able.es> <435E1F36.2030108@gmail.com>
In-Reply-To: <435E1F36.2030108@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510250937.13383.linwoes@gmail.com>
X-OriginalArrivalTime: 25 Oct 2005 13:44:17.0940 (UTC) FILETIME=[320CFD40:01C5D96A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 25 October 2005 8:04 am, Matan Peled wrote:
> J.A. Magallon wrote:
> > I expected /proc/kcore to give the size of your installed memory, with
> > the reserved BIOS areas just not accesible, but it looks like it already
> > has them discounted, so gives 1022 Mb.
> >
> > It looks really silly to have a motd say "wellcome to this box, it has
> > 2 xeons and 1022 Mb of RAM".
>
> I don't know why, but 'du' seems to be doing a better job.
>
> chaosite@kaitou ~ $ du /proc/kcore --block-size=1M
> 1024	/proc/kcore
> chaosite@kaitou ~ $ echo $(($(stat -c %s /proc/kcore) / 1024 / 1024))
> 1023
To show just how fragile your tests are, here is what my laptop reports with 1 
GB memory:

bwaite@ronzoni:~> uname -a
Linux ronzoni 2.6.11.4-21.9-default #1 Fri Aug 19 11:58:59 UTC 2005 i686 i686 
i386 GNU/Linux
bwaite@ronzoni:~> du /proc/kcore --block-size=1M
897     /proc/kcore

bwaite@ronzoni:~> echo $(($(stat -c %s /proc/kcore) / 1024 / 1024))
896

bwaite@ronzoni:~> dmesg | grep MEM
127MB HIGHMEM available.
896MB LOWMEM available.

bwaite@ronzoni:~> dmesg | grep Memory:
Memory: 1033684k/1048248k available (1866k kernel code, 13796k reserved, 658k 
data, 204k init, 130744k highmem)

In short why not use free and show what your users can use. Otherwise, just 
make a static motd and change it whenever you change memory configurations. I 
can't believe you are changing that often. If you are going to go overboard 
and write a script just start doing the round up on your own.

Thanks
Brian

