Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261914AbVANDqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbVANDqS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 22:46:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261894AbVANDqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 22:46:14 -0500
Received: from fw.osdl.org ([65.172.181.6]:33997 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261910AbVANDp1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 22:45:27 -0500
Date: Thu, 13 Jan 2005 19:44:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: Kevin Corry <kevcorry@us.ibm.com>
Cc: evms-devel@lists.sourceforge.net, rajesh_ghanekar@persistent.co.in,
       dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [Evms-devel] dm snapshot problem
Message-Id: <20050113194448.0e3f15c9.akpm@osdl.org>
In-Reply-To: <200501132142.26663.kevcorry@us.ibm.com>
References: <41E35950.9040201@persistent.co.in>
	<200501131526.59220.kevcorry@us.ibm.com>
	<20050113143443.56bd4977.akpm@osdl.org>
	<200501132142.26663.kevcorry@us.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Corry <kevcorry@us.ibm.com> wrote:
>
> Now that you mention it, the memory pages to hold the copied data is allocated 
>  at the time the snapshot device is activated, and uses 
>  alloc_page(GFP_KERNEL). Should we switch this to alloc_page(GFP_HIGHUSER)?

Sure, if possible.  You'll need to map them in with kmap_atomic() when
actually altering their contents, of course.

