Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932180AbWDUAkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbWDUAkn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 20:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932181AbWDUAkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 20:40:43 -0400
Received: from stinky.trash.net ([213.144.137.162]:13259 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S932180AbWDUAkm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 20:40:42 -0400
Message-ID: <44482963.4030902@trash.net>
Date: Fri, 21 Apr 2006 02:37:55 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mikado4vn@gmail.com
CC: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Which process is associated with process ID 0 (swapper)
References: <4447A19E.9000008@gmail.com> <Pine.LNX.4.61.0604201118200.5749@chaos.analogic.com> <4447B110.4080700@gmail.com> <Pine.LNX.4.61.0604210007140.28841@yvahk01.tjqt.qr> <44481ACE.9040104@gmail.com>
In-Reply-To: <44481ACE.9040104@gmail.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikado wrote:
> Jan Engelhardt wrote:
> 
>>>Is your code doing it like ipt_owner does?
> 
> 
> It seems that ipt_owner does _not_ support PID match anymore:

Yes, it was removed for two reasons:

- it used tasklist_lock from bh-context, resulting in deadlocks
- there is no 1:1 mapping between sockets (or packets) and
  processes. If you use corking even a single packet can be
  created in cooperation by multiple processes.

