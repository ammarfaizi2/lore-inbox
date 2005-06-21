Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262090AbVFUPOJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262090AbVFUPOJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 11:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbVFUPM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 11:12:57 -0400
Received: from rrcs-24-227-247-8.sw.biz.rr.com ([24.227.247.8]:51585 "EHLO
	emachine.austin.ammasso.com") by vger.kernel.org with ESMTP
	id S262112AbVFUPKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 11:10:42 -0400
Message-ID: <42B82DF2.2050708@ammasso.com>
Date: Tue, 21 Jun 2005 10:10:42 -0500
From: Timur Tabi <timur.tabi@ammasso.com>
Organization: Ammasso
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.8) Gecko/20050511 Mnenhy/0.7.2.0
X-Accept-Language: en-us, en, en-gb
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: get_user_pages() and shared memory question
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Is it possible for a page of memory that's been "grabbed" with get_user_pages() to ever be 
allocated to another process?  I'm assuming the answer is no, but I have a specific case I 
want to ask about.

Let's say an application allocates some shared memory, and then calls into a driver which 
calls get_user_pages().  The driver exits without releasing the pages, so they now have a 
reference count on them.  Then the application deallocates the shared memory.  At this 
point, the virtual addresses disappear, and no process owns them, but the pages still have 
a reference count.

Another process now tries to allocate a shared memory buffer.  Is there any way that this 
new buffer can contain those pages that were grabbed with get_user_pages() (i.e. that 
already have a reference count)?

Until 2.6.7, there was a bug in the VM where a page that was grabbed with get_user_pages() 
could be swapped out.  Those of you familar with the OpenIB work know what I'm talking 
about.  Would that bug affect anything I'm talking about?

-- 
Timur Tabi
Staff Software Engineer
timur.tabi@ammasso.com

One thing a Southern boy will never say is,
"I don't think duct tape will fix it."
      -- Ed Smylie, NASA engineer for Apollo 13
