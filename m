Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262544AbTCMTNe>; Thu, 13 Mar 2003 14:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262545AbTCMTNe>; Thu, 13 Mar 2003 14:13:34 -0500
Received: from thunk.org ([140.239.227.29]:62139 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S262544AbTCMTNd>;
	Thu, 13 Mar 2003 14:13:33 -0500
Date: Thu, 13 Mar 2003 14:23:54 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: sct@redhat.com, Alex Tomas <bzzz@tmi.comex.ru>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net, Andrew Morton <akpm@digeo.com>
Subject: Re: [Ext2-devel] [PATCH] concurrent block allocation for ext2 against 2.5.64
Message-ID: <20030313192354.GA4777@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>, sct@redhat.com,
	Alex Tomas <bzzz@tmi.comex.ru>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	ext2-devel@lists.sourceforge.net, Andrew Morton <akpm@digeo.com>
References: <m3el5bmyrf.fsf@lexa.home.net> <20030313103948.Z12806@schatzie.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030313103948.Z12806@schatzie.adilger.int>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 13, 2003 at 10:39:48AM -0700, Andreas Dilger wrote:
> Sadly, we are constantly diverging the ext2/ext3 codebases.  Lots of
> features are going into ext3, but lots of fixes/improvements are only
> going into ext2.  Is ext3 holding BKL for doing journal_start() still?
> 
> Looking at ext3_prepare_write() we grab the BKL for doing journal_start()
> and for journal_stop(), but I don't _think_ we need BKL for journal_stop()
> do we?  We may or may not need it for the journal_data case, but that is
> not even working right now I think.

We badly need to remove the BKL from ext3; it's the source of massive
performance problems for ext3 on larger machines.  

Stephen, you were telling me a week or two ago that there were some
subtle issues involved with BKL removal from the jbd layer --- could
you give us a quick summary of what landminds are there for whoever
wants to try to tackle the ext3/jbd BKL removal?

						- Ted
