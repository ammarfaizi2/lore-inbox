Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261189AbVGGGyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbVGGGyr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 02:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbVGGGxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 02:53:10 -0400
Received: from baythorne.infradead.org ([81.187.226.107]:64744 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S261192AbVGGGuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 02:50:18 -0400
Subject: Re: [PATCH] audit: file system auditing based on location and name
From: David Woodhouse <dwmw2@infradead.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: "Timothy R. Chavez" <tinytim@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-audit@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, Mounir Bsaibes <mbsaibes@us.ibm.com>,
       Steve Grubb <sgrubb@redhat.com>, Serge Hallyn <serue@us.ibm.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Klaus Weidner <klaus@atsec.com>, Chris Wright <chrisw@osdl.org>,
       Stephen Smalley <sds@tycho.nsa.gov>, Robert Love <rml@novell.com>,
       Christoph Hellwig <hch@infradead.org>,
       Daniel H Jones <danjones@us.ibm.com>, Amy Griffis <amy.griffis@hp.com>,
       Maneesh Soni <maneesh@in.ibm.com>
In-Reply-To: <1120718414.3198.11.camel@laptopd505.fenrus.org>
References: <1120668881.8328.1.camel@localhost>
	 <1120718414.3198.11.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Thu, 07 Jul 2005 07:50:01 +0100
Message-Id: <1120719001.8058.162.camel@baythorne.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-07 at 08:40 +0200, Arjan van de Ven wrote:
> why is this? It would be a very logical thing to store this stuff inside
> the inode. It sounds like a bad design to keep per inode data out of the
> inode. (if you're concerned about taking a lot of space, put a pointer
> to a kmalloc()'d piece of memory into the inode instead). A hash is
> just, well, odd for this.

There are _very_ few of these; it's very dubious whether it'd be worth
bloating the inode for them. The use of I_AUDIT also serves to pin the
inode in icache, and we'd need something like that even if we _weren't_
using it as a marker for the hash table.

-- 
dwmw2


