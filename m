Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964897AbWCAKXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964897AbWCAKXt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 05:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964899AbWCAKXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 05:23:49 -0500
Received: from smtp.osdl.org ([65.172.181.4]:48096 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964897AbWCAKXs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 05:23:48 -0500
Date: Wed, 1 Mar 2006 02:22:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: Max Kellermann <max@duempel.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc[1-5]: soft lockups on Athlon64 X2
Message-Id: <20060301022235.51f47b42.akpm@osdl.org>
In-Reply-To: <20060301100744.GA1041@roonstrasse.net>
References: <20060227122705.GA27141@roonstrasse.net>
	<20060228221948.3d76f80b.akpm@osdl.org>
	<20060301100744.GA1041@roonstrasse.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Max Kellermann <max@duempel.org> wrote:
>
> On 2006/03/01 07:19, Andrew Morton <akpm@osdl.org> wrote:
> > Strange.  I did remove a cond_resched() from
> > invalidate_mapping_pages() so that it could be run under spinlock
> > but I cannot believe that you had so many pages cached that the
> > invalidate took more than ten seconds.
> > 
> > Does the machine recover and otherwise work OK?
> 
> The mount indeed took more than ten (wallclock) seconds during which
> the lockups occured, and after that it seemed usable (I rebooted
> shortly after because I feared fs corruption).  Normally, this mount
> takes 2 seconds or so - it's a crypted 200GB XFS partition.  The same
> goes for the "bugged" kernel with "nosmp": mount is finished quickly.
> 

How is it encrypted?   (With which kernel encryption stuff?)

I guess it'd be useful to see where all that time is spent, if you have
time.   Enable CONFIG_PROFILING, boot with `profile=1', do:

readprofile -r
mount ...
readprofile -n -v -m /boot/System.map | sort -n -k 3 | tail -40

(Make sure it's the correct System.map).
