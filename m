Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266831AbUBFWBM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 17:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266866AbUBFWBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 17:01:12 -0500
Received: from thunk.org ([140.239.227.29]:18876 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S266831AbUBFWBG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 17:01:06 -0500
Date: Fri, 6 Feb 2004 14:18:40 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Bas Mevissen <ml@basmevissen.nl>
Cc: Jan Dittmer <j.dittmer@portrix.net>, linux-kernel@vger.kernel.org
Subject: Re: ext3 on raid5 failure
Message-ID: <20040206191840.GB2459@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Bas Mevissen <ml@basmevissen.nl>,
	Jan Dittmer <j.dittmer@portrix.net>, linux-kernel@vger.kernel.org
References: <400A5FAA.5030504@portrix.net> <20040118180232.GD1748@srv-lnx2600.matchmail.com> <20040119153005.GA9261@thunk.org> <4010D9C1.50508@portrix.net> <20040127190813.GC22933@thunk.org> <401794F4.80701@portrix.net> <20040129114400.GA27702@thunk.org> <4020BA67.9020604@basmevissen.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4020BA67.9020604@basmevissen.nl>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 04, 2004 at 10:24:55AM +0100, Bas Mevissen wrote:
> I've seen this kind of problems on my notebook too. Among others, over 
> 600MB of a huge cache directory (from a news reader) was having "funny" 
> permissions. Maybe more files were affected. I used fsck.ext3 and 
> changed the attributes with chmod.

Was it just the permissions screwy?  Was the contents of these files
with the "funny" permission sane, or did they contain garbage?  What
about the modtime of the files?

In the original bug report random garbage had gotten written into the
inode table.  That sort of failure is generally caused at a level
below that of the filesystem (i.e., device driver or hardware).

The question is whether the problems you are seeing seem to be caused
by wholesale corruption of an entire block of the inode table, or is
some other kind of problem.  For example, if only the permissions are
getting screwed up, when the rest of the inode data is correct, then
yes, it would most likely be a filesystem bug.  I haven't noticed any
such problem myself, but it's possible that something like that might
be going on.  On the other hand, if it is an entire block in the inode
table getting corrupted then I'd be less likely to presume it to be a
filesystem flaw. 

							- Ted
