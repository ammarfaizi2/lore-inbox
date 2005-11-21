Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750993AbVKUVjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993AbVKUVjP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 16:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751006AbVKUVjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 16:39:15 -0500
Received: from web34115.mail.mud.yahoo.com ([66.163.178.113]:38745 "HELO
	web34115.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750993AbVKUVjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 16:39:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=3U1aQPp6NuEt2rh1DSX1esKtuuyHQSErdNnW/4f/HcUi0EvdofDKZQa7KZpDL652F1QlnlWR/Deo6G+AtcvtTS1jrOMgFUde+VoO51ipEV163HtrRJZaAWgZjXt0fnlmo6LMVSBstdzD0ZNGq6oo12JgRvvP38+W/YJQA1kLtO8=  ;
Message-ID: <20051121213913.61220.qmail@web34115.mail.mud.yahoo.com>
Date: Mon, 21 Nov 2005 13:39:12 -0800 (PST)
From: Kenny Simpson <theonetruekenny@yahoo.com>
Subject: Re: infinite loop? with mmap, nfs, pwrite, O_DIRECT
To: Andrew Morton <akpm@osdl.org>
Cc: cel@citi.umich.edu, trond.myklebust@fys.uio.no,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051121123950.5afadab9.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With gentle beating by a clue-stick from Andrew.. I can run the same test on ext3...

ext3 is happy...

open("/data/foo", O_RDWR|O_CREAT|O_TRUNC|O_DIRECT|O_LARGEFILE, 0666) = 3
pwrite(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4096, 4299161600) = 4096
mmap2(NULL, 2097152, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0x100200) = 0xb7c7f000
pwrite(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4096, 4301258752) = 4096
exit_group(0)                           = ?


but NFS is still unhappy....

open("/mnt/bar", O_RDWR|O_CREAT|O_TRUNC|O_DIRECT|O_LARGEFILE, 0666) = 3
pwrite(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4096, 4299161600) = 4096
mmap2(NULL, 2097152, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0x100200) = 0xb7bc2000
pwrite(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4096, 4301258752  <never
returns>


-Kenny



	
		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
