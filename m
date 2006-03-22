Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751284AbWCVPD4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbWCVPD4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 10:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbWCVPDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 10:03:36 -0500
Received: from ns.suse.de ([195.135.220.2]:2208 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751274AbWCVPDa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 10:03:30 -0500
From: Andi Kleen <ak@suse.de>
To: virtualization@lists.osdl.org
Subject: Re: [RFC PATCH 26/35] Add Xen subarch reboot support
Date: Wed, 22 Mar 2006 15:21:57 +0100
User-Agent: KMail/1.9.1
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>
References: <20060322063040.960068000@sorel.sous-sol.org> <20060322063801.949835000@sorel.sous-sol.org>
In-Reply-To: <20060322063801.949835000@sorel.sous-sol.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603221521.57639.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 March 2006 07:31, Chris Wright wrote:
> +       static char *envp[] = { "HOME=/", "TERM=linux",
> +                               "PATH=/sbin:/usr/sbin:/bin:/usr/bin", NULL };
> +       static char *restart_argv[]  = { "/sbin/reboot", NULL };
> +       static char *poweroff_argv[] = { "/sbin/poweroff", NULL };

It would be better if that was user configurable.

> +	extern asmlinkage long sys_reboot(int magic1, int magic2,
> +					  unsigned int cmd, void *arg);

This is what linux/syscalls.h is there for.



> +	daemonize("shutdown");

What is that good for?

> +
> +	switch (shutting_down) {
> +	case SHUTDOWN_POWEROFF:
> +	case SHUTDOWN_HALT:
> +		if (execve("/sbin/poweroff", poweroff_argv, envp) < 0) {

You should probably keep track if the execve already happened and if it is called
again do the sys_reboot directly.


-Andi
