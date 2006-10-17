Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750933AbWJQNlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbWJQNlY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 09:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750943AbWJQNlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 09:41:24 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:40098 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750933AbWJQNlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 09:41:24 -0400
Subject: Re: [RFC][PATCH] ->signal->tty locking
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Oleg Nesterov <oleg@tv-sign.ru>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Prarit Bhargava <prarit@redhat.com>
In-Reply-To: <1161090004.3036.43.camel@taijtu>
References: <1160992420.22727.14.camel@taijtu> <20061017081018.GA115@oleg>
	 <1161080221.3036.38.camel@taijtu>  <20061017123307.GA209@oleg>
	 <1161090004.3036.43.camel@taijtu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 17 Oct 2006 15:08:03 +0100
Message-Id: <1161094083.24237.182.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-10-17 am 15:00 +0200, ysgrifennodd Peter Zijlstra:
> How about something like this; I'm still shaky on the lifetime rules of
> tty objects, I'm about to add a refcount and spinlock/mutex to
> tty_struct, this is madness....

It has two already.

I wouldn't worry about being shaky about the lifetime rules, thats a
forensics job at the moment.

> +	tty = current_get_tty();

Sensible way to go whichever path we use and once it returns a refcount
bumped object in future it'll clean up a lot more. get_current_tty or
just current_tty() would fit the naming in the kernel better


I agree entirely with the path this patch is taking.

Alan

