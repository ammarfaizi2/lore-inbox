Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263550AbTENSLt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 14:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263567AbTENSLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 14:11:48 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:25276 "EHLO
	baldur.austin.ibm.com") by vger.kernel.org with ESMTP
	id S263550AbTENSLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 14:11:47 -0400
Date: Wed, 14 May 2003 13:24:25 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>
cc: mika.penttila@kolumbus.fi, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: Race between vmtruncate and mapped areas?
Message-ID: <108250000.1052936665@baldur.austin.ibm.com>
In-Reply-To: <20030514111748.57670088.akpm@digeo.com>
References: <154080000.1052858685@baldur.austin.ibm.com>
 <3EC15C6D.1040403@kolumbus.fi><199610000.1052864784@baldur.austin.ibm.com>
 <20030513181018.4cbff906.akpm@digeo.com>
 <18240000.1052924530@baldur.austin.ibm.com>
 <20030514103421.197f177a.akpm@digeo.com>
 <82240000.1052934152@baldur.austin.ibm.com>
 <20030514105706.628fba15.akpm@digeo.com>
 <99000000.1052935556@baldur.austin.ibm.com>
 <20030514111748.57670088.akpm@digeo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Wednesday, May 14, 2003 11:17:48 -0700 Andrew Morton <akpm@digeo.com>
wrote:

> I think it might be sufficient to re-check the page against i_size
> after IO completion in filemap_nopage().

It would definitely make the window a lot smaller, though it won't quite
close it.  To be entirely safe we'd need to recheck after we've retaken
page_table_lock.

Dave

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

