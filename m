Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288921AbSCGA1n>; Wed, 6 Mar 2002 19:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288801AbSCGA1X>; Wed, 6 Mar 2002 19:27:23 -0500
Received: from mnh-1-21.mv.com ([207.22.10.53]:61963 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S288830AbSCGA1T>;
	Wed, 6 Mar 2002 19:27:19 -0500
Message-Id: <200203070028.TAA05380@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: pollard@tomcat.admin.navo.hpc.mil (Jesse Pollard),
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] Arch option to touch newly allocated pages 
In-Reply-To: Your message of "Wed, 06 Mar 2002 17:33:11 GMT."
             <E16ifHr-0007XT-00@the-village.bc.nu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 06 Mar 2002 19:28:46 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

alan@lxorguk.ukuu.org.uk said:
> and also enforcing a "must be able to fill in the pages between start
> and end of file" for the tmpfs file size itself is not hard from
> inspection.

So if I mapped a single page from file offset 65M on a 64M tmpfs, that would 
fail?

I'd prefer maps to fail when they make the total maps exceed the tmpfs limit.

Then I can map in smaller chunks, PAGE_SIZE if necessary.  That has the 
disadvantage that the vmas in the host would be even uglier than they are
now because we don't have vma merging any more.

UML would still need that page_alloc hook, except it would map the allocated
pages instead of touching them.

				Jeff

