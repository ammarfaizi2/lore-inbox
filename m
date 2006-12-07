Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031833AbWLGIXf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031833AbWLGIXf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 03:23:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031849AbWLGIXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 03:23:35 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:51801 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031833AbWLGIXe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 03:23:34 -0500
Date: Thu, 7 Dec 2006 08:23:32 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: David Miller <davem@davemloft.net>
Cc: dhowells@redhat.com, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: cmpxchg() in kernel/workqueue.c breaks things
Message-ID: <20061207082332.GK4587@ftp.linux.org.uk>
References: <20061207.000950.28414823.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061207.000950.28414823.davem@davemloft.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2006 at 12:09:50AM -0800, David Miller wrote:
> 
> David, you have to fix the locking scheme used in kernel/workqueue.c,
> you absolutely cannot assume that cmpxchg() is available on all
> platforms.  This breaks the build on the platforms that don't
> have such an instruction, and no it cannot emulated.
> 
> Also, because Alan Cox's machine (zeniv) went down, a few folks such
> as Al Viro (CC:'d) had no opportunity to comment on your changes
> before they went in.  This mess would have been avoided if Al had a
> chance to read over this, in particular since he does cross sparc32
> builds he knows that cmpxchg is not available there.

FWIW, the *real* problem with that (and several other recent breakage
incidents) would be avoided if massive cross-arch patchsets would be
posted to linux-arch first.

It wouldn't catch all crap, but at least it would get folks to check
if the damn thing builds.
