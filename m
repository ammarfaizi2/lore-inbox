Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261924AbUKCV4t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261924AbUKCV4t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 16:56:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbUKCVxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 16:53:38 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:39593 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261924AbUKCVvv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 16:51:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=uiY+rzcbnKX+r0Nk+JYqLtGC6/iAIVe4zhMdUU7koXOmKe8zqVB1fvHkZHhUltun6E3TQLDLakjejSNStnKsJcruCHiUT0sv/Cpnv6Sht/bLv3LKEVQES3Zr+svbkmmwzP5Ylyiyt75Ng8n+yr5qLSMvUpBgj9+A7EsGQUbLdDk=
Message-ID: <6707bb6404110313514013794e@mail.gmail.com>
Date: Wed, 3 Nov 2004 14:51:50 -0700
From: mark slutz <mystuff.mark@gmail.com>
Reply-To: mark slutz <mystuff.mark@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: mmap going to wrong physical address
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am writting an application that needs control over large (1gig+)
portions of contiguous memory. I am currently doing this by using
mem=1024m during boot. My system is a dual opteron with 5 gig of
memory. In my program I have

if ((fd=open("/dev/mem", O_RDWR))<0)
{
perror("open");
exit(-1);
}


PtrMemoryBase = (void *) mmap64(
NULL,
size,
PROT_READ | PROT_WRITE,
MAP_FILE | MAP_SHARED,
fd,
base );

size = 1MB

I also have -D_FILE_OFFSET_BITS=64.

If base is between 1 and 3 gig the process works fine. When base is 4
gig + the mmap64 works but the memory does not seem to be mapped to
the base location. I write a pattern to PtrMemoryBase then have my
hardware start doing DMA transfers from the base address but I do not
get the data I wrote to PtrMemoryBase.

Thanks for any help
Mark
