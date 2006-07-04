Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932086AbWGDIhr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbWGDIhr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 04:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbWGDIhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 04:37:47 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:34529 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S932086AbWGDIhr
	(ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Tue, 4 Jul 2006 04:37:47 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17578.10167.898525.424656@gargle.gargle.HOWL>
Date: Tue, 4 Jul 2006 12:32:55 +0400
To: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
Cc: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: [PATCH]  mm: moving dirty pages balancing to pdfludh entirely
Newsgroups: gmane.linux.kernel
In-Reply-To: <B41635854730A14CA71C92B36EC22AAC053FD4@mssmsx411>
References: <B41635854730A14CA71C92B36EC22AAC053FD4@mssmsx411>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Please, don't trim CC/To fields: LKML is too high traffic to read in
its entirety.]

Ananiev, Leonid I writes:
 >  Nikita Danilov writes:
 > > Wouldn't this interfere with current->backing_dev_info logic?
 > 
 > The proposed patch does not modify that logic.

Indeed, it *interferes* with it: in the original code, process doing
direct reclaim during balance_dirty_pages()

    generic_file_write()->balance_dirty_pages()->...->__alloc_pages()->...->pageout()

performs page-out even if queue is congested. Intent of this is to
throttle writers, and reduce risk of running oom (certain file systems,
especially ones with delayed allocation, tend to allocate a lot of
memory in balance_dirty_pages()->writepages() paths).

Your patch breaks this mechanism.

Nikita.
