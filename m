Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261325AbVBGXlu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261325AbVBGXlu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 18:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261330AbVBGXlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 18:41:50 -0500
Received: from fw.osdl.org ([65.172.181.6]:17280 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261325AbVBGXls (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 18:41:48 -0500
Date: Mon, 7 Feb 2005 15:46:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Cc: linux-kernel@vger.kernel.org, gh@us.ibm.com, guillaume.thouvenin@bull.net,
       elsa-devel@lists.sourceforge.net
Subject: Re: [RFC][PATCH 2.6.11-rc3-mm1] Relay Fork Module
Message-Id: <20050207154623.33333cda.akpm@osdl.org>
In-Reply-To: <1107786245.9582.27.camel@frecb000711.frec.bull.fr>
References: <1107786245.9582.27.camel@frecb000711.frec.bull.fr>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guillaume Thouvenin <guillaume.thouvenin@bull.net> wrote:
>
> Hello,
> 	
>    This module sends a signal to one or several processes (in user
> space) when a fork occurs in the kernel. It relays information about
> forks (parent and child pid) to a user space application.
>
> ...
>    This patch is used by the Enhanced Linux System Accounting tool that
> can be downloaded from http://elsa.sf.net

So this permits ELSA to maintain a complete picture of the process/thread
hierarchy?  I guess that fits into the "do it in userspace" mantra -
certainly hooking into fork() is a minimal way of doing this, although I
wonder what the limitations are.

Implementation-wise: there's a lot of code there and the interface is a bit
awkward.  Why not just feed that kobject you have there into
kobject_uevent()?
