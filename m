Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262230AbTHYVUc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 17:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262226AbTHYVUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 17:20:32 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:49421 "HELO
	127.0.0.1") by vger.kernel.org with SMTP id S262230AbTHYVU2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 17:20:28 -0400
Content-Type: text/plain; charset=US-ASCII
From: insecure <insecure@mail.od.ua>
Reply-To: insecure@mail.od.ua
To: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.0-test4
Date: Tue, 26 Aug 2003 00:20:21 +0300
X-Mailer: KMail [version 1.4]
References: <Pine.LNX.4.44.0308221732170.4677-100000@home.osdl.org>
In-Reply-To: <Pine.LNX.4.44.0308221732170.4677-100000@home.osdl.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200308260020.21817.insecure@mail.od.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   o [arcnet com90io] replace check_region with temporary
>     request_region, in probe phase.

check_region() is deprecated because it is racy.
Replacing it with request_region in probe:

int probe() {
	if(!request_region(...))
		return 0;
	/* probe */
	release_region(...);
}

int init() {
	request_region(...);
}

only removes 'deprecated' warning. Race remains.
--
vda
