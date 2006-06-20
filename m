Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965018AbWFTFWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965018AbWFTFWh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 01:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965015AbWFTFWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 01:22:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64970 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965009AbWFTFWX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 01:22:23 -0400
Date: Mon, 19 Jun 2006 22:22:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jim Cromie <jim.cromie@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch -mm 17/20] chardev: GPIO for SCx200 & PC-8736x: replace
 spinlocks w mutexes
Message-Id: <20060619222221.723792b7.akpm@osdl.org>
In-Reply-To: <44944C19.7000402@gmail.com>
References: <448DB57F.2050006@gmail.com>
	<cfe85dfa0606121150y369f6beeqc643a1fe5c7ce69b@mail.gmail.com>
	<44944C19.7000402@gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Jun 2006 12:38:17 -0600
Jim Cromie <jim.cromie@gmail.com> wrote:

> 17/20. patch.mutexes
> 
> Replace spinlocks guarding gpio config ops with mutexes.  This is a
> me-too patch, and is justifiable insofar as mutexes have stricter
> semantics and better debugging support, so are preferred where they
> are applicable.
> 

OK.  I trust this was all tester with all kernel debug options turned on?

Once it's in -mm you might hare to try out the lockdep checker too.


> -static DEFINE_SPINLOCK(scx200_gpio_config_lock);
> +DEFINE_MUTEX(scx200_gpio_config_lock);

But it doesn't need global scope.

> -static DEFINE_SPINLOCK(pc8736x_gpio_config_lock);
> +DEFINE_MUTEX(pc8736x_gpio_config_lock);

Nor does this?

