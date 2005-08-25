Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964873AbVHYI03@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964873AbVHYI03 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 04:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964875AbVHYI03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 04:26:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37781 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964873AbVHYI02 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 04:26:28 -0400
Date: Thu, 25 Aug 2005 01:24:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jan Blunck <j.blunck@tu-harburg.de>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RESEND] don't allow sys_readahead() on files opened
 with O_DIRECT
Message-Id: <20050825012440.66b61cca.akpm@osdl.org>
In-Reply-To: <4305D437.4000703@tu-harburg.de>
References: <4305D437.4000703@tu-harburg.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Blunck <j.blunck@tu-harburg.de> wrote:
>
> IMO sys_readahead() doesn't make sense if the file is opened with
> O_DIRECT, because the page cache is stuffed but never used. Therefore
> this patch changes that by letting the call return with -EINVAL.
> 

a) It doesn't hurt, it's just a bit of a silly thing to do.

b) posix_fadvise(POSIX_FADV_WILLNEED) should get the same treatment (and
   it's the preferred way of doing readahead).

c) O_DIRECT fd's should, as much as possible, offer the same ABI as
   buffered fd's.

d) The patch could break existing apps.
