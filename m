Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267759AbUJRXOk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267759AbUJRXOk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 19:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267767AbUJRXOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 19:14:40 -0400
Received: from holomorphy.com ([207.189.100.168]:7075 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267759AbUJRXOj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 19:14:39 -0400
Date: Mon, 18 Oct 2004 16:14:32 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: question on memory map cleanup stuff
Message-ID: <20041018231432.GI5607@holomorphy.com>
References: <41744A50.3030700@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41744A50.3030700@nortelnetworks.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2004 at 04:57:20PM -0600, Chris Friesen wrote:
> I've got a small feature that maps a page of kernel memory to userspace via 
> a syscall, then uses that page for various things.
> Currently, I'm marking the page reserved, then exporting it via 
> remap_page_range().  This means that I need to clean up my mapping whenever 
> the memory map is destroyed (process death, exec(), daemonize, etc.).
> It appears that I should be able to put my cleanup code in exit_mmap().  
> Since the cleanup code calls do_munmap() on the address, I would want to 
> call it before taking mm->page_table_lock, correct?
> Also, normally I would hold mm->mmap_sem before calling do_munmap().  Would 
> I still need this if I'm calling it from exit_mmap()?  Presumably nobody 
> else can get at it anymore...

vma->vm_ops->close() often suffices for such without disturbing the core.


-- wli
