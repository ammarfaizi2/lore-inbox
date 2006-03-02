Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751568AbWCBQQ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751568AbWCBQQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 11:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751570AbWCBQQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 11:16:57 -0500
Received: from smtpq2.tilbu1.nb.home.nl ([213.51.146.201]:48349 "EHLO
	smtpq2.tilbu1.nb.home.nl") by vger.kernel.org with ESMTP
	id S1751561AbWCBQQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 11:16:57 -0500
Message-ID: <44071AC3.5070709@keyaccess.nl>
Date: Thu, 02 Mar 2006 17:18:11 +0100
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc5 OOM regression
References: <4405F929.2030609@keyaccess.nl> <20060302022356.5fad2e08.akpm@osdl.org>
In-Reply-To: <20060302022356.5fad2e08.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> crap, thanks.  I would appear to have broken one of Christoph's patches for
> him.
> 
> --- devel/mm/oom_kill.c~out_of_memory-locking-fix	2006-03-02 02:17:00.000000000 -0800
> +++ devel-akpm/mm/oom_kill.c	2006-03-02 02:17:22.000000000 -0800
> @@ -355,6 +355,7 @@ retry:
>  	}
>  
>  out:
> +	read_unlock(&tasklist_lock);
>  	cpuset_unlock();
>  	if (mm)
>  		mmput(mm);
> _
> 

Confirmed to solve, thanks!

Rene.


