Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262574AbTCMTeC>; Thu, 13 Mar 2003 14:34:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262575AbTCMTeB>; Thu, 13 Mar 2003 14:34:01 -0500
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:3325 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id <S262574AbTCMTeA>; Thu, 13 Mar 2003 14:34:00 -0500
Date: Thu, 13 Mar 2003 12:44:20 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: "Theodore Ts'o" <tytso@mit.edu>, sct@redhat.com,
       Alex Tomas <bzzz@tmi.comex.ru>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net, Andrew Morton <akpm@digeo.com>
Subject: Re: [Ext2-devel] [PATCH] concurrent block allocation for ext2 against 2.5.64
Message-ID: <20030313124420.F12806@schatzie.adilger.int>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>, sct@redhat.com,
	Alex Tomas <bzzz@tmi.comex.ru>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	ext2-devel@lists.sourceforge.net, Andrew Morton <akpm@digeo.com>
References: <m3el5bmyrf.fsf@lexa.home.net> <20030313103948.Z12806@schatzie.adilger.int> <20030313192354.GA4777@think.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030313192354.GA4777@think.thunk.org>; from tytso@mit.edu on Thu, Mar 13, 2003 at 02:23:54PM -0500
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 13, 2003  14:23 -0500, Theodore Ts'o wrote:
> On Thu, Mar 13, 2003 at 10:39:48AM -0700, Andreas Dilger wrote:
> > Sadly, we are constantly diverging the ext2/ext3 codebases.  Lots of
> > features are going into ext3, but lots of fixes/improvements are only
> > going into ext2.  Is ext3 holding BKL for doing journal_start() still?
> > 
> > Looking at ext3_prepare_write() we grab the BKL for doing journal_start()
> > and for journal_stop(), but I don't _think_ we need BKL for journal_stop()
> > do we?  We may or may not need it for the journal_data case, but that is
> > not even working right now I think.
> 
> We badly need to remove the BKL from ext3; it's the source of massive
> performance problems for ext3 on larger machines.  
> 
> Stephen, you were telling me a week or two ago that there were some
> subtle issues involved with BKL removal from the jbd layer --- could
> you give us a quick summary of what landminds are there for whoever
> wants to try to tackle the ext3/jbd BKL removal?

Ted, as a start, we can move the (un)lock_kernel() calls from the ext3
code into the journal_start() and journal_stop(), and then continue to
push it down into the places where we need it and/or replace it with a
better lock.  This not only makes the lock migration easier, but also
ensures that we always have the lock when we need it.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

