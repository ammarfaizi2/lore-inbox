Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267145AbTAPPba>; Thu, 16 Jan 2003 10:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267150AbTAPPba>; Thu, 16 Jan 2003 10:31:30 -0500
Received: from 216-42-72-144.ppp.netsville.net ([216.42.72.144]:37864 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id <S267145AbTAPPb2>;
	Thu, 16 Jan 2003 10:31:28 -0500
Subject: Re: [2.4] VFS locking problem during concurrent link/unlink
From: Chris Mason <mason@suse.com>
To: Oleg Drokin <green@namesys.com>
Cc: linux-kernel@vger.kernel.org, eazgwmir@umail.furryterror.org,
       viro@math.psu.edu, nikita@namesys.com
In-Reply-To: <20030116140015.A17612@namesys.com>
References: <20030116140015.A17612@namesys.com>
Content-Type: text/plain
Organization: 
Message-Id: <1042731580.31099.2195.camel@tiny.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 16 Jan 2003 10:39:41 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-01-16 at 06:00, Oleg Drokin wrote:
> Hello!
> 
>    Debugging reiserfs problem that can be demonstrated with script created by
>    Zygo Blaxell, I started to wonder if the problem presented is indeed reiserfs
>    fault and not VFS.
>    Though the Zygo claims script only produces problems on reiserfs, I am trying
>    it now myself on ext2 (which will take some time).
> 
>    Debugging shows that reiserfs_link is sometimes called for inodes whose
>    i_nlink is zero (and all corresponding data is deleted already).
>    So my current guess of what's going on is this:
> 

No, this is a reiserfs bug, since we schedule after doing link checks in
reiserfs_link and reiserfs_unlink.  I sent a patch to reiserfs dev a
while ago, I'll pull it out of the suse kernel and rediff against
2.4.20.

-chris


