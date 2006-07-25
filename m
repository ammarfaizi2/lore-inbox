Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030252AbWGYX31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030252AbWGYX31 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 19:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030253AbWGYX31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 19:29:27 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:32673 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1030252AbWGYX30
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 19:29:26 -0400
Date: Tue, 25 Jul 2006 17:29:24 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hans Reiser <reiser@namesys.com>,
       Alexander Viro <viro@zeniv.linux.org.uk>,
       Al Viro <viro@ftp.linux.org.uk>, reiserfs-dev@namesys.com,
       reiserfs-list@namesys.com
Subject: Re: possible recursive locking detected - while running fs operations in loops - 2.6.18-rc2-git5
Message-ID: <20060725232924.GU6452@schatzie.adilger.int>
Mail-Followup-To: Jesper Juhl <jesper.juhl@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Hans Reiser <reiser@namesys.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Al Viro <viro@ftp.linux.org.uk>, reiserfs-dev@namesys.com,
	reiserfs-list@namesys.com
References: <9a8748490607251516j1433306ek9c64cc84c0838f7b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490607251516j1433306ek9c64cc84c0838f7b@mail.gmail.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 26, 2006  00:16 +0200, Jesper Juhl wrote:
> What I did to provoke it was to run 6 different xterms (with a bash
> shell) with the following loops in them in a test directory that was
> initially empty :
> 
> xterm1:   while true; do mkdir a; done
> xterm2:   while true; do rmdir a; done
> xterm3:   while true; do touch a/foo; done
> xterm4:   while true; do find .; done
> xterm5:   while true; do sync; sleep 1; done
> xterm6:   while true; do rm -r a; done

See racer test at ftp.lustre.org/pub/benchmarks/racer-lustre.tar.gz

It does the above, but a bunch more things and is a truly pathalogical
test script that does lots of "stupid user tricks", unlike normal tests
which are only doing operations that expect to be successful.

PS - during the racer.sh test run "rm" is known to segfault after hitting
     an internal assertion, nobody is sure why.
PPS- I don't know who wrote this program, it was originally posted by
     someone not the author to linux-fsdevel or something.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

