Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932128AbWCOIJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbWCOIJs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 03:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbWCOIJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 03:09:47 -0500
Received: from wildsau.enemy.org ([193.170.194.34]:60553 "EHLO
	wildsau.enemy.org") by vger.kernel.org with ESMTP id S1751362AbWCOIJr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 03:09:47 -0500
From: Herbert Rosmanith <kernel@wildsau.enemy.org>
Message-Id: <200603150806.k2F86VEf016534@wildsau.enemy.org>
Subject: Re: procfs uglyness caused by "cat"
In-Reply-To: <4416D4A3.9070705@shaw.ca>
To: Robert Hancock <hancockr@shaw.ca>
Date: Wed, 15 Mar 2006 09:06:30 +0100 (MET)
CC: linux-kernel <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > static int uptime_read_proc(char *page, char **start, off_t off,
> >                                  int count, int *eof, void *data)
> > {
> >         struct timespec uptime;
> >         struct timespec idle;
> >         int len;
> >         cputime_t idletime;
> > 
> > +	if (off)
> > +		return 0;
> 
> Except that this is wrong - if you try to advance the offset a bit from 
> the start of the file and read something, you'll get nothing. This is 
> inconsistent with normal file behavior.

so what - "uptime_read_proc" ignores the offset parameter anyway.
you get wrong results right now, too, even without the two lines
I've added.

if you write "Except that this is wrong" you should have in mind that
"this is wrong" currently, too.

just "try to advance the offset a bit from the start of the file and
read something", like "dd if=/proc/uptime bs=1 count=1 seek=1".
do you expect to get right results?

regards,
h.rosmanith


