Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266293AbUHCNAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266293AbUHCNAy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 09:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266324AbUHCNAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 09:00:53 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16780 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266293AbUHCNAw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 09:00:52 -0400
Date: Tue, 3 Aug 2004 13:57:56 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] Change sysfs_file_operations
Message-ID: <20040803125756.GV12308@parcelfarce.linux.theplanet.co.uk>
References: <20040729203718.GB4592@in.ibm.com> <20040729203821.GC4592@in.ibm.com> <20040729203919.GD4592@in.ibm.com> <20040729204031.GE4592@in.ibm.com> <20040729204359.GF4592@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040729204359.GF4592@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2004 at 03:43:59PM -0500, Maneesh Soni wrote:
> 
> 
> 
> o This patch modifies the sysfs_file_operations methods so as to get the
>   kobject and attribute pointers via corresponding sysfs_dirent.

Hmm...  After looking at that, I'd probably add typed inlined helpers
(dentry to attr, dentry to kobject, dentry to bin_attr) and converted
to their use *before* everything else (patch #0).  And change their
definitions to use sysfs_dirent in patch #1.  That way we avoid breakage
on intermediate stages.
