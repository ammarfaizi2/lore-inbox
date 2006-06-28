Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423289AbWF1Lwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423289AbWF1Lwx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 07:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423290AbWF1Lwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 07:52:53 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:34771 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1423289AbWF1Lww (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 07:52:52 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: x86_64 restore_image declaration needs asmlinkage?
Date: Wed, 28 Jun 2006 13:53:15 +0200
User-Agent: KMail/1.9.3
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Linux-pm mailing list" <linux-pm@lists.osdl.org>,
       suspend2-devel@lists.suspend2.net
References: <200606282048.38746.ncunningham@linuxmail.org>
In-Reply-To: <200606282048.38746.ncunningham@linuxmail.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606281353.15252.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday 28 June 2006 12:48, Nigel Cunningham wrote:
> I received a report of problems with CONFIG_REGPARM and suspending, that led 
> me to recheck asm calls and declarations. Not being a guru on these things, I 
> want to ask advice from those who know more.
> 
> Along the way I noticed that current git has:
> 
> extern asmlinkage int swsusp_arch_suspend(void);
> extern asmlinkage int swsusp_arch_resume(void);
> 
> This is right for x86, but for x86_64, we actually call a C routine in 
> arch/x86_64/kernel/suspend.c, which calls restore_image in 
> arch/x86_64/kernel/suspend_asm.S. Restore image is declared in suspend.c as 
> 
> extern int restore_image(void);
> 
> should it be:
> 
> extern asmlinkage int restore_image(void);
> 
> Having swsusp_arch_resume declared as asmlinkage doesn't matter, does it?

No, it doesn't.  It would have mattered on i386 if the function had taken any
arguments.  AFAICT, on x86_64 it desn't matter at all.

Greetings,
Rafael
