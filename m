Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262838AbTJPKs1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 06:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262839AbTJPKs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 06:48:27 -0400
Received: from smtprelay02.ispgateway.de ([62.67.200.157]:23744 "EHLO
	smtprelay02.ispgateway.de") by vger.kernel.org with ESMTP
	id S262838AbTJPKsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 06:48:23 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Eli Billauer <eli_billauer@users.sf.net>
Subject: Re: [RFC] frandom - fast random generator module
Date: Thu, 16 Oct 2003 12:45:59 +0200
User-Agent: KMail/1.5.4
References: <3F8E552B.3010507@users.sf.net>
In-Reply-To: <3F8E552B.3010507@users.sf.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310161245.59939.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 October 2003 10:22, Eli Billauer wrote:
> (3) I agree with both. And I use /dev/zero a lot. I know how to write a
> zero-generating application in user space.

There is a good reason for this: You can implement pages containing only
zeroes very efficiently in the kernel. You can map pages containing only
zeroes to a single physical page in the kernel (the ZERO_PAGE). You can
ignore the refcounting on this page and save precious cache flushes and
much more by doing this in the kernel.

Compare an application with memset() and mmaping of /dev/zero in
multiple processes, writing to only some of these pages later.

> (4) The module is small: 6kB of source code as a standalone module, and
> 2.3 kB of kernel memory.

That's a price worth as an "default to off" option. We have much more
seldom used stuff in the kernel and maintain it, which is a bigger mess
than this.


