Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262878AbTE2U7H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 16:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262884AbTE2U7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 16:59:06 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:49621 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262878AbTE2U61
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 16:58:27 -0400
Date: Thu, 29 May 2003 16:11:19 -0500
Subject: [CHECKER] pcmcia user-pointer dereference
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: David Hinds <dhinds@sonic.net>
To: linux-kernel@vger.kernel.org, Junfeng Yang <yjf@stanford.edu>
From: Hollis Blanchard <hollisb@us.ibm.com>
Content-Transfer-Encoding: 7bit
Message-Id: <17ACEE5A-921A-11D7-B8B8-000A95A0560C@us.ibm.com>
X-Mailer: Apple Mail (2.552)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 May 2003 Junfeng wrote:
>
> here is a detailed explanation in case the warnning itself isn't clear:
>
> 1. ds_ioctl is assigned to file_operantions.ioctl
> so its argument 'arg' is tainted. verify_area are
> also called on 'arg', which confirms.
>
> 2. copy_from_user (&buf, arg, _) copies in the content of arg
>
> 3. buf.win_info.handle is thus a user provided pointer.
>
> 4. pcmcia_get_mem_page dereferences its first parameter, in this case
> buf.win_info.handle

I contacted David Hinds about this; the behavior is by design. User 
space passes in a pointer to a kernel data structure, and the kernel 
verifies it by checking a magic number in that structure.

It seems possible to perform some activity from user space to get the 
magic number into (any) kernel memory, then iterate over kernel space 
by passing pointers to the pcmcia ds_ioctl() until you manage to 
corrupt something. But I'm not really a security guy...

-- 
Hollis Blanchard
IBM Linux Technology Center

