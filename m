Return-Path: <linux-kernel-owner+w=401wt.eu-S1425523AbWLHOs0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425523AbWLHOs0 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 09:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425527AbWLHOs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 09:48:26 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48660 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1425523AbWLHOsZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 09:48:25 -0500
Date: Fri, 8 Dec 2006 14:56:05 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Al Boldi <a1426z@gawab.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: additional oom-killer tuneable worth submitting?
Message-ID: <20061208145605.1a8b0815@localhost.localdomain>
In-Reply-To: <200612081658.29338.a1426z@gawab.com>
References: <200612081658.29338.a1426z@gawab.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2006 16:58:29 +0300
Al Boldi <a1426z@gawab.com> wrote:
> > That is why we have no-overcommit support.
> 
> Alan, I think you know that this isn't really true, due to shared-libs.

Shared libraries are correctly handled by no-overcommit and in fact they
have almost zero impact on out of memory questions because the shared
parts of the library are file backed and constant. That means they don't
actually cost swap space.

> > Now there is an argument for
> > a meaningful rlimit-as to go with it, and together I think they do what
> > you really need.
> 
> The problem with rlimit is that it works per process.  Tuning this by hand 
> may be awkward and/or wasteful.  What we need is to rlimit on a global 
> basis, by calculating an upperlimit dynamically, such as to avoid 
> overcommit/OOM.

You've just described the existing no overcommit functionality, although
you've forgotten to allow for pre-reserving of stacks and some other
detail that has been found to make it work better as it has been refined.

Alan
