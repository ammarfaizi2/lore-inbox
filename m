Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266679AbUIVTJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266679AbUIVTJv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 15:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266687AbUIVTJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 15:09:51 -0400
Received: from open.hands.com ([195.224.53.39]:8879 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S266679AbUIVTIY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 15:08:24 -0400
Date: Wed, 22 Sep 2004 20:19:31 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: linux-kernel@vger.kernel.org
Subject: hur hur.  fusexmp (userspace fs) + autofs + mount --rbind equals BLURP
Message-ID: <20040922191931.GD7308@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-hands-com-MailScanner-SpamScore: s
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

anybody scared of ugly usage of linux kernel modules should look away,
_right_ now :)

... that having been said, this is quite a problem for mount --rbind.

repro setup:

1) install fuse.
2) install autofs.
3) write an /etc/autofs.media with a mountpoint /media/floppy
4) mkdir /mnt/test and run fusexmp /mnt/test &
5) mkdir /home/yourhome/media and mount --rbind /media /home/yourhome/media
6) attempt to access /mnt/test/home/yourhome/media/floppy

... and watch the little bits of kernel segfaults go _flying_ by...

this is with 2.6.8[.1-selinux1].

some clues as to there-might-be-a-problem-with-rbind are that the
problem does _not_ occur if you access /home/yourhome/media/floppy,
and a second clue is that if there are any subdirectories in /media
prior to running autofs, with a bit of dickering about with the
order of the above repro setup it's possible to _see_ those subdirectories
_even_ though you've done a mount --rbind.

i think i saw this occur when i swapped stages 4) and 5) above.

l.

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />

