Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265667AbTBTQV4>; Thu, 20 Feb 2003 11:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265670AbTBTQV4>; Thu, 20 Feb 2003 11:21:56 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:60040 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S265667AbTBTQVz>; Thu, 20 Feb 2003 11:21:55 -0500
Importance: Normal
Sensitivity: 
Subject: Re: cifs leaks memory like crazy in 2.5.61
To: Martin Josefsson <gandalf@wlug.westbo.se>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.4a  July 24, 2000
Message-ID: <OF566C3F49.C8CA5594-ON87256CD3.0058B0B3@us.ibm.com>
From: Steven French <sfrench@us.ibm.com>
Date: Thu, 20 Feb 2003 10:28:07 -0600
X-MIMETrack: Serialize by Router on D03NM123/03/M/IBM(Release 6.0 [IBM]|December 16, 2002) at
 02/20/2003 09:31:51
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





Hadn't run into this - I had been focusing on the readahead and write page
improvements (which have improved especially write performance
spectacularly) and also have just fixed a problem with redundant lookups of
directory inodes but had not been doing readdir (cifs
Trans2FindFirst/Trans2FindNext) testing recently.  I just did - and the
situation looks worse than you describe and probably related to what you
are running into. I found a readdir test case that hangs my post 2.5.62
system pretty fast and the last two unrelated cifs changesets don't fix it.
The cifs readdir code needed some rework anyway - I will crawl through it
today.  Thanks for finding this.

>kmem_cache_destroy: Can't free all objects e8eefd00
>cifs_destroy_request_cache: error not all structures were freed
>
>Is this a known problem?

Steve French
Senior Software Engineer
Linux Technology Center - IBM Austin
phone: 512-838-2294
email: sfrench@us.ibm.com

