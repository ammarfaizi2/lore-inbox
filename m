Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270230AbTHGPzb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 11:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270081AbTHGPzB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 11:55:01 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:38788 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S263861AbTHGPym
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 11:54:42 -0400
Subject: Re: pivot_root solved by patch to 2.4.22-pre7
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jason Baron <jbaron@redhat.com>
Cc: Rene Mayrhofer <rene.mayrhofer@gibraltar.at>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0308071120210.894-100000@dhcp64-178.boston.redhat.com>
References: <Pine.LNX.4.44.0308071120210.894-100000@dhcp64-178.boston.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1060271448.3123.75.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 Aug 2003 16:50:49 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-08-07 at 16:26, Jason Baron wrote:
> it clearly makes a difference.
> 
> the unshare_files change causes init to no longer share the same fd table
> with the other kernel threads. thus, when init closes or opens fds it does

Ah yes.. because of do_basic_setup. Having /sbin/init sharing with
kernel threads doesn't actually strike me as too clever anyway although
none of them should be using fd stuff.

In which case I guess we should call unshare_files directly before we
open /dev/console in init/main.c.



