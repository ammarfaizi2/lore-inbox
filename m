Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271364AbUJVPfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271364AbUJVPfX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 11:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271385AbUJVPek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 11:34:40 -0400
Received: from fmr04.intel.com ([143.183.121.6]:39335 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S271374AbUJVPdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 11:33:24 -0400
Message-Id: <200410221530.i9MFUWq30084@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Andrew Morton'" <akpm@osdl.org>, "Christoph Lameter" <clameter@sgi.com>
Cc: <wli@holomorphy.com>, <raybry@sgi.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Hugepages demand paging V1 [3/4]: Overcommit handling
Date: Fri, 22 Oct 2004 08:32:41 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcS4IiG30zNvKFEoQhu+wDZnTedqIAAKOB4Q
In-Reply-To: <20041022032823.215bd95f.akpm@osdl.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote on Friday, October 22, 2004 3:28 AM
> Christoph Lameter <clameter@sgi.com> wrote:
> >
> >  	* overcommit handling
>
> What does this do, and why do we want it?

The name of "overcommit" is definitely misleading.  It means the
opposite.  Since physical hugetlb backing page pool is fixed and
controlled by sys admin, the fault handler can not allocate free
pages when hugetlb page pool exhaust because of user over commits
hugetlb page.  Thus we enforce strict accounting upfront to
guarantee that there will be hugetlb page available at fault time.

The down side of not having it is we SIGBUS if the kernel doesn't
have any free hugetlb pages left.

- Ken


