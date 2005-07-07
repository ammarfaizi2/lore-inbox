Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbVGGGke@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbVGGGke (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 02:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbVGGGkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 02:40:31 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:6327 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261184AbVGGGk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 02:40:27 -0400
Subject: Re: [PATCH] audit: file system auditing based on location and name
From: Arjan van de Ven <arjan@infradead.org>
To: "Timothy R. Chavez" <tinytim@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-audit@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       David Woodhouse <dwmw2@infradead.org>,
       Mounir Bsaibes <mbsaibes@us.ibm.com>, Steve Grubb <sgrubb@redhat.com>,
       Serge Hallyn <serue@us.ibm.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Klaus Weidner <klaus@atsec.com>, Chris Wright <chrisw@osdl.org>,
       Stephen Smalley <sds@tycho.nsa.gov>, Robert Love <rml@novell.com>,
       Christoph Hellwig <hch@infradead.org>,
       Daniel H Jones <danjones@us.ibm.com>, Amy Griffis <amy.griffis@hp.com>,
       Maneesh Soni <maneesh@in.ibm.com>
In-Reply-To: <1120668881.8328.1.camel@localhost>
References: <1120668881.8328.1.camel@localhost>
Content-Type: text/plain
Date: Thu, 07 Jul 2005 08:40:13 +0200
Message-Id: <1120718414.3198.11.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> Some notable implementation details are as follows:
> 
>   * struct inode is _not_ extended to associate audit data with the
>     inode.  A hash table is used in which the inode is hashed to 
>     retrieve its audit data.  We know if an inode has audit data
>     if I_AUDIT has been turned on in inode->i_state.

why is this? It would be a very logical thing to store this stuff inside
the inode. It sounds like a bad design to keep per inode data out of the
inode. (if you're concerned about taking a lot of space, put a pointer
to a kmalloc()'d piece of memory into the inode instead). A hash is
just, well, odd for this.

>   * Inodes with audit data are implicitly pinned in memory when 
>     I_AUDIT is turned on in inode->i_state.  This prevents an
>     auditable incore inode from being pushed out of the icache,
>     preserving auditability even under memory pressures.

sounds like inotify then... 


