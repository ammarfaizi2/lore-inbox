Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262546AbTIUTsc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 15:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbTIUTsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 15:48:32 -0400
Received: from tolkor.SGI.COM ([198.149.18.6]:40911 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id S262546AbTIUTsa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 15:48:30 -0400
Subject: Re: 2.6.0-test5-mm3 & XFS FS Corruption (or not?)
From: Steve Lord <lord@sgi.com>
To: Walt H <waltabbyh@comcast.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux XFS Mailing List <linux-xfs@oss.sgi.com>
In-Reply-To: <3F6DE929.4040904@comcast.net>
References: <3F6DC819.8060003@comcast.net>  <3F6DE929.4040904@comcast.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 21 Sep 2003 14:48:15 -0500
Message-Id: <1064173697.2285.4.camel@laptop.americas.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-09-21 at 13:08, Walt H wrote:
> Just a follow-up to my earlier post:
> 
> I've put in the xfs code from mm2 into the mm3 tree and all files get
> copied and I can manually copy the fstab.backup file afterward. I
> realized that the "rebuilding directory inode 256" was the lost+found
> directory, which contained 4 old zero length files. That was the key.
> XFS under -mm2 doesn't care about old lost+found directories, while -mm3
> does. If I removed the source lost+found/ and retried rsync's with -mm3,
> it finishes fine and I can copy fstab files. Adding a bogus lost+found
> dir with any file in it at the source, and retrying the rsync will lead
> to a state where I can't overwrite the existing /etc/fstab file at the
> end. So it doesn't look like there's actually any filesystem corruption,
> just a strange bug. Hope that helps,
> 
> -Walt
> 

If I am correct, test5-mm3 contains a bad version of the xfs code, there
was a bug where the i_flags field was setup from an uninitialized stack
variable. mm3 came out during the two days this was in Linus's tree.
I had some very odd behavior with this code base, rm -r -f would try and
cd into files and other bizzare things, files could appear to be
immutable or append only or things they were not. This sounds like
similar behavior you that you saw. It is fixed in the latest code Linus
has.

Steve




