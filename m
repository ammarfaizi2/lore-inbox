Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262831AbVCWGxg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262831AbVCWGxg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 01:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262829AbVCWGxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 01:53:35 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:48295 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262832AbVCWGxW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 01:53:22 -0500
Date: Wed, 23 Mar 2005 07:53:13 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jeff Moyer <jmoyer@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: unused 'size' assignment in filemap_nopage
In-Reply-To: <16960.37814.651437.634849@segfault.boston.redhat.com>
Message-ID: <Pine.LNX.4.61.0503230751370.21578@yvahk01.tjqt.qr>
References: <16960.37814.651437.634849@segfault.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>	size = (i_size_read(inode) + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
>	if (pgoff >= size)
>		goto outside_data_content;
>	...
>	if (size > endoff)
>		size = endoff;
>
>After this, size is not referenced.  So, either this potential reassignment
>of size is superfluous, or we are missing some other code later on in the
>function.  If it is the former, I've attached a patch which will remove the
>code.

Only if you can make sure the SIZE will never be bigger than ENDOFF.
What you see here is basically:
  size = min(endoff, (i_size_read...))
With a pgoff>=size somewhere ;)


Jan Engelhardt
-- 
