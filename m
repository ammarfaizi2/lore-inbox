Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261962AbVCTCAk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261962AbVCTCAk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 21:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261984AbVCTCAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 21:00:39 -0500
Received: from quechua.inka.de ([193.197.184.2]:22157 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261962AbVCTCAc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 21:00:32 -0500
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] crash after fsync causing serious FS corruptions (ext2, 2.6.11)
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <20050308123109.GA7005@thunk.org>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.6-20040906 ("Baleshare") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1DCpjy-0005SE-00@calista.eckenfels.6bone.ka-ip.net>
Date: Sun, 20 Mar 2005 03:00:30 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ted,

In article <20050308123109.GA7005@thunk.org> you wrote:
> Should we fix it today?  Given that we have ext3, I'd probably answer
> no.  It's a known property of ext2; we've lived with it for over ten
> years, and to add this would just slow down ext2 (which gets used
> often as benchmark standard to aspire to), and make the ext2 codebase
> more complicated.

I am not too deep into FS design, however I have heared from some admins of
a pretty busy server, that the allocation method of placinf file content
close to the directories cause a lot of fragmentation there. So I wonder if
an simple change in allocation policy could lower the problems with the
fragmentation and (especially) lower the chance of blocks beeing reused too
often.

I might be able to get  the patch, however I am not sure if it will solves
or lowers the problem the checker group found.

The performance impact of such a changed allocation policy is, however on
the given system positive (due to decreased fragmentation).

BTW: I was not directly involved here in the decision process which FS to
use, however I am sure it is both related to performance and recoverability.
Because all recent (journalling) filesystems XFS, Reiser and ext3 very often
failed with big data loss in that environment, whereas ext2 could most often
be recovered very well. So from my point of you ext2 should not be
desupported.
 
Greetings
Bernd

PS: i have a before/after screenshot of the filesystem in this german
article. It is a pop3 server:
http://itblog.eckenfels.net/archives/8-Fragmentierung.html
