Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751231AbWCGPdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbWCGPdm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 10:33:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbWCGPdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 10:33:42 -0500
Received: from mxsf31.cluster1.charter.net ([209.225.28.130]:48805 "EHLO
	mxsf31.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S1751220AbWCGPdl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 10:33:41 -0500
X-IronPort-AV: i="4.02,172,1139202000"; 
   d="scan'208"; a="54758915:sNHT19312754"
From: "Joseph D. Wagner" <technojoe@josephdwagner.info>
To: "'Andreas Dilger'" <adilger@clusterfs.com>
Cc: "'Xin Zhao'" <uszhaoxin@gmail.com>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>,
       <linux-fsdevel@vger.kernel.org>
Subject: RE: Why ext3 uses different policies to allocate inodes for dirs and files?
Date: Tue, 7 Mar 2006 09:34:53 -0600
Message-ID: <001901c641fc$ae8120e0$0201a8c0@joe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <20060307083319.GH6393@schatzie.adilger.int>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
thread-index: AcZBweALJa3Hv6JVTXeljfPxDBIskwAOJ9ZA
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm not sure what it is you are saying.  Directories may be renamed, but
> the inodes are never moved.

That is what I meant to say.  I should have been clearer between when I said "directories" and "dir inodes".  When I said "directories" I was referring to the names.  By "directories are moved" I was referring to how you can rename a directory in such a way as to change its name within the hierarchy.  For example:

mv -R /usr/local/lib/i386-redhat-linux/ /usr/lib/

Assuming that the source and destination are the same partition, this "move" operation is actually a simple "rename".  The "dir inode" listing of "i386-redhat-linux" is removed from the "/usr/local/lib/" directory list and added to the "/usr/lib/" directory list.

If the "dir inode" were to be moved closer to the "parent dir inode", this would become quite an expensive "move" operation, as it would have to move all of the "dir inodes" of the "i386-redhat-linux" directory and all subdirectories away from the "parent dir inode" of "/usr/local/lib/" and closer to the "parent dir inode" of "/usr/lib/".

Like I said, this is just one of several reasons why "dir inodes" are spread out more uniformly throughout the partition, rather than kept close to their "parent dir inode".

Sorry I wasn't clearer.

Joseph D. Wagner
