Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750872AbWFBUD6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750872AbWFBUD6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 16:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885AbWFBUD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 16:03:58 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:35311 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750867AbWFBUD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 16:03:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=XZVxtpLgGPSemboxTN6H1J4MFFYoEkAPc7ciR2WmEGlb3WYMzoMvpZyn72xroxjsXwhYAIxulWpc8OBXsD5yt8AhIMssezBSXc5FmyS1qk4AF7ST19iPUJpAI2WHiwQ39cdEPlykxQd/Cwq3fvJPrsQrF8TmQqfGNpENg+ICUpM=
Message-ID: <69a7202e0606021303t5354c33et821d2e44c3c62814@mail.gmail.com>
Date: Fri, 2 Jun 2006 16:03:56 -0400
From: "Carl Spalletta" <cspalletta@gmail.com>
Reply-To: cspalletta@adelphia.net
To: linux-kernel@vger.kernel.org
Subject: How does remote NFS open keep local SB in memory after umount?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

neilb@cse.unsw.edu.au wrote:

>  mount the filesystem over nfs
>  open a file several directories deep. e.g.
>      exec 3< /mnt/cramfs/my/long/path/name/file
>  unmount/remount the file system on the server:
>       exportfs -avu
>       umount /test
>       mount /test
>       exportfs -av

>   try to read from the file

So my question is this: what keeps the superblock of the filesystem
on the server from going away when unmounted (assuming it was the last
instance). I have been unable to locate in the code where any reference
counts pertaining to the superblock are incremented as a result of
opening a file.

Obviously however, something must keep the superblock from going away or
the final read would fail.  Even if by some means the inode was preserved
across mounts the field inode->i_sb would become invalid if the original
SB was destroyed.
