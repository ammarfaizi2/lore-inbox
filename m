Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272198AbRIFSLS>; Thu, 6 Sep 2001 14:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272261AbRIFSLI>; Thu, 6 Sep 2001 14:11:08 -0400
Received: from cc853160-b.vron1.nj.home.com ([24.10.112.73]:6918 "EHLO
	tela.bklyn.org") by vger.kernel.org with ESMTP id <S272198AbRIFSK6>;
	Thu, 6 Sep 2001 14:10:58 -0400
Date: Thu, 6 Sep 2001 14:11:17 -0400
From: Caleb Epstein <cae@bklyn.org>
To: linux-kernel@vger.kernel.org
Cc: nfs@lists.sourceforge.net
Subject: Spurious NFS ESTALE errors w/NFSv3 server, non-v3 client
Message-ID: <20010906141117.B7579@tela.bklyn.org>
Reply-To: Caleb Epstein <cae@bklyn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Organization: Brooklyn Dust Bunny Mfg.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	I belive this is new behavior in the latest (post-2.4.7 I
	believe) kernel NFS software:

	I have two machines, both running kernel 2.4.9, each of which
	act as both an NFS client and server to the other.  I am using
	the kernel NFS daemon and am exporting ext2fs filesystems on a
	local switched LAN.

	One box, called tela, was configured with NFSv3 enabled for
	both the client and server code.  The other box, hagrid, was
	not configured with any NFSv3 support enabled.  I just neglected
	to enable this in the configuration, its was not for any
	particular reason.

	When I did large file reads on hagrid (the v2 client), I
	would get spurious ESTALE errors on files which are totally
	static and haven't been
	touched in months.  Basically the filesystem contains a lot
	of audio files, and I was running md5 checksums on them from
	hagrid, while they were hosted on tela.

	When I checked the configuration on the client, and realized
	that NFSv3 was not enabled, I enabled it and rebuilt the
	kernel.  After a reboot, the errors disappeared and I can
	successfully read many gigabytes of data without a hiccup.

	Is this one of those "if it hurts then don't do that" kind of
	things, or is it the expected behavior?  I think I've had the
	two machines configured like this for several kernel
	revisions (2.4.0 onwards) and only noticed this behavior since
	I switched my server to 2.4.9 from 2.4.7.  It *may* have
	happened before and I didn't notice it, but I think this was
	introduced some time in 2.4.8 or later.

-- 
cae at bklyn dot org | Caleb Epstein | bklyn . org | Brooklyn Dust Bunny Mfg.
