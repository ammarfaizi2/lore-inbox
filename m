Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270169AbUJTHYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270169AbUJTHYY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 03:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270165AbUJTHX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 03:23:57 -0400
Received: from fmr02.intel.com ([192.55.52.25]:3310 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S270173AbUJTHQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 03:16:23 -0400
Subject: Re: [PATCH] boot parameters: quoting of environment
	variablesrevisited
From: Len Brown <len.brown@intel.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Werner Almesberger <werner@almesberger.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1098253261.10571.129.camel@localhost.localdomain>
References: <1098253261.10571.129.camel@localhost.localdomain>
Content-Type: text/plain
Organization: 
Message-Id: <1098256561.26603.4289.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 20 Oct 2004 03:16:01 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-20 at 02:21, Rusty Russell wrote:
> On Wed, 2004-10-20 at 08:23, Werner Almesberger wrote:
> > When passing boot parameters, they can be quoted as follows:
> > param="value"
> > 
> > Unfortunately, when passing environment variables this way, the
> > quoting causes confusion: in 2.6.7 (etc.), only the variable name
> > was placed in the environment, which caused it to be ignored.

2.6.8.1 was also broken for kernel parameters.
acpi_os_string="Brand X" resulted in acpi_os_string="" in the kernel.

> > I've sent a patch that adjusted the name, but this patch was
> > dropped. Instead, apparently a different fix was attempted in
> > 2.6.9, but this now yields param="value in the environment (note
> > the embeded double quote), which isn't much better.

In 2.6.9 acpi_os_string="Brand X" correctly results in
acpi_os_string="Brand X" in the kernel -- so at least we got that part
right.

> AFAICT 2.4 didn't remove quotes, but I have no problem with removing
> them now, and for __setup for that matter.  Hope noone relies on it.

I verified that this new patch doesn't break the acpi_os_string="Brand
X" kernel parameter.

I'm not sure what quoted parameters for init's environment are used for,
but it looks like FOO="FOO BAR" now results in
FOO=FOO BAR
in the environment.

thanks,
-Len

