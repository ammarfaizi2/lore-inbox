Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262259AbTERXOY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 19:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262262AbTERXOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 19:14:23 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:63618 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S262259AbTERXOW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 19:14:22 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sun, 18 May 2003 16:26:26 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: "Peter T. Breuer" <ptb@it.uc3m.es>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: recursive spinlocks. Shoot.
In-Reply-To: <200305182315.h4INFG428386@oboe.it.uc3m.es>
Message-ID: <Pine.LNX.4.55.0305181623320.3568@bigblue.dev.mcafeelabs.com>
References: <200305182315.h4INFG428386@oboe.it.uc3m.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 May 2003, Peter T. Breuer wrote:

> No. This is not true. Imagine two threads, timed as follows ...
>
>     .
>     .
>     .
>     .
> if ((snl)->uniq == current) {
> atomic_inc(&(snl)->count); 		.
> } else { 				.
> spin_lock(&(snl)->lock);		.
> atomic_inc(&(snl)->count);		.
> (snl)->uniq = current; 	  <->	if ((snl)->uniq == current) {
> 				atomic_inc(&(snl)->count);
> 				} else {
> 				spin_lock(&(snl)->lock);
> 				atomic_inc(&(snl)->count);
> 				(snl)->uniq = current;
>
>
> There you are. One hits the read exactly at the time the other does a
> write. Bang.

So, what's bang for you ? The second task (the one that reads "uniq")
will either see "uniq" as NULL or as (task1)->current. And it'll go
acquiring the lock, as expected. Check it again ...




- Davide

