Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264538AbUD1AVB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264538AbUD1AVB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 20:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264550AbUD1AUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 20:20:00 -0400
Received: from gprs214-84.eurotel.cz ([160.218.214.84]:19074 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S264534AbUD1AR0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 20:17:26 -0400
Date: Wed, 28 Apr 2004 02:17:09 +0200
From: Pavel Machek <pavel@suse.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: ncunningham@linuxmail.org, Herbert Xu <herbert@gondor.apana.org.au>,
       Andrew Morton <akpm@zip.com.au>, seife@suse.de,
       Nigel Cunningham <ncunningham@linuxmail.com>,
       Roland Stigge <stigge@antcom.de>, 234976@bugs.debian.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Bug#234976: kernel-source-2.6.4: Software Suspend doesn't work
Message-ID: <20040428001709.GB6592@elf.ucw.cz>
References: <1083048985.12517.21.camel@gaston> <20040427102127.GB10593@elf.ucw.cz> <20040427102344.GA24313@gondor.apana.org.au> <20040427124837.GK10593@elf.ucw.cz> <20040427125402.GA16740@gondor.apana.org.au> <20040427215236.GA469@elf.ucw.cz> <opr640q9abshwjtr@laptop-linux.wpcb.org.au> <20040427231626.GA32689@elf.ucw.cz> <opr641k5m2shwjtr@laptop-linux.wpcb.org.au> <1083108250.16475.54.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1083108250.16475.54.camel@gaston>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > ged, anyway...
> > 
> > Could do. And on the top of merging, sorry for the delays I'm getting  
> > there. I figured out yesterday what was holding me back with getting SMP &  
> > HighMem going under 2.6. It was really simple: the compile was using -O2.  
> > A quick change to the Makefile and I can now use a C file as I do with 2.4.
> 
> Which, as I keep saying, is plain broken ... You simply cannot control
> what side effects the compiler will generate, like touching the stack,
> etc... Such a critical routine _has_ to be written in assembly (and
> properly commented of course). Anything else is asking for trouble.

You are of course right.

OTOH this is easy to solve... gcc -E and use resulting assembly after
verifying it (and probably cleaning it up).

BTW do not do the same mistake I did... I basically lost original .c
file. Make sure .c file is still there somewhere, so assembly can be
regenerated after big changes.
								Pavel
-- 
934a471f20d6580d5aad759bf0d97ddc
