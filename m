Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751209AbVKLCKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbVKLCKQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 21:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbVKLCKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 21:10:16 -0500
Received: from rrcs-24-123-59-149.central.biz.rr.com ([24.123.59.149]:9165
	"EHLO galon.ev-en.org") by vger.kernel.org with ESMTP
	id S1751209AbVKLCKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 21:10:14 -0500
Message-ID: <43754EFD.8090205@ev-en.org>
Date: Sat, 12 Nov 2005 02:10:05 +0000
From: Baruch Even <baruch@ev-en.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
Cc: Tom Zanussi <zanussi@us.ibm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, karim@opersys.com
Subject: Re: [PATCH 2/12] relayfs: export relayfs_create_file() with fileops
 param
References: <17268.51814.215178.281986@tut.ibm.com> <17268.51975.485344.880078@tut.ibm.com> <20051111193749.GA17018@infradead.org>
In-Reply-To: <20051111193749.GA17018@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Fri, Nov 11, 2005 at 10:47:03AM -0600, Tom Zanussi wrote:
> 
>>This patch adds a mandatory fileops param to relayfs_create_file() and
>>exports that function so that clients can use it to create files
>>defined by their own set of file operations, in relayfs.  The purpose
>>is to allow relayfs applications to create their own set of 'control'
>>files alongside their relay files in relayfs rather than having to
>>create them in /proc or debugfs for instance.  relayfs_create_file()
>>is also used by relay_open_buf() to create the relay files for a
>>channel.  In this case, a pointer to relayfs_file_operations is passed
>>in, along with a pointer to the buffer associated with the file.
> 
> 
> Again, NACK,  control files don't belong into relayfs.

I'm a user of relayfs and I do think the control files should go with
their channels, FWIW.

Where else would they go? Some other completely unrelated place?

IMO It makes a lot of sense to have a single place, and preferably a
simple api like the relay-apps that Tom already did so as to to make the
simple case easy.

A control file is part of the relay channel, it's the way the kernel and
user mode parts communicate to do fast mmap transfers of the data. It is
possible to do the signalling by using simple file read/write but the
mmap method provides for a lot less copying around.

Baruch
