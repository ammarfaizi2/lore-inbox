Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262591AbTKIQJs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 11:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbTKIQJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 11:09:48 -0500
Received: from cm6.gamma186.maxonline.com.sg ([202.156.186.6]:4224 "EHLO
	plethora.anomalistic.org") by vger.kernel.org with ESMTP
	id S262591AbTKIQJq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 11:09:46 -0500
Date: Mon, 10 Nov 2003 00:09:45 +0800
From: Eugene Teo <eugene.teo@eugeneteo.net>
To: Amir Hermelin <amir@montilio.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 'flushing' printk to klogd
Message-ID: <20031109160945.GA491@despammed.com>
Reply-To: Eugene Teo <eugeneteo@despammed.com>
References: <001e01c3a6cf$b13a3990$0a01a8c0@CARTMAN>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001e01c3a6cf$b13a3990$0a01a8c0@CARTMAN>
X-Operating-System: Linux 2.4.22
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can configure your syslog to output the messages to
a dedicated file. Also, you can increase the length
of your buffer:

352  #define LOG_BUF_LEN    (131072)
353  #elif defined(CONFIG_SMP)
354  #define LOG_BUF_LEN    (32768)
355 +#elif defined(CONFIG_VMSTAT_PFAULTS)
356 +#define LOG_BUF_LEN (1048576)
357  #else  
358  #define LOG_BUF_LEN    (16384) /* This must be a power of two */
359  #endif

Note that even if you flush printk output before the circular
buffer wraps, you will still likely to lose some output since
it doesn't take care of multiple writes at the same time.

Eugene

<quote sender="Amir Hermelin">
> Hi,
> Is there any way to make sure klogd flushes printk output to
> /var/log/messages before the circular buffer wraps?  I intend to use this
> only during the development phase, but I find that during 'activity storms'
> where lots of printk's are involved I lose some of the output.
> 
> Thanks,
> Amir.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

