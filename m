Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263983AbTLXWe3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 17:34:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263985AbTLXWe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 17:34:29 -0500
Received: from c211-28-147-198.thoms1.vic.optusnet.com.au ([211.28.147.198]:39901
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S263983AbTLXWe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 17:34:27 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Gergely Tamas <dice@mfa.kfki.hu>, Keith Lea <keith@cs.oswego.edu>
Subject: Re: 2.6.0-test11 data loss
Date: Thu, 25 Dec 2003 09:34:17 +1100
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <3FEA0C3C.9090601@cs.oswego.edu> <20031224222217.GA3408@mfa.kfki.hu>
In-Reply-To: <20031224222217.GA3408@mfa.kfki.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312250934.17913.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On Thu, 25 Dec 2003 09:22, Gergely Tamas wrote:
> I've been hit by the same problem but using 2.6.0 . As you described,
> garbage in files (eg. /etc/modules.conf, ...).
>
> 2.6.0, Slackware 9.1
>
>  > The corruption happened on two separate partitions on a single IDE
>  > laptop drive, and both were ReiserFS 3.6 partitions. I don't know if
>  > this is a kernel bug or a Reiser bug or something else, but I thought
>
> I don't think this is a reiserfs bug. This was my first thought and
> after first hitting this bug, I've moved all my partitions from reiserfs
> to jfs. But I've also had this problem with it... Now I'm back to
> 2.4.23, and everything works fine.

Because of the numerous reboots and hangs I've seen with experimental patches 
I've also seen this, but it's not reiserFS fault. The problem is that most 
drives have write caching enabled and not all of them are safe with this. If 
you disable it with hdparm (hdparm -W 0 /dev/hd*) you'll find that open files 
during a hard reset or power outage will prevent those open files from being 
corrupted.

Con

