Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbTENOtm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 10:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262393AbTENOtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 10:49:42 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:25678 "EHLO
	baldur.austin.ibm.com") by vger.kernel.org with ESMTP
	id S262373AbTENOti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 10:49:38 -0400
Date: Wed, 14 May 2003 10:02:10 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>
cc: mika.penttila@kolumbus.fi, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: Race between vmtruncate and mapped areas?
Message-ID: <18240000.1052924530@baldur.austin.ibm.com>
In-Reply-To: <20030513181018.4cbff906.akpm@digeo.com>
References: <154080000.1052858685@baldur.austin.ibm.com>
 <3EC15C6D.1040403@kolumbus.fi><199610000.1052864784@baldur.austin.ibm.com>
 <20030513181018.4cbff906.akpm@digeo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Tuesday, May 13, 2003 18:10:18 -0700 Andrew Morton <akpm@digeo.com>
wrote:

> That's the one.  Process is sleeping on I/O in filemap_nopage(), wakes up
> after the truncate has done its thing and the page gets instantiated in
> pagetables.
> 
> But it's an anon page now.  So the application (which was racy anyway)
> gets itself an anonymous page.

Which the application thinks is still part of the file, and will expect its
changes to be written back.  Granted, if the page fault occurred just after
the truncate it'd get SIGBUS, so it's clearly not a robust assumption, but
it will result in unexpected behavior.  Note that if the application later
extends the file to include this page it could result in a corrupted file,
since all the pages around it will be written properly.

Dave

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

