Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263664AbUGIDDT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263664AbUGIDDT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 23:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263731AbUGIDDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 23:03:18 -0400
Received: from mail.telpin.com.ar ([200.43.18.243]:4238 "EHLO
	mail.telpin.com.ar") by vger.kernel.org with ESMTP id S263664AbUGIDDR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 23:03:17 -0400
Date: Fri, 9 Jul 2004 00:06:37 -0300
From: Alberto Bertogli <albertogli@telpin.com.ar>
To: linux-kernel@vger.kernel.org
Subject: Syncing a file's metadata in a portable way
Message-ID: <20040709030637.GB5858@telpin.com.ar>
Mail-Followup-To: Alberto Bertogli <albertogli@telpin.com.ar>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

I wanted to know if there was a common, portable way of syncing a given
file's metadata.

In particular, I just want to create a file with open() and be sure that
after some operation the file has been properly created and even if there
is a crash, it can be accessed (modulo internal disk caches and all that
stuff).

I know that fsync() provides only data guarantees, and even the manpage
says clearly that in order to sync metadata an "explicit fsync on the file
descriptor of the directory is also needed".

However, the O_DIRECTORY flag is Linux only, making this mechanism not
portable.

Is there a way of doing this in a portable way?

I know that under some filesystems with some mount options this can be
assured just by open() returning, or fsync() on the file, but I was
looking for a more general way to do it.


Also, according to SUSv3, "If _POSIX_SYNCHRONIZED_IO is defined, the
fsync() function shall force all currently queued I/O operations
associated with the file". This seems to imply that metadata gets synced
too, or at least I think "I/O operations associated with the file" can be
interpreted to include metadata.

However, based on a quick grep at the glibc code, it seems that the flag
doesn't make a difference in this case.

Is this really used or enforced?


Thanks a lot,
		Alberto


