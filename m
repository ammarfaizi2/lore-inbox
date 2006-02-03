Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964891AbWBCDTB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964891AbWBCDTB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 22:19:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964893AbWBCDTB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 22:19:01 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:10942 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964891AbWBCDTA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 22:19:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QmIn4oHjKPKuMcd5XPcjU0YJ/6G9HxshL6+Uvf1yxrKA+mt7KcnIslgOCjswt2sp9+i896S92qC+43/lhN6goEvajaMq5+0o0N5QXUBO5SZ7lYZOP8F6m9rGBVnobX5m0k/jyFq+tM2avuAMwlvGEsUhgrQAgoOMIOmY2fwAss4=
Message-ID: <b324b5ad0602021918s45a94b8es5f35618918aa4a7a@mail.gmail.com>
Date: Thu, 2 Feb 2006 19:18:59 -0800
From: David Singleton <daviado@gmail.com>
To: tglx@linutronix.de, mingo@elte.hu
Subject: Re: Robust mutexes (-rt)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1138909303.29087.51.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1138740179.5184.34.camel@localhost.localdomain>
	 <b324b5ad0602011528g7ef81dc1ua0ecad2d73348d89@mail.gmail.com>
	 <1138863989.29087.24.camel@localhost.localdomain>
	 <1138909303.29087.51.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas,
     here is a patch that fixes the -EINTR problem and a fix for Dinakar's
simple futex deadlock test program.  When Esben's new deadlock detection
is ready I plan to use it for robust futex deadlock detection, both simple and
circular deadlock detection.


     http://source.mvista.com:~dsingleton/patch-2.6.15-rt16-rf1

 include/linux/futex.h |    3 +++
 kernel/futex.c          |    3 +++
 kernel/rt.c               |   19 ++++++++++++++++++-
 3 files changed, 24 insertions(+), 1 deletion(-)

David

> Just another problem:
>
> pthread_mutex_lock() of a robust mutex returns -EINTR, which is wrong by
> the specification. We encountered this in an application. Not sure what
> to do about that. It needs either a fix in glibc or the kernel could
> handle it via a restart function. That happens when a signal is
> delivered to the thread while the thread is blocked on the mutex.
>
>         tglx
>
>
>
>
>
