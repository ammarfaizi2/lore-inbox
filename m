Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932435AbWHaXww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbWHaXww (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 19:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932489AbWHaXww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 19:52:52 -0400
Received: from gw.goop.org ([64.81.55.164]:61855 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S932427AbWHaXwv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 19:52:51 -0400
Message-ID: <44F7764A.7060707@goop.org>
Date: Thu, 31 Aug 2006 16:52:42 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: cpu_init is called during resume
References: <20060831135545.GM3923@elf.ucw.cz> <44F70A4B.4090803@goop.org> <20060831223121.GG12847@elf.ucw.cz>
In-Reply-To: <20060831223121.GG12847@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> We are doing virtual cpu hotplug/unplug... actually suspend to RAM
> *and* disk. Just try it :-).
>   

Yes, I know, but if you're replugging a CPU it should already have a GDT 
allocated, so the kmalloc() won't be called in the resume case.  So if 
there's a problem, it can only be on the resume-from-disk path, on the 
assumption that that secondary CPU hasn't already been brought up.

    J
