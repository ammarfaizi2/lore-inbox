Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264654AbTBABfz>; Fri, 31 Jan 2003 20:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264657AbTBABfz>; Fri, 31 Jan 2003 20:35:55 -0500
Received: from packet.digeo.com ([12.110.80.53]:42226 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264654AbTBABfy>;
	Fri, 31 Jan 2003 20:35:54 -0500
Date: Fri, 31 Jan 2003 17:45:22 -0800
From: Andrew Morton <akpm@digeo.com>
To: Ed Tomlinson <tomlins@cam.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.59-mm7
Message-Id: <20030131174522.25b5f46c.akpm@digeo.com>
In-Reply-To: <200301312018.02020.tomlins@cam.org>
References: <20030131001733.083f72c5.akpm@digeo.com>
	<200301312018.02020.tomlins@cam.org>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Feb 2003 01:45:14.0662 (UTC) FILETIME=[90CE7460:01C2C993]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Tomlinson <tomlins@cam.org> wrote:
>
> Looks like something got missed...  I get this with mm7
> 
> if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.59-mm7; fi
> WARNING: /lib/modules/2.5.59-mm7/kernel/arch/i386/kernel/apm.ko needs unknown symbol xtime_lock
> 

aww, that's not fair.

xtime_lock was _always_ referenced by apm.c, and never exported to modules.

The only reason it ever worked was that apm does not compile for SMP, and
write/read_lock() are no-ops on uniprocessor.

ho hum, thanks, I shall add the export.


