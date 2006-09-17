Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964890AbWIQAst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964890AbWIQAst (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 20:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964896AbWIQAst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 20:48:49 -0400
Received: from smtp-out.google.com ([216.239.45.12]:4809 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S964890AbWIQAss
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 20:48:48 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=PJ988aMxCvdKbpcb/DbktXWhO+qK0VvSqp38LcxipftRqiKyMyAWLF0WBdR99cj0G
	gsDDj6wSlgM5r2FdrFzgQ==
Message-ID: <d43160c70609161748n2af1c88cx33344e7da3e2b302@mail.google.com>
Date: Sat, 16 Sep 2006 20:48:26 -0400
From: rossb <rossb@google.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Subject: Re: + allow-proc-configgz-to-be-built-as-a-module.patch added to -mm tree
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, mm-commits@vger.kernel.org, akpm@google.com,
       sam@ravnborg.org
In-Reply-To: <1158407250.5152.60.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200609152158.k8FLw7ud018089@shell0.pdx.osdl.net>
	 <20060915154752.d7bdb8a0.rdunlap@xenotime.net>
	 <1158407250.5152.60.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/06, Arjan van de Ven <arjan@infradead.org> wrote:
> > > In some ways this is a bit risky, because the .config which is used for
> > > compiling kernel/configs.c isn't necessarily the same as the .config which was
> > > used to build vmlinux.
> >
> > and that's why a module wasn't allowed.
> > It's not worth the risk IMO.

The problem is, the patch is basically s/bool/tristate/ so you can't
really count on /proc/config.gz anyway.  It's a lot like security
through obscurity.

> One hack we could do is make an md5sum or similar of the config and
> stick that somewhere which is built in and always available (proc or
> sysfs or something like that); that can be used to validate any config
> basically to be "correct matching". In fact we could even make it
> (optionally) part of the VERMAGIC to avoid any kind of mismatch at all.

Not a bad idea, but I think you want to be able to edit your config
before compiling modules.  In particular, you might want to turn
something from off to module.

How about we embed the md5sum of the config in the kernel, make it
available via /proc or /sysfs and then have /proc/config.gz return an
error in the event the md5sum doesn't match?

    Ross
