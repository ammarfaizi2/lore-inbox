Return-Path: <linux-kernel-owner+w=401wt.eu-S1753645AbWL1Q7Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753645AbWL1Q7Z (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 11:59:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753658AbWL1Q7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 11:59:25 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:41233 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753585AbWL1Q7Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 11:59:24 -0500
Date: Thu, 28 Dec 2006 08:56:23 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Christoph Hellwig <hch@infradead.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>, linux-aio@kvack.org,
       akpm@osdl.org, drepper@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, jakub@redhat.com, mingo@elte.hu
Subject: Re: [FSAIO][PATCH 7/8] Filesystem AIO read
Message-Id: <20061228085623.b6c74840.randy.dunlap@oracle.com>
In-Reply-To: <Pine.LNX.4.61.0612281721170.23545@yvahk01.tjqt.qr>
References: <20061227153855.GA25898@in.ibm.com>
	<20061228082308.GA4476@in.ibm.com>
	<20061228084252.GG6971@in.ibm.com>
	<20061228115747.GB25644@infradead.org>
	<Pine.LNX.4.61.0612281721170.23545@yvahk01.tjqt.qr>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Dec 2006 17:22:07 +0100 (MET) Jan Engelhardt wrote:

> 
> On Dec 28 2006 11:57, Christoph Hellwig wrote:
> >
> >> +
> >> +		if ((error = __lock_page(page, current->io_wait))) {
> >> +			goto readpage_error;
> >> +		}
> >
> >This should  be
> >
> >		error = __lock_page(page, current->io_wait);
> >		if (error)
> >			goto readpage_error;
> 
> That's effectively the same. Essentially a style thing, and I see if((err =
> xyz)) not being uncommon in the kernel tree.

The combined if/assignment has been known to contain coding errors
that are legal C, just not what was intended.

Since the latter replacement shouldn't cause any code efficiency
problems and it's more readable, it's becoming preferred.

---
~Randy
