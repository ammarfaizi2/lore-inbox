Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261626AbVA3BGi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbVA3BGi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 20:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261622AbVA3BGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 20:06:35 -0500
Received: from fw.osdl.org ([65.172.181.6]:10141 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261626AbVA3BGa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 20:06:30 -0500
Date: Sat, 29 Jan 2005 17:06:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nathan Lynch <nathanl@austin.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc2-mm2 - "freeing b_committed_data"
Message-Id: <20050129170630.65d0153b.akpm@osdl.org>
In-Reply-To: <1107046718.31457.19.camel@biclops>
References: <20050129131134.75dacb41.akpm@osdl.org>
	<1107046718.31457.19.camel@biclops>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Lynch <nathanl@austin.ibm.com> wrote:
>
> With both 2.6.11-rc2-mm1 and -mm2 I'm seeing this message occasionally
>  on a ppc64 box with ext3 filesystems:
> 
>  __journal_remove_journal_head: freeing b_committed_data

Yes, that appears to be some mysterious race introduced by Alex's JBD fixes.

>  Is this cause for concern?

It probably introduces journalling inconsistencies such that a well-timed
crash could result in an incorrect recovery, so it's a minor problem.
