Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261383AbUKBVIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261383AbUKBVIp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 16:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261412AbUKBVIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 16:08:44 -0500
Received: from mail.dif.dk ([193.138.115.101]:1227 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261383AbUKBVII (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 16:08:08 -0500
Date: Tue, 2 Nov 2004 22:16:45 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: question on common error-handling idiom
In-Reply-To: <4187E920.1070302@nortelnetworks.com>
Message-ID: <Pine.LNX.4.61.0411022208390.3285@dragon.hygekrogen.localhost>
References: <4187E920.1070302@nortelnetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Nov 2004, Chris Friesen wrote:

> 
> There's something I've been wondering about for a while.  There is a lot of
> code in linux that looks something like this:
> 
> 
> err = -ERRORCODE
> if (error condition)
> 	goto out;
> 
> 
> While nice to read, it would seem that it might be more efficient to do the
> following:
> 
> if (error condition) {
> 	err = -ERRORCODE;
> 	goto out;
> }
> 
> 
> Is there any particular reason why the former is preferred?  Is the compiler
> smart enough to optimize away the additional write in the non-error path?
> 
There are some places that do

err = -SOMEERROR;
if (some_error)
	goto out;
if (some_other_error)
	goto out;
if (another_error)
	goto out;

In that case, where there are several different conditions that need 
testing, but they all need to return the same error, setting the error 
just once seems the best approach.

but for the places that do

err = -SOMEERROR;
if (condition)
	goto out;

err = -OTHERERROR;
if (condition)
	goto out;

I would tend to agree with you that moving the setting of the error inside 
the if() would make sense.

Let's see what other people think :)


--
Jesper Juhl

