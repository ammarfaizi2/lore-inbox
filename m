Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751664AbWIAPqF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751664AbWIAPqF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 11:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751667AbWIAPqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 11:46:05 -0400
Received: from mail.gmx.de ([213.165.64.20]:35772 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751664AbWIAPqD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 11:46:03 -0400
X-Authenticated: #704063
Subject: Re: [Patch] Uninitialized variable in drivers/scsi/ncr53c8xx.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, matthew@wil.cx
In-Reply-To: <20060831230049.db26d0e6.akpm@osdl.org>
References: <1157066952.13948.3.camel@alice>
	 <20060831230049.db26d0e6.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 01 Sep 2006 17:45:56 +0200
Message-Id: <1157125556.3951.2.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-31 at 23:00 -0700, Andrew Morton wrote:
> On Fri, 01 Sep 2006 01:29:12 +0200
> Eric Sesterhenn <snakebyte@gmx.de> wrote:
> 
> > hi,
> > 
> > this was spotted by coverity (id #880).
> > We use simple_strtoul() earlier to initialize pe,
> > if the function fails, it also does not initialize it.
> > Therefore we should initialize it ourselves, so the check
> > in the OPT_TAGS case "if (pe && *pe == '/')" makes sense, and
> > actually makes the command line parsing more robust.
> > 
> > Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>
> 
> simple_strtoul() always initialises `pe'.

D'oh. But i think we should apply the patch nevertheless,
to make the parsing code more robust, in case the command line is
screwed up (and simple_strtoul() is never called).

Eric

