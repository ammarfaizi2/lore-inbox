Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265053AbUFANoQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265053AbUFANoQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 09:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265051AbUFANoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 09:44:09 -0400
Received: from aun.it.uu.se ([130.238.12.36]:56802 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S265038AbUFANoA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 09:44:00 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-ID: <16572.34833.366022.48748@alkaid.it.uu.se>
Date: Tue, 1 Jun 2004 15:43:45 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc2-mm1
In-Reply-To: <20040601102928.GA16718@infradead.org>
References: <20040601021539.413a7ad7.akpm@osdl.org>
	<20040601102928.GA16718@infradead.org>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig writes:
 > > - merged perfctr.  No documentation though :(
 > 
 > +/* tid is the actual task/thread id (népid, stored as ->pid),
 > +   pid/tgid is that 2.6 thread group id crap (stored as ->tgid) */
 > +asmlinkage long sys_vperfctr_open(int tid, int creat)
 > +{
 > +       struct file *filp;
 > +       struct task_struct *tsk;
 > +       struct vperfctr *perfctr;
 > +       int err;
 > +       int fd;
 > +
 > +       if (!vperfctr_fs_init_done())
 > +               return -ENODEV;
 > +       filp = vperfctr_get_filp();
 > +       if (!filp)
 > +               return -ENOMEM;
 > +       err = fd = get_unused_fd();
 > 
 > This really, really screams "I want to be a special file", so the interface
 > still doesn't look okay.  Probably in /proc/pid. 

Been there, done that. open() on /proc/{$pid,self}/perfctr with
or without O_CREAT was the "get initial access" interface for
several years, until the semantics of /proc/$pid (and /proc/self)
completely changed in 2.6.0-test6.

Virtual perfctrs wants something that denotes the real kernel
task, not that process-is-a-group-of-kernel-threads crap.

/Mikael
