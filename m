Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270255AbTGRQ7N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 12:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270262AbTGRQ7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 12:59:13 -0400
Received: from code.and.org ([63.113.167.33]:51397 "EHLO mail.and.org")
	by vger.kernel.org with ESMTP id S270255AbTGRQ7E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 12:59:04 -0400
To: malware@t-online.de (Michael Mueller)
Cc: linux-kernel@vger.kernel.org, glibc-sc@gnu.org
Subject: Re: [2.4] Inconsistency in poll(2)
References: <200307161032.MAA09922@fire.malware.de>
From: James Antill <james@and.org>
Content-Type: text/plain; charset=US-ASCII
Date: 18 Jul 2003 13:13:56 -0400
In-Reply-To: <200307161032.MAA09922@fire.malware.de>
Message-ID: <m3fzl3pxkb.fsf@code.and.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

malware@t-online.de (Michael Mueller) writes:

> Hi readers of linux-kernel and glibc maintainers,
> 
> while hacking on a network application I found following oddity:
> 
> poll(pds,nfds,timeout) called with one of the file descriptors listed in
> pds being invalid always does return nfds.

[snip .. ]

> Simple sample code demonstrating the problem:

 When writing code, always compile with at least -Wall -W
> 
> #include <stdio.h>
> #include <sys/poll.h>
> 
> struct pollfd fds[] = {
>  { 0, POLLIN, 0 },
>  { 110, POLLIN, 0}
> };
> 
> int main(void)
> {
> 	int r = poll(fds, sizeof fds / sizeof fds[0], -1);
> 	if ( r < 0 )
> 		perror("poll");
> 	else
> 		printf("poll returned %d\n");
 		printf("poll returned %d\n", r);

 Is probably what you want.

> 
> 	for ( r=0; r < sizeof fds / sizeof fds[0]; r++ )
> 		printf("revent[%d]: %hd\n", r, fds[r].revents);
> 
> 	return 0;
> }

-- 
James Antill -- james@and.org
Need an efficent and powerful string library for C?
http://www.and.org/vstr/
