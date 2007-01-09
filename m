Return-Path: <linux-kernel-owner+w=401wt.eu-S932153AbXAIPbF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbXAIPbF (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 10:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbXAIPbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 10:31:04 -0500
Received: from mx1.redhat.com ([66.187.233.31]:46259 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932153AbXAIPbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 10:31:02 -0500
Message-ID: <45A3B529.80402@redhat.com>
Date: Tue, 09 Jan 2007 10:30:49 -0500
From: Peter Staubach <staubach@redhat.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061215)
MIME-Version: 1.0
To: Hua Zhong <hzhong@gmail.com>
CC: linux-kernel@vger.kernel.org, hugh@veritas.com, hch@infradead.com,
       kenneth.w.chen@intel.com, akpm@osdl.org, torvalds@osdl.org
Subject: Re: [PATCH] support O_DIRECT in tmpfs/ramfs
References: <Pine.LNX.4.64.0701081729100.2747@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.64.0701081729100.2747@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hua Zhong wrote:
> Hi,
>
> A while ago there was a discussion about supporting direct-io on tmpfs.
>
> Here is a simple patch that does it.
>
> 1. A new fs flag FS_RAM_BASED is added and the O_DIRECT flag is ignored
>    if this flag is set (suggestions on a better name?)
>
> 2. Specify FS_RAM_BASED for tmpfs and ramfs.
>
> 3. When EINVAL is returned only a fput is done. I changed it to go
>    through cleanup_all. But there is still a cleanup problem:
>
>   If a new file is created and then EINVAL is returned due to O_DIRECT,
>   the file is still left on the disk. I am not exactly sure how to fix
>   it other than adding another fs flag so we could check O_DIRECT
>   support at a much earlier stage. Comments on how to fix it?

This would seem to create two different sets of O_DIRECT semantics,
wouldn't it?  I think that it would be possible to develop an application
using one of these FS_RAM_BASED file systems as the testbed, but then be
surprised when the application failed to work on other file systems such
as ext3.

       ps
