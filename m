Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262279AbUFAPXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbUFAPXa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 11:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbUFAPXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 11:23:16 -0400
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:21258 "EHLO
	pumpkin.fieldses.org") by vger.kernel.org with ESMTP
	id S265084AbUFAPVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 11:21:55 -0400
Date: Tue, 1 Jun 2004 11:21:53 -0400
To: Thomas Babut <tb@dsc-shop.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS: Problem with user and group IDs
Message-ID: <20040601152153.GB31631@fieldses.org>
References: <40BC997B.2070505@dsc-shop.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40BC997B.2070505@dsc-shop.de>
User-Agent: Mutt/1.5.6i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2004 at 04:58:03PM +0200, Thomas Babut wrote:
> I've got a problem with 'squashing' user and group IDs under NFS.
> 
> On the NFS Server there is the directory /data/test with owner ID 1011 
> and group ID 100.
> 
> Here is the /etc/exports file on the NFS server:
> /data/test 
> 172.16.10.1(ro,root_squash,all_squash,anon_uid=65534,anongid=65534)
> 
> On the client side I mount it with the command:
> mount -t nfs 172.16.10.2:/data/test /mnt/test
> 
> After it has been successfully mounted, the directory on the client 
> system has the owner ID 1011 and group ID 100, like on the server.
> 
> But the expected result for me is, that on the client system the 
> directory has owner ID 65534 and group ID 65534 like it has been set in 
> the /etc/exports file on the server.

Root-squashing only modifies the way your client credentials are seen on
the server; it isn't applied to uid's that are returned to the client
e.g.  when listing a directory.  So if you create a new file as a user
on the client, that new file will be given anonymous uid and gid.  But
if you "ls" a directory, the uid's you see will be unaffected by
squashing.

--Bruce Fields
