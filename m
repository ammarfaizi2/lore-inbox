Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262636AbVENAGz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262636AbVENAGz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 20:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262637AbVENAGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 20:06:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:63205 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262636AbVENAGp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 20:06:45 -0400
Date: Fri, 13 May 2005 20:06:43 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: ritesh@cs.unc.edu
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: NPTL: stack limit limiting number of threads
Message-ID: <20050514000643.GI17420@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <fc67f8b705051312494a0badf7@mail.gmail.com> <20050513202346.GG17420@devserv.devel.redhat.com> <fc67f8b705051317023859c443@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc67f8b705051317023859c443@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2005 at 08:02:48PM -0400, Ritesh Kumar wrote:
>     Thanks for your reply. I actually went ahead after getting your
> mail and coded up a small program to check the stack limit
> deliberately. The program is shown inline.
> 
> #include <stdio.h>
> 
> #define BUF_SIZE 1024000
> 
> void recurse(int n){
> 	char ch[BUF_SIZE];
> 	if(n<=0)
> 		return;
> 	else
> 		recurse(n-1);
> }
> 
> int main(argc, argv)
> 	int argc;
> 	char **argv;
> {
> 	if(argc!=2){
> 		printf("Usage: %s <n (megabytes)>\n", argv[0]);
> 		return 1;
> 	}
> 	printf("Checking for %dMB\n", atoi(argv[1]));
> 	recurse(atoi(argv[1]));
> }
> 
> Its a fairly crude way to find out the actual stack limit. Basically,
> the resurse function recurses each time allocating ~1MB of space on
> the stack. The program segfaults exactly at the ulimit -s value of
> stack size on both linux and freebsd. So it does seem that the ulimit
> -s is the value of stack limit used on FreeBSD.

For the main stack sure.  But now try to call that recurse in
some other thread.

	Jakub
