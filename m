Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262708AbVAFDiy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262708AbVAFDiy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 22:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262709AbVAFDiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 22:38:54 -0500
Received: from fw.osdl.org ([65.172.181.6]:10189 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262708AbVAFDiw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 22:38:52 -0500
Date: Wed, 5 Jan 2005 19:38:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: Zhonglin Zhang <zhonglinzh@mobilesoft.com.cn>
Cc: linux-kernel@vger.kernel.org
Subject: Re: a little improvement  for vmalloc
Message-Id: <20050105193827.12d83341.akpm@osdl.org>
In-Reply-To: <1104981532.628.10.camel@milo>
References: <1104981532.628.10.camel@milo>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zhonglin Zhang <zhonglinzh@mobilesoft.com.cn> wrote:
>
> In FUNCTION __vmalloc ,
> 
>  There is a statement;
> 
>  if (!size || (size >> PAGE_SHIFT) > num_physpages)
>          return NULL;

Probably the second part of the test should be removed.  If the requested
area size is

a) less than the size of the vmalloc arena and

b) more than the number of allocatable pages

then yes, the machine will have a ton of trouble allocating the memory and
will actually lock up.

But the only way that will happen is if some code is made to do a large
number of smaller vmallocs.  Nobody does a huge single vmalloc like that.

