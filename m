Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262851AbVA2ElN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262851AbVA2ElN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 23:41:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262852AbVA2ElN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 23:41:13 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55746 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262851AbVA2ElK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 23:41:10 -0500
Date: Sat, 29 Jan 2005 04:41:09 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Restrict procfs permissions
Message-ID: <20050129044109.GR8859@parcelfarce.linux.theplanet.co.uk>
References: <20050129024542.GB12270@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050129024542.GB12270@lsrfire.ath.cx>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 29, 2005 at 03:45:42AM +0100, Rene Scharfe wrote:
> The patch is inspired by the /proc restriction parts of the GrSecurity
> patch.  The main difference is the ability to configure the restrictions
> dynamically.  You can change the umask setting by running
> 
>    # mount -o remount,umask=007 /proc
> 
> Testing has been *very* light so far -- it compiles and boots.  Patch is
> against 2.6.11-rc2-bk6.
> 
> Comments are very welcome.

It leaves already existing inodes with whatever mode they used to have.
_IF_ you want to do that sort of things, do it right - add ->permission()
that would apply that umask before checks and if you want it to be seen
in results of stat(2) - add ->gettattr() and do the same there.
