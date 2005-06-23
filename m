Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262526AbVFWIst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262526AbVFWIst (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 04:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262611AbVFWIp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 04:45:58 -0400
Received: from uucp.cistron.nl ([62.216.30.38]:14985 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S262880AbVFWI1w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 04:27:52 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: Writing as init without /dev/console?
Date: Thu, 23 Jun 2005 08:27:50 +0000 (UTC)
Organization: Cistron
Message-ID: <d9drq6$7hf$1@news.cistron.nl>
References: <20050620135132.GB2779@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1119515270 7727 194.109.0.112 (23 Jun 2005 08:27:50 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: mikevs@cistron.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20050620135132.GB2779@schottelius.org>,
Nico Schottelius  <nico-kernel@schottelius.org> wrote:
>Currently I do not open /dev/console in cinit, but currently
>I do see very strange behaviour:
>
>If the first printf() in the following code (from serv/cinit.c) is
>enabled, the socket communication will later fail:

printf() prints to stdout i.e. filedescriptor #1. If you do not
open stdin/stdout/stderr in your program, you do not know what
is going to be fd #1 later on .. in your case, the socket probably
is fd #1 and the printf() is happily printing to it.

To prevent this, do something like this at the start of your program:

	int n;

	do {
		n = open("/dev/null", O_RDWR);
	} while (n >= 0 && n <= 2);
	close(n);

Mike.

