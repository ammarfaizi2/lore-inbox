Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262491AbTIUSIo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 14:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262493AbTIUSIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 14:08:44 -0400
Received: from 12-229-144-126.client.attbi.com ([12.229.144.126]:38283 "EHLO
	waltsathlon.localhost.net") by vger.kernel.org with ESMTP
	id S262491AbTIUSIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 14:08:43 -0400
Message-ID: <3F6DE929.4040904@comcast.net>
Date: Sun, 21 Sep 2003 11:08:41 -0700
From: Walt H <waltabbyh@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030914
X-Accept-Language: en-us
MIME-Version: 1.0
To: Walt H <waltabbyh@comcast.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Linux XFS Mailing List <linux-xfs@oss.sgi.com>
Subject: Re: 2.6.0-test5-mm3 & XFS FS Corruption (or not?)
References: <3F6DC819.8060003@comcast.net>
In-Reply-To: <3F6DC819.8060003@comcast.net>
X-Enigmail-Version: 0.76.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a follow-up to my earlier post:

I've put in the xfs code from mm2 into the mm3 tree and all files get
copied and I can manually copy the fstab.backup file afterward. I
realized that the "rebuilding directory inode 256" was the lost+found
directory, which contained 4 old zero length files. That was the key.
XFS under -mm2 doesn't care about old lost+found directories, while -mm3
does. If I removed the source lost+found/ and retried rsync's with -mm3,
it finishes fine and I can copy fstab files. Adding a bogus lost+found
dir with any file in it at the source, and retrying the rsync will lead
to a state where I can't overwrite the existing /etc/fstab file at the
end. So it doesn't look like there's actually any filesystem corruption,
just a strange bug. Hope that helps,

-Walt

