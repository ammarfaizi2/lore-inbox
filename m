Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264024AbUKAOL5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264024AbUKAOL5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 09:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263374AbUKAOLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 09:11:55 -0500
Received: from fsmlabs.com ([168.103.115.128]:38786 "EHLO musoma.fsmlabs.com")
	by vger.kernel.org with ESMTP id S264148AbUKAOHJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 09:07:09 -0500
Date: Mon, 1 Nov 2004 07:04:20 -0700 (MST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: carlos@tarkus.se
cc: linux-kernel@vger.kernel.org
Subject: Re: spinlock_t typedef visibility and uninitialized spinlock
In-Reply-To: <cb62342b04110103057dc7dff0@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0411010702370.19123@musoma.fsmlabs.com>
References: <cb62342b04110103057dc7dff0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Nov 2004, Carlos Vidal wrote:

> I'm porting CIPE 1.6.0 kernel module to Kernel 2.6.8 and had problems
> with "spin_is_locked on uninitialized spinlock".
> 
> After tracing the problem I found that the spinlock_t structure is not
> visible to the module code. A 'gcc -E' yields:
>      typedef struct { } spinlock_t;
> 
> In spinlock.h, this declaration is inside a #ifdef
> CONFIG_DEBUG_SPINLOCK block, so it becomes visible only
> CONFIG_DEBUG_SPINLOCK is 'y'.
> 
> If I turn CONFIG_DEBUG_SPINLOCK on, the module loads nicely. Otherwise
> I get a nasty error in syslog and sometimes a system crash, as if in
> CIPE the struct was not allocated (what is the case if the compiler
> uses the typedef as it is above).
> 
> The question is: is this a bug or a feature? ;-)
> 
> Should the declaration be out of the #ifdef CONFIG_DEBUG_SPINLOCK? Or
> should I use a special compiler flag?

Try including <linux/config.h> at the top of the compilation unit and run 
through the preprocessor again. By the way, spinlock code got shuffled 
around in 2.6.9...

	Zwane

