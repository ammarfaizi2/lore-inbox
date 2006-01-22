Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751326AbWAVTvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbWAVTvG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 14:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWAVTvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 14:51:06 -0500
Received: from uproxy.gmail.com ([66.249.92.193]:56143 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751326AbWAVTvF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 14:51:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=LNMxht1L0dJ1K7cCsiWGx+5qHSdQf+3vQ7BYHvfyO2DSGiACMW4PLO3kp+ByiLm4I6h+voAhSE31VG1aTb/IFbvzoAmFc/F6sBa8HhnrJh9KI9j/8X5qXlOQz63j+xtgMSVgVDJi32vLZC0MUIcNTil+3lZ0FKfChDv5xRvMxxg=
Date: Sun, 22 Jan 2006 20:50:39 +0100
From: Diego Calleja <diegocg@gmail.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: nigelenki@comcast.net, linux-kernel@vger.kernel.org
Subject: Re: soft update vs journaling?
Message-Id: <20060122205039.e8842bae.diegocg@gmail.com>
In-Reply-To: <20060122093144.GA7127@thunk.org>
References: <43D3295E.8040702@comcast.net>
	<20060122093144.GA7127@thunk.org>
X-Mailer: Sylpheed version 2.1.9 (GTK+ 2.8.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Sun, 22 Jan 2006 04:31:44 -0500,
Theodore Ts'o <tytso@mit.edu> escribió:


> One major downside with Soft Updates that you haven't mentioned in
> your note, is that the amount of complexity it adds to the filesystem
> is tremendous; the filesystem has to keep track of a very complex
> state machinery, with knowledge of about the ordering constraints of
> each change to the filesystem and how to "back out" parts of the
> change when that becomes necessary.


And FreeBSD is implementing journaling for UFS and getting rid of 
softupdates [1]. While this not proves that softupdates is "a bad idea",
i think this proves why the added sofupdates complexity doesn't seem
to pay off in the real world. 

[1]: http://lists.freebsd.org/pipermail/freebsd-hackers/2004-December/009261.html

"4.  Journaled filesystem.  While we can debate the merits of speed and
data integrety of journalling vs. softupdates, the simple fact remains
that softupdates still requires a fsck run on recovery, and the
multi-terabyte filesystems that are possible these days make fsck a very
long and unpleasant experience, even with bg-fsck.  There was work at
some point at RPI to add journaling to UFS, but there hasn't been much
status on that in a long time.  There have also been proposals and
works-in-progress to port JFS, ReiserFS, and XFS.  Some of these efforts
are still alive, but they need to be seen through to completion"
