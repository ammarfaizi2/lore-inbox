Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280622AbRKFWWi>; Tue, 6 Nov 2001 17:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280628AbRKFWW3>; Tue, 6 Nov 2001 17:22:29 -0500
Received: from codepoet.org ([166.70.14.212]:60970 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S280622AbRKFWWP>;
	Tue, 6 Nov 2001 17:22:15 -0500
Date: Tue, 6 Nov 2001 15:22:15 -0700
From: Erik Andersen <andersen@codepoet.org>
To: dank@trellisinc.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Message-ID: <20011106152215.A31923@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	dank@trellisinc.com, linux-kernel@vger.kernel.org
In-Reply-To: <20011105155955.A16505@codepoet.org> <20011106194923.D6AB1A3C19@fancypants.trellisinc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011106194923.D6AB1A3C19@fancypants.trellisinc.com>
User-Agent: Mutt/1.3.22i
X-Operating-System: 2.4.12-ac3-rmk2, Rebel NetWinder (Intel StrongARM-110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Nov 06, 2001 at 02:49:23PM -0500, dank@trellisinc.com wrote:
> In article <20011105155955.A16505@codepoet.org> Erik Anderson wrote:
> > Come now, it really isn't that difficult: 
> 
> >    char name[80];
> >    if (sscanf(line, "%4u %4u %llu %s", &major, &minor, &size, name) == 4)
> 
> if it's so easy to do, why do you have a great big buffer overflow here?


Sorry, no doughnut for you.  drivers/block/genhd.c:

    #ifdef CONFIG_PROC_FS
    int get_partition_list(char *page, char **start, off_t offset, int count)
    {
	...
	char buf[64];

	...

	len += snprintf(page + len, 63, "%4d  %4d %10d %s\n", gp->major, n, 
		gp->sizes[n], disk_name(gp, n, buf));

so each /proc/partitions line maxes out at 63 bytes.  So not only
is there no overflow, I am providing 16 extra bytes of padding.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
