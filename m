Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263646AbTDIRhR (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 13:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263649AbTDIRhR (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 13:37:17 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:1958 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S263646AbTDIRhR (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 13:37:17 -0400
Date: Wed, 9 Apr 2003 13:48:51 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Chris Friesen <cfriesen@nortelnetworks.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: msync() more expensive than fsync()?
In-Reply-To: <3E92FAE6.8000300@nortelnetworks.com>
Message-ID: <Pine.LNX.4.44.0304091347000.2515-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Apr 2003, Chris Friesen wrote:

> If I msync() only the pages that were touched in writing (usually 3
> pages) it takes 39 usecs to log a message.
> 
> If I fsync() the entire file (200KB) it takes 12 usec to log a message.
> 
> Why the additional cost for msync()?

If you only write into the file through an mmap()d area, then
I guess that fsync() is a NOP since it doesn't check the page
tables for dirty bits, while msync() does check the page tables.

This also means that fsync() won't see any dirty bits as long
as they're still only in the page tables, and consequently won't
write anything to disk, while msync() will write.

Note that I don't remember the details 100%, but IIRC it was
something like this.

