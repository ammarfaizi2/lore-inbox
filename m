Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261811AbVGUPqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261811AbVGUPqE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 11:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbVGUPny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 11:43:54 -0400
Received: from mx1.elte.hu ([157.181.1.137]:4570 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261805AbVGUPmx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 11:42:53 -0400
Date: Thu, 21 Jul 2005 17:42:34 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <ncunningham@cyclades.com>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] [PATCH] Workqueue freezer support.
Message-ID: <20050721154234.GA1055@elte.hu>
References: <1121923059.2936.224.camel@localhost> <20050721153824.GB1896@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050721153824.GB1896@elf.ucw.cz>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Pavel Machek <pavel@ucw.cz> wrote:

> > +struct task_struct *kthread_create(int (*threadfn)(void *data),
> > +				   void *data,
> > +				   const char namefmt[], ...)
> > +{
> > +	char result[TASK_COMM_LEN];
> > +
> > +	va_list args;
> > +	va_start(args, namefmt);
> > +	vsnprintf(result, TASK_COMM_LEN, namefmt, args);
> > +	va_end(args);
> > +	return _kthread_create(threadfn, data, 0, result);
> > +}
> > +
> 
> This is slightly ugly and uses lot of stack. Otherwise patch looks 
> okay. If you want me to apply it, be sure to put me into To: or at 
> least Cc:. Or perhaps you want to just mail it to akpm, noting that I 
> acked it (if you do something with the char result[] :-).

TASK_COMM_LEN is only 16 bytes so it's not that bad.

	Ingo
