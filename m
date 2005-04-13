Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261208AbVDMXcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbVDMXcc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 19:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbVDMXcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 19:32:32 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:40620 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261208AbVDMXc2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 19:32:28 -0400
Date: Thu, 14 Apr 2005 01:24:31 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Andreas Steinmetz <ast@domdv.de>, rjw@sisk.pl,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH encrypted swsusp 1/3] core functionality
Message-ID: <20050413232431.GF27197@elf.ucw.cz>
References: <E1DLgWi-0003Ag-00@gondolin.me.apana.org.au> <425D17B0.8070109@domdv.de> <20050413212731.GA27091@gondor.apana.org.au> <425D9D50.9050507@domdv.de> <20050413231044.GA31005@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050413231044.GA31005@gondor.apana.org.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Čt 14-04-05 09:10:44, Herbert Xu wrote:
> On Thu, Apr 14, 2005 at 12:29:36AM +0200, Andreas Steinmetz wrote:
> >
> > > Why is that? In the case of swap over dmcrypt, swsusp never reads/writes
> > > the disk directly.  All operations are done through dmcrypt.
> > > 
> > > The user has to enter a password before the system can be resumed.
> > 
> > Think of it the following way: user suspend and later resumes. During
> > suspend some mlocked memory e.g. from ssh-agent gets dumped to swap.
> > Some days later the system gets broken in from a remote place.
> > Unfortunately the ssh keys are still on swap (assuming that ssh-agent is
> > not running then) and can be recovered by the intruder. The intruder can
> 
> The ssh keys are *encrypted* in the swap when dmcrypt is used.
> When the swap runs over dmcrypt all writes including those from
> swsusp are encrypted.

Andreas is right. They are encrypted in swap, but they should not be
there at all. And they are encrypted by key that is still available
after resume. Bad.

First version simply overwrote suspend image in swap with zeros. This
is more clever way to do same thing.

								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
