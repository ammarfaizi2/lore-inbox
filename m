Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbWEVMSL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbWEVMSL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 08:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbWEVMSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 08:18:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5356 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750788AbWEVMSK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 08:18:10 -0400
Subject: Re: [PATCH] Add user taint flag
From: "Stephen C. Tweedie" <sct@redhat.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Stephen Tweedie <sct@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <E1FhwyO-0001YQ-O1@candygram.thunk.org>
References: <E1FhwyO-0001YQ-O1@candygram.thunk.org>
Content-Type: text/plain
Date: Mon, 22 May 2006 13:17:46 +0100
Message-Id: <1148300267.5151.14.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-27) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 2006-05-21 at 19:04 -0400, Theodore Ts'o wrote:
> Allow taint flags to be set from userspace by writing to
> /proc/sys/kernel/tainted, and add a new taint flag, TAINT_USER, to be
> used when userspace is potentially doing something naughty that might
> compromise the kernel.  This will allow support personnel to ask further
> questions about what may have caused the user taint flag to have been
> set.  (For example, by examining the logs of the JVM to determine what
> evil things might have been lurking in the hearts of Java programs.  :-)

That's going to lead to a head-scratching fishing expedition from
support people wondering just why this flag was set.

At the very least we should force the caller to supply a log message
explaining *why* the taint flag is being set and printk it at KERN_ERR
loglevel or higher; so the user API would be

	echo $log > /proc/sys/kernel/taint

rather than manipulating the bit directly.

--Stephen


