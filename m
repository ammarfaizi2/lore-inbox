Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271380AbTHDFbe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 01:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271381AbTHDFbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 01:31:34 -0400
Received: from ms-smtp-02.texas.rr.com ([24.93.36.230]:44493 "EHLO
	ms-smtp-02.texas.rr.com") by vger.kernel.org with ESMTP
	id S271380AbTHDFbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 01:31:33 -0400
Message-ID: <3F2DEFA5.2010700@austin.rr.com>
Date: Mon, 04 Aug 2003 00:31:17 -0500
From: Steve French <smfrench@austin.rr.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: do_div considered harmful
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have made a change to fix this in fs/cifs/inode.c and a similar 
problem in fs/cifs/file.c
(and a change to fs/cifs/cifsfs.c to better match the blocksize bits and 
blocksize default).
It is (version 0.8.7 of the cifs vfs) in 
bk://cifs.bkbits.net/linux-2.5cifs and I am testing it now.

 >> Similarly, I find in fs/cifs/inode.c>
 >>          inode->i_blocks = do_div(findData.NumOfBytes, 
inode->i_blksize);
 >
 >This should be
 >
 >        int blocksize = 1 << inode->i_blkbits;
 >
 >         inode->i_blocks = (findData.NumOfBytes + blocksize - 1)
 >                                    >> inode->i_blkbits;

