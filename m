Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263761AbUEXAG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263761AbUEXAG4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 20:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263772AbUEXAG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 20:06:56 -0400
Received: from [209.195.52.120] ([209.195.52.120]:64947 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S263761AbUEXAGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 20:06:42 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Christian Borntraeger <linux-kernel@borntraeger.net>
Cc: linux-kernel@vger.kernel.org, Gergely Czuczy <phoemix@harmless.hu>,
       itk-sysadm@ppke.hu
Date: Sun, 23 May 2004 17:06:32 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: Linux 2.4 VS 2.6 fork VS thread creation time test
In-Reply-To: <200405232147.36372.linux-kernel@borntraeger.net>
Message-ID: <Pine.LNX.4.58.0405231659130.8199@dlang.diginsite.com>
References: <Pine.LNX.4.60.0405230914330.15840@localhost>
 <200405231139.44096.linux-kernel@borntraeger.net>
 <Pine.LNX.4.58.0405230247450.8199@dlang.diginsite.com>
 <200405232147.36372.linux-kernel@borntraeger.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 May 2004, Christian Borntraeger wrote:

> David Lang wrote:
> > On Sun, 23 May 2004, Christian Borntraeger wrote:
> > > Gergely Czuczy wrote:
> > > > failed. As I told it above all the processes are teminated right
> > > > after creation, but there were a lot of defunct processes in the
> > > > system, and they were only gone when the parent termineted.
> > > Have you heard of wait, waitpid and pthread_join?
> > there really is some sort of problem with 2.6.6 in this area. I have an
>
> Well in the example given by Gergely there was no wait call at all.
> Therefore I believe your problem is not related to his one.

Ok, very possible

> What do you mean by with 2.6.6. Does this testcase behaves differently with
> other kernel versions? Which version is the first with this problem?

I started doing this testing with 2.6.4 and had problems with 2.6.[456],
but only on the opterons

> > the prarent deals with sigchild by
> > handler{
> > while ( wait(...) >0);
> > signal(SIGCHLD, handler);
> > }
>
> You run signal within the signal handler. This is not necessary, although
> this should cause no problems. Nevertheless, can you try your test without
> signal in the signal handler?

I will do this, but as I read the signal man page this will cause signal
to be reset after the first signal hits and nothing will set it to handle
any future signals, where should the handler get set instead?

> cheers
>
> Christian
>

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
