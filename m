Return-Path: <linux-kernel-owner+w=401wt.eu-S965070AbXADSk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965070AbXADSk6 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 13:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965071AbXADSk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 13:40:58 -0500
Received: from wx-out-0506.google.com ([66.249.82.226]:49534 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965070AbXADSk5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 13:40:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:mime-version:content-type:content-transfer-encoding:x-mailer:in-reply-to:x-mimeole:thread-index;
        b=QKZOeLxQN1Q9du+qYgOf7xG1B1+KnsmvNsIlaGtxqfDMYCQKgn1bJSf2Z80SV8uqU2K5LdAdOYGd9E3Bncu1L9J0B48MTE5ps4IyLLHR+RPRozJaBO80b4SH/W0jIpqbv+echER8SPeM97aDaX0zvSQ2uraJ4W1FXtpL4l+lADU=
From: "Hua Zhong" <hzhong@gmail.com>
To: "'Hugh Dickins'" <hugh@veritas.com>, "'Bill Davidsen'" <davidsen@tmr.com>
Cc: "'Linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: open(O_DIRECT) on a tmpfs?
Date: Thu, 4 Jan 2007 10:41:06 -0800
Message-ID: <003f01c7302f$e72164b0$0200a8c0@nuitysystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <Pine.LNX.4.64.0701041653250.12920@blonde.wat.veritas.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3028
thread-index: AccwI3sQionQVbnzQ3+CSe3iZS2h9AAC59+A
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I see that as a good argument _not_ to allow O_DIRECT on 
> tmpfs, which inevitably impacts cache, even if O_DIRECT were 
> requested.
> 
> But I'd also expect any app requesting O_DIRECT in that way, 
> as a caring citizen, to fall back to going without O_DIRECT 
> when it's not supported.

According to "man 2 open" on my system:

       O_DIRECT
              Try to minimize cache effects of the I/O to and from this file.
              In  general  this will degrade performance, but it is useful in
              special situations, such as  when  applications  do  their  own
              caching.  File I/O is done directly to/from user space buffers.
              The I/O is synchronous, i.e., at the completion of the  read(2)
              or write(2) system call, data is guaranteed to have been trans-
              ferred.  Under Linux 2.4 transfer sizes, and the  alignment  of
              user  buffer and file offset must all be multiples of the logi-
              cal block size of the file system. Under Linux 2.6 alignment to
              512-byte boundaries suffices.
              A semantically similar interface for block devices is described
              in raw(8).

This says nothing about (probably disk based) persistent backing store. I don't see why tmpfs has to conflict with it.

So I'd argue that it makes more sense to support O_DIRECT on tmpfs as the memory IS the backing store.

And EINVAL isn't even a very specific error.

Hua

