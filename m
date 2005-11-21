Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932333AbVKUXOv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbVKUXOv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 18:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932461AbVKUXOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 18:14:51 -0500
Received: from web34114.mail.mud.yahoo.com ([66.163.178.112]:60847 "HELO
	web34114.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932333AbVKUXOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 18:14:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=n8k38kB8KP45nek3BE/XrmI4x2NDD0X4rtjhNVgh1UBVBYrJfiuRbGeDJS6SUVklrXcnytsA+xqwyay5yEMQCUHyEdvsIm7Tr88fCCPB5AU0pvfLfKmyhQMsiZgwA3eEkwgYFn69tVFinfJbZN3aID3jpMrysm64LrQ4iz2LJtg=  ;
Message-ID: <20051121231449.92787.qmail@web34114.mail.mud.yahoo.com>
Date: Mon, 21 Nov 2005 15:14:49 -0800 (PST)
From: Kenny Simpson <theonetruekenny@yahoo.com>
Subject: Re: infinite loop? with mmap, nfs, pwrite, O_DIRECT
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andrew Morton <akpm@osdl.org>, cel@citi.umich.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <1132612974.8011.12.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> Ah... It is the pwrite() _after_ the call to mmap() that fails....
> 
> OK, does the following patch fix it?

YES!

open("/mnt/bar", O_RDWR|O_CREAT|O_TRUNC|O_DIRECT|O_LARGEFILE, 0666) = 3
pwrite(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4096, 4299161600) = 4096
mmap2(NULL, 2097152, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0x100200) = 0xb7c26000
pwrite(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4096, 4301258752) = 4096
exit_group(0)                           = ?

I'll re-run my original test(s) tomorrow.
Thanks again!

-Kenny



		
__________________________________ 
Yahoo! FareChase: Search multiple travel sites in one click.
http://farechase.yahoo.com
