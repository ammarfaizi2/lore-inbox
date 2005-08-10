Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965031AbVHJHbH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965031AbVHJHbH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 03:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965032AbVHJHbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 03:31:06 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:59854 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S965031AbVHJHbF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 03:31:05 -0400
References: <20050802071828.GA11217@redhat.com>
            <84144f0205080203163cab015c@mail.gmail.com>
            <20050803063644.GD9812@redhat.com>
            <courier.42F768D5.000046F2@courier.cs.helsinki.fi>
            <42F7A557.3000200@zabbo.net>
            <1123598983.10790.1.camel@haji.ri.fi>
            <20050810072121.GA2825@infradead.org>
In-Reply-To: <20050810072121.GA2825@infradead.org>
From: "Pekka J Enberg" <penberg@cs.helsinki.fi>
To: Christoph Hellwig <hch@infradead.org>
Cc: Zach Brown <zab@zabbo.net>, David Teigland <teigland@redhat.com>,
       Pekka Enberg <penberg@gmail.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-cluster@redhat.com,
       mark.fasheh@oracle.com
Subject: Re: GFS
Date: Wed, 10 Aug 2005 10:31:04 +0300
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8,iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <courier.42F9AD38.000018F9@courier.cs.helsinki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2005 at 05:49:43PM +0300, Pekka Enberg wrote:
> > In addition, the vma walk will become an unmaintainable mess as soon as
> > someone introduces another mmap() capable fs that needs similar locking.

Christoph Hellwig writes:
> We already have OCFS2 in -mm that does similar things.  I think we need
> to solve this in common code before either of them can be merged.

It seems to me that the distributed locks must be acquired in ->nopage 
anyway to solve the problem with memcpy() between two mmap'd regions. One 
possible solution would be for the lock manager to detect deadlocks and 
break some locks accordingly. Don't know how well that would mix with 
 ->nopage though... 

                  Pekka 

