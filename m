Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263650AbTDDLfn (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 06:35:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263661AbTDDLfk (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 06:35:40 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:35736 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S263650AbTDDLea (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 06:34:30 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: David Jander <david.jander@protonic.nl>
Date: Fri, 4 Apr 2003 13:45:41 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] ncpfs, kernel 2.4.18
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <64319A7E14@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  4 Apr 03 at 13:24, David Jander wrote:

> This fixes a bug with Novell Netware Servers (in my case 3.12) sending error 
> messages (and annoying beeps) to the console each time a linux client 
> accesses de root directory of a volume. Please comment !
> Please send replies with CC to me, since I am not subscribed to lkml.

What they say? It is completely legal to use NULL path in ncp_obtain_info,
and in reality ncp_obtain_mtime() in fs/ncpfs/dir.c uses NULL path 
explicitly (and it also checks for 'ncp_is_server_root(inode)', at least
in 2.5.66 and 2.4.19). See ncp_add_handle_path, it contains code which
converts NULL path to no path at all.

Do not you just have loaded some misguided antivirus software on your server? 
ncpfs uses inode based addressing scheme, where files are accessed by their 
numbers instead of name. Only thing which accesses files by name are 
validating functions, for converting name to number, and unlink (because of 
4.x servers crash when unlink by inode is invoked on NFS namespace).
                                                        Petr Vandrovec
                                                        

