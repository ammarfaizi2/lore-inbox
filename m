Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261384AbVCHO7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbVCHO7b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 09:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbVCHO7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 09:59:31 -0500
Received: from god.demon.nl ([83.160.164.11]:23173 "EHLO god.dyndns.org")
	by vger.kernel.org with ESMTP id S261384AbVCHO7Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 09:59:24 -0500
Date: Tue, 8 Mar 2005 15:59:23 +0100
From: Henk Vergonet <rememberme@god.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: RFC: Harmonised parameter passing
Message-ID: <20050308145923.GA9914@god.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

The current method of parameter passing to drivers build as a module is extremely usefull.
Modules don't have to write there own parsing code, there's a nice macro that can be used to document specifics of the parameter and so on.

Could we extend this method where we use the same methodology for inbound drivers? (Currently a lot of drivers use their own parameter parsing code when it comes to passing values at kernel boot time.)

so we could do the regular:

	insmod mcd io=0x340

for modules, or with kernel boot parameters:

	mcd.io=0x340

for in-kernel drivers.


My proposal would be to introduce something like:

DRIVER_PARM_DESC(variable, description);
DRIVER_PARM(variable, type, scope);

    where scope can be:
	PARM_SCOPE_MODULE	=> This parameter is used in module context.
	PARM_SCOPE_KERNEL	=> This parameter is used in kernel context.
	PARM_SCOPE_MODULE | PARM_SCOPE_KERNEL
				=> This parameter is used in both kernel and module context, which should be the default if scope is omitted.


What do you think?

