Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269561AbUJSS2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269561AbUJSS2g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 14:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269570AbUJSS17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 14:27:59 -0400
Received: from holomorphy.com ([207.189.100.168]:2986 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S270047AbUJSSYd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 14:24:33 -0400
Date: Tue, 19 Oct 2004 11:24:25 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: question on memory map cleanup stuff
Message-ID: <20041019182425.GO5607@holomorphy.com>
References: <41744A50.3030700@nortelnetworks.com> <20041018231432.GI5607@holomorphy.com> <41755A94.8030207@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41755A94.8030207@nortelnetworks.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> vma->vm_ops->close() often suffices for such without disturbing the core.

On Tue, Oct 19, 2004 at 12:19:00PM -0600, Chris Friesen wrote:
> I'm running into a problem.
> At the time of close(), I need to figure out which page to unreserve and 
> free. However, when I call
> follow_page(vma->vm_mm, vma->vm_start, 0);
> it returns zero. How do I go from vma to page?

You generally need to keep track of this yourself, as during ->close()
the pagetables have already been destroyed. linear_page_index() can
tell you the offset into the object the vma maps, but ultimately, you
have to track the pages yourself. vma->vm_private_data can be used to
attach various accounting structures to the vma.


-- wli
