Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263792AbTLDSe6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 13:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263796AbTLDSe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 13:34:58 -0500
Received: from mail.gmx.de ([213.165.64.20]:18072 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263792AbTLDSdk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 13:33:40 -0500
Date: Thu, 4 Dec 2003 19:33:38 +0100 (MET)
From: "Peter Bergmann" <bergmann.peter@gmx.net>
To: Maciej Zenczykowski <maze@cela.pl>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
References: <Pine.LNX.4.44.0312041801560.26684-100000@gaia.cela.pl>
Subject: Re: oom killer in 2.4.23
X-Priority: 3 (Normal)
X-Authenticated: #13246506
Message-ID: <9405.1070562818@www45.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Yes, and as a side question, couldn't oom killer be made into a config 
> option?
> 
> Cheers,
> MaZe.

I just tried it and - no it does not work.  
At least not with the following changes:

added #define PF_MEMDIE  0x00001000 to sched.h

replaced oom_kill.c with the 2.4.22 version

added out_of_memory() to the end of try_to_free_pages_zone()

replaced if (current->flags & PF_MEMALLOC && !in_interrupt()) {
with
replaced if ((current->flags & (PF_MEMALLOC | PF_MEMDIE)) && !in_interrupt()
) {
in page_alloc.c


effect is still unchanged. 
processes get killed by VM and not oom_kikll.c

any hints ??

-- 
+++ GMX - die erste Adresse für Mail, Message, More +++
Neu: Preissenkung für MMS und FreeMMS! http://www.gmx.net


