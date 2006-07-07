Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932295AbWGGTwm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbWGGTwm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 15:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbWGGTwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 15:52:42 -0400
Received: from thunk.org ([69.25.196.29]:46750 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932295AbWGGTwl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 15:52:41 -0400
Date: Fri, 7 Jul 2006 15:52:23 -0400
From: Theodore Tso <tytso@mit.edu>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       "J. Bruce Fields" <bfields@fieldses.org>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: ext4 features
Message-ID: <20060707195223.GA12301@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Bill Davidsen <davidsen@tmr.com>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	LKML <linux-kernel@vger.kernel.org>
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de> <20060704010240.GD6317@thunk.org> <44ABAF7D.8010200@tmr.com> <20060705125956.GA529@fieldses.org> <44AC2B56.8010703@tmr.com> <20060705214133.GA28487@fieldses.org> <44AC7647.2080005@tmr.com> <1152189796.5689.17.camel@lade.trondhjem.org> <44ADC3CE.1030302@tmr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44ADC3CE.1030302@tmr.com>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2006 at 10:15:42PM -0400, Bill Davidsen wrote:
> Trond Myklebust wrote:
> 
> >Nobody gives a rats arse about backups: those are infrequent and
> >can/should use more sophisticated techniques such as checksumming.
> >
> Actually, those of us who do run production servers care vastly about 
> backups. And beside being utterly unscalable (checksum 20 TB of files 
> four times a day to find what changed???), you would have to remember 
> the checksums for all those files.

Not four times a day, but probably once a month or two it would be a
*very* good idea to do periodic sweeps of files to make sure the hard
drive hasn't corrupted the files out from under you.  If you have 20+
TB of data, the probability of silent data corruption starts going up.
That would be justification for storing the checksum in the inode or
in the EA of the file, with the kernel automatically clearing it if
the file was *deliberately* changed.  The goal is to detect the disk
silently changing the data for you, free of charge....

						- Ted
