Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271389AbTGQKRL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 06:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271392AbTGQKRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 06:17:11 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:3086 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S271389AbTGQKRE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 06:17:04 -0400
Date: Thu, 17 Jul 2003 11:31:58 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [BUG?] 2.5.71 removed request_module("scsi_hostadapter")
Message-ID: <20030717113158.B18620@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
References: <200307161145.h6GBjaSi025681@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200307161145.h6GBjaSi025681@harpo.it.uu.se>; from mikpe@csd.uu.se on Wed, Jul 16, 2003 at 01:45:36PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 01:45:36PM +0200, Mikael Pettersson wrote:
> While trying to figure out why my SCSI modules don't autoload
> properly in 2.6.0-test1 and late 2.5 kernels, I found that
> patch-2.5.71 removed scsi.c's request_module("scsi_hostadapter").
> It seems that some driver model conversion changed scsi_register_device()
> to scsi_register_{driver,interface}(), but the latter don't do
> anything wrt autoloading the host adapter.
> 
> Is this an oversight or is it intensional?

It's intentional.

> I can probably work around this through "install" command
> kludgery in /etc/modprobe.conf, but that's (a) is ugly, and
> (b) probably won't work for configs with built-in SCSI core
> but modular host adapter.

builtin scsi core doesn't matter for this at all, the question
is whether the highlevel drivers are compiled in or not.

modular highlevel driver(s)

	simples postinst in old-style modules.conf (or some rusty equivalent)

builtin highlevel driver(s)

	the request_module is useless anyway as it happens before root is
	mounted.

