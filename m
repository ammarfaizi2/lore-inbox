Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964811AbVHIO7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964811AbVHIO7O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 10:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964813AbVHIO7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 10:59:14 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:40618 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S964811AbVHIO7N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 10:59:13 -0400
Subject: Re: GFS
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Zach Brown <zab@zabbo.net>
Cc: David Teigland <teigland@redhat.com>, Pekka Enberg <penberg@gmail.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, linux-cluster@redhat.com,
       mark.fasheh@oracle.com
In-Reply-To: <42F7A557.3000200@zabbo.net>
References: <20050802071828.GA11217@redhat.com>
	 <84144f0205080203163cab015c@mail.gmail.com>
	 <20050803063644.GD9812@redhat.com>
	 <courier.42F768D5.000046F2@courier.cs.helsinki.fi>
	 <42F7A557.3000200@zabbo.net>
Date: Tue, 09 Aug 2005 17:49:43 +0300
Message-Id: <1123598983.10790.1.camel@haji.ri.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-08 at 11:32 -0700, Zach Brown wrote:
> > Sorry if this is an obvious question but what prevents another thread
> > from doing mmap() before we do the second walk and messing up num_gh?
> 
> Nothing, I suspect.  OCFS2 has a problem like this, too.  It wants a way
> for a file system to serialize mmap/munmap/mremap during file IO.  Well,
> more specifically, it wants to make sure that the locks it acquired at
> the start of the IO really cover the buf regions that might fault during
> the IO.. mapping activity during the IO can wreck that.

In addition, the vma walk will become an unmaintainable mess as soon as
someone introduces another mmap() capable fs that needs similar locking.

I am not an expert so could someone please explain why this cannot be
done with a_ops->prepare_write and friends?

			Pekka

