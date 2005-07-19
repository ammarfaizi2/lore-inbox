Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261379AbVGSQ63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261379AbVGSQ63 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 12:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261599AbVGSQ63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 12:58:29 -0400
Received: from web26907.mail.ukl.yahoo.com ([217.146.176.96]:6766 "HELO
	web26907.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261379AbVGSQ60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 12:58:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=lq2kIOs4gnf4s+xpWgN9xwtbp0EmyNnCArd3KvTWI50OAJBrgZ9vblV5MiySfwzHlgV/NHh4R2r/kfGYMCJLU/BYwv9Ftk8mCWeidPWwgNCKmBGxj+0YO3lqxGzXJ2S7fuEz/128lr9SO6EsqKi5Kk7K1LxiLGOoywFhE08WKcs=  ;
Message-ID: <20050719165821.96544.qmail@web26907.mail.ukl.yahoo.com>
Date: Tue, 19 Jul 2005 18:58:21 +0200 (CEST)
From: Etienne Lorrain <etienne_lorrain@yahoo.fr>
Subject: [RFD] FAT robustness
To: linux-kernel@vger.kernel.org, machida@sm.sony.co.jp
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'd like to have a discussion about FAT robustness.
> Please give your thought, comments and related issues.

  What I would like is to treat completely differently writing to
 FAT (writing to a removeable drive) which need a complete "mount",
 and just reading quickly a file (a standard use of removeable devices).

 Basically, to read you would not need to mount the partition, just
 read /readfs/fd1 which uses two or three functions accessing /dev/fd1
 in raw mode to read the filesystem descriptor and the root directory.
 Same for /readfs/cdrom and /readfs/sda4 (USB drive).
 The only cache would be the one provided by /dev/fd1 - a kind of
 mount read-only at each file opening.

 This system would be disabled if the partition is already mounted
 read/write somewhere - but as long as you do not try to write to
 a removeable disk you can extract it at any time.

  The two or three function I am talking of are located in Gujin
 "fs.c" file to access read-only FAT12/16/32, EXT2/3 and ISOFS
 ( http://gujin.org ). Just few kilobytes - and some source
 modifications for that use.

  Etienne.


	

	
		
___________________________________________________________________________ 
Appel audio GRATUIT partout dans le monde avec le nouveau Yahoo! Messenger 
Téléchargez cette version sur http://fr.messenger.yahoo.com
