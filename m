Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbVA2QnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbVA2QnU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 11:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbVA2QnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 11:43:20 -0500
Received: from canuck.infradead.org ([205.233.218.70]:8457 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261232AbVA2Qmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 11:42:42 -0500
Subject: Re: Patch 4/6  randomize the stack pointer
From: Arjan van de Ven <arjan@infradead.org>
To: John Richard Moser <nigelenki@comcast.net>
Cc: Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-Reply-To: <41FBB821.3000403@comcast.net>
References: <20050127101117.GA9760@infradead.org>
	 <20050127101322.GE9760@infradead.org>  <41F92721.1030903@comcast.net>
	 <1106848051.5624.110.camel@laptopd505.fenrus.org>
	 <41F92D2B.4090302@comcast.net>
	 <Pine.LNX.4.58.0501271010130.2362@ppc970.osdl.org>
	 <41F95F79.6080904@comcast.net>
	 <1106862801.5624.145.camel@laptopd505.fenrus.org>
	 <41F96C7D.9000506@comcast.net>
	 <Pine.LNX.4.61.0501282147090.19494@chimarrao.boston.redhat.com>
	 <41FB2DD2.1070405@comcast.net>
	 <1106986224.4174.65.camel@laptopd505.fenrus.org>
	 <41FBB821.3000403@comcast.net>
Content-Type: text/plain
Date: Sat, 29 Jan 2005 17:42:35 +0100
Message-Id: <1107016955.4174.127.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-01-29 at 11:21 -0500, John Richard Moser wrote:
> -----BEGIN PGP SIGNED MESSAGE-----

> These are the only places mprotect() is mentioned; a visual scan
> confirms no trickery:
> 
>         if( fork() == 0 ) {
>                 /* Perform a dirty (but not unrealistic) trick to circumvent
>                  * the kernel protection.
>                  */
>                 if( paxtest_mode == 1 ) {
>                         pthread_t thread;
>                         pthread_create(&thread, NULL, test_thread, dummy);
>                         doit();
>                         pthread_kill(thread, SIGTERM);
>                 } else {

> So, there you have it.  These tests do not intentionally kill
> exec-shield based on its known issue with tracking the upper limit of
> the code segment.


here they do.
dummy is a local NESTED function, which causes the stack to *correctly*
be marked executable, due to the need of trampolines. 
That disables execshield for any tests that use dummy.o, which most of
them are.

