Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261673AbVEUGT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbVEUGT1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 May 2005 02:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261674AbVEUGT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 May 2005 02:19:27 -0400
Received: from rev.193.226.233.9.euroweb.hu ([193.226.233.9]:32779 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261680AbVEUGTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 May 2005 02:19:09 -0400
To: hbryan@us.ibm.com
CC: jamie@shareable.org, akpm@osdl.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-reply-to: <OF220824D5.86601CDE-ON88257008.0003590B-88257008.0003D5B4@us.ibm.com>
	(message from Bryan Henderson on Fri, 20 May 2005 17:41:21 -0700)
Subject: Re: [PATCH] FUSE: don't allow restarting of system calls
References: <OF220824D5.86601CDE-ON88257008.0003590B-88257008.0003D5B4@us.ibm.com>
Message-Id: <E1DZNJf-0006b4-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sat, 21 May 2005 08:18:31 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >Having a program be stuck in read/write ignoring signals, so that
> >Control-C, Control-Z and kill don't work on it, while it's waiting for
> >some network operation, is a horrible thing.
> 
> I've made it a personal crusade to eliminate D state.  In addition to all 
> the damage done by computer resources being locked up, something about my 
> computer ignoring me rankles me on a personal level.

Very true.  FUSE currently handles it by allowing SIGKILL, but no
other signals.  Interrupting file operations would be very nice, but
unfortunately apps just don't handle it very well (even in case SuS
actually allows EINTR).

> I believe this proposal is about making open() hang, which I think is even 
> more painful than having read/write hang.  open() is often designed to 
> block much more casually.

Then why the hack do people write programs that get some alarm signal
100 times a second _while_ doing the open.  If they do that then
trying to make it interruptible is sort of useless.

Miklos
