Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263607AbTCUMYw>; Fri, 21 Mar 2003 07:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263606AbTCUMYw>; Fri, 21 Mar 2003 07:24:52 -0500
Received: from mail.webmaster.com ([216.152.64.131]:27068 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S263605AbTCUMYv> convert rfc822-to-8bit; Fri, 21 Mar 2003 07:24:51 -0500
From: David Schwartz <davids@webmaster.com>
To: <ifilipau@sussdd.de>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.63 (1077) - Licensed Version
Date: Fri, 21 Mar 2003 04:35:50 -0800
In-Reply-To: <7A5D4FEED80CD61192F2001083FC1CF9065139@CHARLY>
Subject: Re: read() & close()
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Illegal-Object: Syntax error in Message-ID: value found on vger.kernel.org:
	Message-ID:	<20030321123536.AAA18341@shell.webmaster.com@whenever>
									    ^-illegal end of message identification
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Message-Id: <20030321122452Z263606-25575+33907@vger.kernel.org>

On Thu, 20 Mar 2003 15:14:52 +0100, Filipau, Ihar wrote:

>I have/had a simple issue with multi-threaded programs:
>
>one thread is doing blocking read(fd) or poll({fd}) on
>file/socket.
>
>another thread is doing close(fd).
>
>I expected first thread will unblock with some kind
>of error - but nope! It is blocked!
>
>Is it expected behaviour?

	It is impossible to make this work reliably, so *please* don't do 
that. For example, how can you possibly assure that the first thread 
is actually in 'poll' when call 'close'? There is no atomic 'release 
mutex and poll' function.

	So what happens if the system pre-empts the thread right before it 
calls 'poll'. Then you call 'close'. Perhaps next a thread started by 
some library function calls 'socket' and gets the file descriptor you 
just 'close'd. Now your call to 'poll' polls on the *wrong* socket!

	You simply must accept the fact that you cannot free a resource in 
one thread while another thread is or might be using it.

	DS


