Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268620AbTGNJdq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 05:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268640AbTGNJdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 05:33:46 -0400
Received: from mta06-svc.ntlworld.com ([62.253.162.46]:37518 "EHLO
	mta06-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S268620AbTGNJdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 05:33:45 -0400
Date: Mon, 14 Jul 2003 10:48:32 +0100 (BST)
From: Ben <linux-kernel-2311@slimyhorror.com>
X-X-Sender: ben@baphomet.bogo.bogus
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5 kernel regression in alarm() syscall behaviour?
Message-ID: <Pine.LNX.4.56.0307141040020.8394@baphomet.bogo.bogus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think I'm hitting a similar problem to the one Paul describes. We have
code in our test framework that does:

alarm(1)
do some test that should complete almost immediately (i.e. not block)
a = alarm(0)
check that a == 1

On Linux 2.0, 2.2, 2.4, and a whole range of Unix-alikes, a = 1. On Linux
2.5.75-mm1, a=2. This does suggest that the behaviour of 2.5 is wrong...

Minimal test program:


#include <unistd.h>
#include <stdio.h>

int main( int argc, char **argv )
{
   int left;
   alarm( 1 );
   left = alarm( 0 );
   printf( "%d\n", left );
   return 0;
}


Regards,
Ben
