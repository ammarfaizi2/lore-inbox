Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbTE2VJf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 17:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263020AbTE2VJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 17:09:34 -0400
Received: from b.smtp-out.sonic.net ([208.201.224.39]:51608 "HELO
	b.smtp-out.sonic.net") by vger.kernel.org with SMTP id S263062AbTE2VJW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 17:09:22 -0400
X-envelope-info: <dhinds@sonic.net>
Date: Thu, 29 May 2003 14:22:38 -0700
From: David Hinds <dhinds@sonic.net>
To: Hollis Blanchard <hollisb@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Junfeng Yang <yjf@stanford.edu>
Subject: Re: [CHECKER] pcmcia user-pointer dereference
Message-ID: <20030529142238.A8933@sonic.net>
References: <17ACEE5A-921A-11D7-B8B8-000A95A0560C@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17ACEE5A-921A-11D7-B8B8-000A95A0560C@us.ibm.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 29, 2003 at 04:11:19PM -0500, Hollis Blanchard wrote:
> 
> I contacted David Hinds about this; the behavior is by design. User 
> space passes in a pointer to a kernel data structure, and the kernel 
> verifies it by checking a magic number in that structure.
> 
> It seems possible to perform some activity from user space to get the 
> magic number into (any) kernel memory, then iterate over kernel space 
> by passing pointers to the pcmcia ds_ioctl() until you manage to 
> corrupt something. But I'm not really a security guy...

This ioctl just returns the contents of another field of that same
data structure that contains the magic number.  So, a malicious user
could, if they were able to cause another kernel data structure to
contain that magic number and they knew the address of that data
structure, use this ioctl to read out the contents of an adjacent
field that might not have otherwise been user-accessable.  You could
not corrupt anything with this ioctl.

The kernel pointer could be done away with, by instead using an
integer to represent the position in a linked list of the target data
structure, which would be the best fix, if someone wants to code it.

- Dave

