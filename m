Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266028AbUAQC00 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 21:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266027AbUAQC00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 21:26:26 -0500
Received: from fw.osdl.org ([65.172.181.6]:40920 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266028AbUAQC0W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 21:26:22 -0500
Date: Fri, 16 Jan 2004 18:26:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: CLONE_DETACHED
Message-Id: <20040116182632.7890fe93.akpm@osdl.org>
In-Reply-To: <UTC200401170217.i0H2HNt16225.aeb@smtp.cwi.nl>
References: <UTC200401170217.i0H2HNt16225.aeb@smtp.cwi.nl>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
>
> My current version of the clone.2 manual page says
> 
>        CLONE_THREAD
>               (Linux 2.4 onwards) If  CLONE_THREAD  is  set,  the
>               child  is  placed  in  the same thread group as the
>               calling process.  Now in 2.6 also  the  meaningless
>               CLONE_DETACHED  (introduced in 2.5.32) must be set.
> 
> I wonder whether it is too late to remove CLONE_DETACHED entirely.
> There are precisely two occurrences: the definition and the check
> that it is set when CLONE_THREAD is set. Seems fairly useless.
> 

Changelog says:

ChangeSet 1.1150 2003/08/14 11:11:39 torvalds@home.osdl.org
  Mark CLONE_DETACHED as being irrelevant: it must match CLONE_THREAD.
  
  CLONE_THREAD without CLONE_DETACHED will now return -EINVAL, and
  for a while we will warn about anything that uses it (there are no
  known users, but this will help pinpoint any problems if somebody
  used to care about the invalid combination).


It has been five months; I'd say we could lose it now.  Linus?
