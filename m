Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750974AbWCNOfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbWCNOfi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 09:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751010AbWCNOfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 09:35:38 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:5837 "EHLO
	pd5mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1750943AbWCNOfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 09:35:38 -0500
Date: Tue, 14 Mar 2006 08:35:15 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: procfs uglyness caused by "cat"
In-reply-to: <5Qfgo-3At-15@gated-at.bofh.it>
To: Herbert Rosmanith <kernel@wildsau.enemy.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <4416D4A3.9070705@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <5Qfgo-3At-15@gated-at.bofh.it>
User-Agent: Thunderbird 1.5 (Windows/20051201)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Rosmanith wrote:
> a simple way to get rid of this:
> 
> static int uptime_read_proc(char *page, char **start, off_t off,
>                                  int count, int *eof, void *data)
> {
>         struct timespec uptime;
>         struct timespec idle;
>         int len;
>         cputime_t idletime;
> 
> +	if (off)
> +		return 0;

Except that this is wrong - if you try to advance the offset a bit from 
the start of the file and read something, you'll get nothing. This is 
inconsistent with normal file behavior.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

