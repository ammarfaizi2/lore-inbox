Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423298AbWF1MJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423298AbWF1MJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 08:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423307AbWF1MJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 08:09:59 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:50387 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1423298AbWF1MJ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 08:09:58 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: x86_64 restore_image declaration needs asmlinkage?
Date: Wed, 28 Jun 2006 14:10:44 +0200
User-Agent: KMail/1.9.3
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Linux-pm mailing list" <linux-pm@lists.osdl.org>,
       suspend2-devel@lists.suspend2.net
References: <200606282048.38746.ncunningham@linuxmail.org> <200606281353.15252.rjw@sisk.pl> <200606282200.36268.ncunningham@linuxmail.org>
In-Reply-To: <200606282200.36268.ncunningham@linuxmail.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606281410.45008.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 28 June 2006 14:00, Nigel Cunningham wrote:
> Hi.
> 
> On Wednesday 28 June 2006 21:53, Rafael J. Wysocki wrote:
> > Hi,
> >
> > On Wednesday 28 June 2006 12:48, Nigel Cunningham wrote:
> > > I received a report of problems with CONFIG_REGPARM and suspending, that
> > > led me to recheck asm calls and declarations. Not being a guru on these
> > > things, I want to ask advice from those who know more.
> > >
> > > Along the way I noticed that current git has:
> > >
> > > extern asmlinkage int swsusp_arch_suspend(void);
> > > extern asmlinkage int swsusp_arch_resume(void);
> > >
> > > This is right for x86, but for x86_64, we actually call a C routine in
> > > arch/x86_64/kernel/suspend.c, which calls restore_image in
> > > arch/x86_64/kernel/suspend_asm.S. Restore image is declared in suspend.c
> > > as
> > >
> > > extern int restore_image(void);
> > >
> > > should it be:
> > >
> > > extern asmlinkage int restore_image(void);
> > >
> > > Having swsusp_arch_resume declared as asmlinkage doesn't matter, does it?
> >
> > No, it doesn't.  It would have mattered on i386 if the function had taken
> > any arguments.  AFAICT, on x86_64 it desn't matter at all.
> 
> Right. But what about restore_image lacking the asmlinkage? I'm also wondering 
> if that does matter.

I think asmlinkage would not matter here too (the function is x86_64-specific).

Greetings,
Rafael
