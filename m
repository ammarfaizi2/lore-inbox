Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261671AbVBOKcV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261671AbVBOKcV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 05:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbVBOKcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 05:32:21 -0500
Received: from mx1.elte.hu ([157.181.1.137]:51379 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261671AbVBOKcQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 05:32:16 -0500
Date: Tue, 15 Feb 2005 11:32:07 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Dave Airlie <airlied@gmail.com>
Cc: Dave Airlie <airlied@linux.ie>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: SiS drm broken during 2.6.9-rc1-bk1
Message-ID: <20050215103207.GA19866@elte.hu>
References: <Pine.LNX.4.58.0502131124090.16528@skynet> <21d7e99705021400266bcbc0f2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21d7e99705021400266bcbc0f2@mail.gmail.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Dave Airlie <airlied@gmail.com> wrote:

> > layout is the most likely patch to have broken things... I haven't
> > confirmed it is this particular patch yet, tomorrow I'll get some time to
> > do it ..
> > 
> 
> okay running client applications using 
> 
> setarch -L i386 glxgears
> 
> makes them work.. I'll start looking for a bug in the the SIS client
> side library..

yeah. Look for 2GB assumptions - e.g. assumptions that pointers cast to
integer will be positive values, such as:

	int i;

	i = malloc(somesize);
	if (i <= 0)
		handle_alloc_failure();

here with the topdown layout you'd get a malloc 'failure'.

	Ingo
