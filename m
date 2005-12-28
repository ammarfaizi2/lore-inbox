Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932474AbVL1FHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932474AbVL1FHT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 00:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbVL1FHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 00:07:19 -0500
Received: from ms-smtp-03-smtplb.tampabay.rr.com ([65.32.5.133]:44507 "EHLO
	ms-smtp-03.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S1751134AbVL1FHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 00:07:18 -0500
Message-ID: <43B21D84.2010807@cfl.rr.com>
Date: Wed, 28 Dec 2005 00:07:16 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051010)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: UDF ignores gid uid and umask options
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that the UDF filesystem ignores the gid uid and umask mount
options and uses the values in the filesystem instead.  I searched
around and found a bug reported to debian last year about this, but it
was never resolved.

Going by what that bug says, if you create a udf filesystem without rock
ridge extensions with mkisofs -udf, then the kernel accepts the uid,
gid, and umask options, but with rock ridge extensions, it ignores those
options.  I have been messing around with using the packet writing
interface and mkudffs to set up a read/write udf filesystem on a cdrw
and I ran into this problem because my non root account can't access the
disk.

It is nice that UDF is capable of storing the permissions on disk, but
when values are specified on the mount options, they should override
those on the disk.  For removable media using the stored uid and gid on
the disk is detrimental because they aren't going to have the correct
meaning when you insert the media into another computer, so it is
important to be able to override them.

Am I correct in thinking this is a bug, or is there already a workaround
I haven't found?


P.S. Please CC me on replies as I am not subscribed to the list ( would
blow my pop quota )


