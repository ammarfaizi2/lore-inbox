Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751181AbWG0PEX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbWG0PEX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 11:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751639AbWG0PEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 11:04:23 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:30860 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751181AbWG0PEW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 11:04:22 -0400
Subject: Re: [RFC PATCH 27/33] Add the Xen virtual console driver.
From: Hollis Blanchard <hollisb@us.ibm.com>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       virtualization@lists.osdl.org, Jeremy Fitzhardinge <jeremy@goop.org>,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>
In-Reply-To: <20060718091956.653901000@sous-sol.org>
References: <20060718091807.467468000@sous-sol.org>
	 <20060718091956.653901000@sous-sol.org>
Content-Type: text/plain
Organization: IBM Linux Technology Center
Date: Thu, 27 Jul 2006 10:05:05 -0500
Message-Id: <1154012705.30819.6.camel@basalt.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-18 at 00:00 -0700, Chris Wright wrote:
> plain text document attachment (xen-console)
> This provides a bootstrap and ongoing emergency console which is
> intended to be available from very early during boot and at all times
> thereafter, in contrast with alternatives such as UDP-based syslogd,
> or logging in via ssh. The protocol is based on a simple shared-memory
> ring buffer.

> +/*
> + * Modes:
> + *  'xencons=off'  [XC_OFF]:     Console is disabled.
> + *  'xencons=tty'  [XC_TTY]:     Console attached to '/dev/tty[0-9]+'.
> + *  'xencons=ttyS' [XC_SERIAL]:  Console attached to '/dev/ttyS[0-9]+'.
> + *                 [XC_DEFAULT]: DOM0 -> XC_SERIAL ; all others -> XC_TTY.
> + * 
> + * NB. In mode XC_TTY, we create dummy consoles for tty2-63. This suppresses
> + * warnings from standard distro startup scripts.
> + */

The console driver should not be hijacking /dev/tty or /dev/ttyS
devices. Instead, it should use its own char device, like the pSeries
hypervisor console does (/dev/hvc).

Yes, I understand that installers, inittab, and securetty files will
need to be updated. Luckily, there are a couple of distros interested in
supporting Xen who I suspect will be able to help.

-- 
Hollis Blanchard
IBM Linux Technology Center

