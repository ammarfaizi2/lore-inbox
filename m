Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269574AbUJSTEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269574AbUJSTEp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 15:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269724AbUJSTBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 15:01:44 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:51890 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S269574AbUJSSTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 14:19:36 -0400
Message-ID: <41755A94.8030207@nortelnetworks.com>
Date: Tue, 19 Oct 2004 12:19:00 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: question on memory map cleanup stuff
References: <41744A50.3030700@nortelnetworks.com> <20041018231432.GI5607@holomorphy.com>
In-Reply-To: <20041018231432.GI5607@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> On Mon, Oct 18, 2004 at 04:57:20PM -0600, Chris Friesen wrote:
> 
>>I've got a small feature that maps a page of kernel memory to userspace via 
>>a syscall, then uses that page for various things.
>>Currently, I'm marking the page reserved, then exporting it via 
>>remap_page_range().  This means that I need to clean up my mapping whenever 
>>the memory map is destroyed (process death, exec(), daemonize, etc.).

> vma->vm_ops->close() often suffices for such without disturbing the core.

I'm running into a problem.

At the time of close(), I need to figure out which page to unreserve and free. 
However, when I call

follow_page(vma->vm_mm, vma->vm_start, 0);

it returns zero. How do I go from vma to page?

Chris
