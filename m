Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266864AbUHOUHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266864AbUHOUHK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 16:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266870AbUHOUHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 16:07:10 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:47764 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S266864AbUHOUHF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 16:07:05 -0400
Date: Sun, 15 Aug 2004 13:06:21 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Manfred Spraul <manfred@colorfullife.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: page fault fastpath: Increasing SMP scalability by introducing
 pte
In-Reply-To: <411F7067.8040305@colorfullife.com>
Message-ID: <Pine.LNX.4.58.0408151304190.2470@schroedinger.engr.sgi.com>
References: <411F7067.8040305@colorfullife.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Aug 2004, Manfred Spraul wrote:

> Very odd. Why do you see a problem with the page_table_lock but no
> problem from the mmap semaphore?

Because there is a only a down_read() call for the mmap semaphore before
invoking handle_mm_fault. This is a rw semaphore which means that multiple
processors/processes may be entering handle_mm_fault with a read lock on
the mmap semaphore.
