Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262821AbVBCIK2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262821AbVBCIK2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 03:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262882AbVBCIK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 03:10:27 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:31382 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262821AbVBCIKI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 03:10:08 -0500
Subject: Re: [Fastboot] [PATCH] Reserving backup region for kexec based
	crashdumps.
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Hirokazu Takahashi <taka@valinux.co.jp>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>,
       fastboot <fastboot@lists.osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Maneesh Soni <maneesh@in.ibm.com>,
       Hariprasad Nellitheertha <hari@in.ibm.com>,
       suparna bhattacharya <suparna@in.ibm.com>
In-Reply-To: <20050203.160252.104031714.taka@valinux.co.jp>
References: <1106475280.26219.125.camel@2fwv946.in.ibm.com>
	 <m18y6gf6mj.fsf@ebiederm.dsl.xmission.com>
	 <1106833527.15652.146.camel@2fwv946.in.ibm.com>
	 <20050203.160252.104031714.taka@valinux.co.jp>
Content-Type: text/plain
Organization: 
Message-Id: <1107421303.11609.183.camel@2fwv946.in.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 03 Feb 2005 14:31:43 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2005-02-03 at 12:32, Hirokazu Takahashi wrote:
> Hi Vivek and Eric,
> 
> IMHO, why don't we swap not only the contents of the top 640K
> but also kernel working memory for kdump kernel?


Initial patches of kdump had adopted the same approach but given the
fact devices are not stopped during transition to new kernel after a
panic, it carried inherent risk of some DMA going on and corrupting the
new kernel/data structures. Hence the idea of running the kernel from a
reserved location came up. This should be DMA safe as long as DMA is not
misdirected.

Thanks 
Vivek

> 
> I guess this approach has some good points.
> 
>  1.Preallocating reserved area is not mandatory at boot time.
>    And the reserved area can be distributed in small pieces
>    like original kexec does.
> 
>  2.Special linking is not required for kdump kernel.
>    Each kdump kernel can be linked in the same way,
>    where the original kernel exists.
> 
> Am I missing something?
>  physical memory
>    +-------+
>    | 640K  ------------+
>    |.......|           |
>    |       |         copy
>    +-------+           |
>    |       |           |
>    |original<-----+    |
>    |kernel |      |    |
>    |       |      |    |
>    |.......|      |    |
>    |       |      |    |
>    |       |      |    |
>    |       |     swap  |
>    |       |      |    |
>    +-------+      |    |
>    |reserved<----------+
>    |area   |      |
>    |       |      |
>    |kdump  |<-----+
>    |kernel |
>    +-------+
>    |       |
>    |       |
>    |       |
>    +-------+
> 
> 


