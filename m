Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262528AbTEFKyX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 06:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262530AbTEFKyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 06:54:23 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:55232 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262528AbTEFKyW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 06:54:22 -0400
Date: Tue, 6 May 2003 16:39:07 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.69-mm1
Message-ID: <20030506110907.GB9875@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20030504231650.75881288.akpm@digeo.com> <20030505210151.GO8978@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030505210151.GO8978@holomorphy.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 05, 2003 at 09:09:34PM +0000, William Lee Irwin III wrote:
> On Sun, May 04, 2003 at 11:16:50PM -0700, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.69/2.5.69-mm1/
> > Various random fixups, cleanps and speedups.  Mainly a resync to 2.5.69.
> 
> fs/file_table.c: In function `fget_light':
> fs/file_table.c:209: warning: passing arg 1 of `_raw_read_lock' from incompatible pointer type

I should have merged with 2.5.69 before mailing my fget-speedup patch out. 
->file_lock has been changed to a spin_lock somewhere after 2.5.66. 

That brings me to the point - with the fget-speedup patch, we should
probably change ->file_lock back to an rwlock again. We now take this
lock only when fd table is shared and under such situation the rwlock
should help. Andrew, it that ok ?

Thanks
Dipankar
