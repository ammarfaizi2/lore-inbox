Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751108AbVIWQBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbVIWQBO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 12:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbVIWQBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 12:01:14 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:3511 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751108AbVIWQBN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 12:01:13 -0400
Date: Fri, 23 Sep 2005 21:25:10 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Pablo Fernandez <pablo.ferlop@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: max_fd
Message-ID: <20050923155509.GA4723@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <8518592505092305373465a5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8518592505092305373465a5@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2005 at 02:37:51PM +0200, Pablo Fernandez wrote:
> Hi
> 
> What happend to files_struct.max_fd? Is it safe to use
> files_fdtable(files_struct).max_fds?

No.

Just do - 

	struct fdtable *fdt;

	rcu_read_lock();
	fdt = files_fdtable(files_struct);
	if (fdt->max_fds......
	...
	rcu_read_unlock();


If you are updating the fd table, then acuire the file_lock
instead of rcu_read_lock/unlock.

Thanks
Dipankar
