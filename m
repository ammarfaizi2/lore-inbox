Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965094AbWIWBU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965094AbWIWBU5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 21:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965097AbWIWBU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 21:20:57 -0400
Received: from wx-out-0506.google.com ([66.249.82.231]:57894 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965094AbWIWBU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 21:20:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iV0+3PyrAYBaetl9uYSeV/1rDeNR4iS33gSZW2GAqQTMJLIS8LhbZLUM3Na2zI7e7+QsysBUdpezBIw9YYmrsvVWfXRK90SGq5kvQpKXyLODOnzKGrVGCHzD2e/M+oCO2zkY4ZtOXmr/t/hXxIil5Tfc7qvhgKDYsdNCzCh4oqs=
Message-ID: <35a82d00609221820y4e3a4667yfa4f8f9c3570af45@mail.gmail.com>
Date: Fri, 22 Sep 2006 18:20:55 -0700
From: "Scott Baker" <smbaker@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: fault when using iget() on XFS file system (2.6.9)
Cc: "Al Viro" <viro@ftp.linux.org.uk>
In-Reply-To: <20060922234927.GU29920@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <35a82d00609221642u2e4a5026w434584ff77b7b9bb@mail.gmail.com>
	 <20060922234927.GU29920@ftp.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Explain why you think you need iget().  It's almost certainly a Bad Idea(tm) -
> code outside of filesystem has no business calling it.

Hello Al,

Thanks for the reply. I'm working on a file system layering module.
Without going into a whole lot of detail, it needs to sit on top of a
lower file system (such as ext3 or xfs), and presents itself as a file
system to other layers, such as usermode and the kernel nfs server.

The kernel nfs server uses the get_object export_operation to map a
file handle (which in our case is identical an inode number) into a
denty. Thus, the kernel nfsd presents my layer with an inode number,
which I must map into a dentry. I do this by calling iget() on the
lower file system (ext3, xfs) to get the inode, then work from there
to get all of the dentrys stitched together.

Thus, I could make everything work if I had a general-purpose
mechanism for querying the lower file system (xfs, ext3) with an inode
number to get an inode or dentry. I thought iget() was my answer, but
it doesn't work in the general case for xfs.

Scott
