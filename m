Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266344AbUIALxW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266344AbUIALxW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 07:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266249AbUIALxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 07:53:04 -0400
Received: from smtp100.rog.mail.re2.yahoo.com ([206.190.36.78]:46180 "HELO
	smtp100.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S266244AbUIALvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 07:51:38 -0400
In-Reply-To: <413578C9.8020305@namesys.com>
To: Hans Reiser <reiser@namesys.com>
Subject: Re: silent semantic changes with reiser4
Cc: ninja@slaphack.com, vonbrand@inf.utfsm.cl, pavel@ucw.cz,
       jamie@shareable.org, cw@f00f.org,
       viro@parcelfarce.linux.theplanet.co.uk, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com, zam@namesys.com,
       torvalds@osdl.org
X-Mailer: BeMail - Mail Daemon Replacement 2.3.1 Final
From: "Alexander G. M. Smith" <agmsmith@rogers.com>
Date: Wed, 01 Sep 2004 07:51:33 -0400 EDT
Message-Id: <216111536359-BeMail@cr593174-a>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote on Wed, 01 Sep 2004 00:22:49 -0700:
> Making "hard links only link to the file aspect of the file-directory
> duality, and persons who want to link to the directory aspect must use
> symlinks" seems to solve this.  If we want to use the Alexander Smith
> solution to cycle detection, and allow hard links to directories, then
> we must make sure that for the hard linked entity, there is a single
> lock for it somewhere (e.g. the directory inode) that can be taken.

Oddly enough that's what I did in my RAM file system.  No matter how
the file/directory node is found (the path can lead through different
parents), it has a unique ID and a corresponding single lock for it.

Rename/delete goes and locks all the nodes that might change parents
and/or children, then it does its operations (though it has to watch
out for deadlocks, which are unavoidable when two rename/deletes both
sneak up on the same file by different paths).

- Alex
