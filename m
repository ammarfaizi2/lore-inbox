Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbWHIMXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbWHIMXK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 08:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750704AbWHIMXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 08:23:09 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:8104 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1750702AbWHIMXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 08:23:08 -0400
Date: Wed, 9 Aug 2006 14:21:34 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Valerie Henson <val_henson@linux.intel.com>
Cc: Matthew Wilcox <matthew@wil.cx>, dean gaudet <dean@arctic.org>,
       David Lang <dlang@digitalinsight.com>,
       Mark Fasheh <mark.fasheh@oracle.com>, Chris Wedgwood <cw@f00f.org>,
       Arjan van de Ven <arjan@linux.intel.com>,
       Dave Kleikamp <shaggy@austin.ibm.com>, Christoph Hellwig <hch@lst.de>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Akkana Peck <akkana@shallowsky.com>,
       Jesse Barnes <jesse.barnes@intel.com>, jsipek@cs.sunysb.edu,
       Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [RFC] [PATCH] Relative lazy atime
Message-ID: <20060809122134.GF27863@wohnheim.fh-wedel.de>
References: <20060803063622.GB8631@goober> <20060805122537.GA23239@lst.de> <1154797123.12108.6.camel@kleikamp.austin.ibm.com> <1154797475.3054.79.camel@laptopd505.fenrus.org> <20060805183609.GA7564@tuatara.stupidest.org> <20060805222247.GQ29686@ca-server1.us.oracle.com> <Pine.LNX.4.63.0608051604420.20114@qynat.qvtvafvgr.pbz> <Pine.LNX.4.64.0608051612330.20926@twinlark.arctic.org> <20060806030147.GG4379@parisc-linux.org> <20060809063947.GA13474@goober>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060809063947.GA13474@goober>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 August 2006 23:39:49 -0700, Valerie Henson wrote:
> On Sat, Aug 05, 2006 at 09:01:47PM -0600, Matthew Wilcox wrote:
> > On Sat, Aug 05, 2006 at 04:28:29PM -0700, dean gaudet wrote:
> > > you can work around mutt's silly dependancy on atime by configuring it 
> > > with --enable-buffy-size.  so far mutt is the only program i've discovered 
> > > which cares about atime.
> > 
> > For the shell, atime is the difference between 'you have mail' and 'you
> > have new mail'.
> > 
> > I still don't understand though, how much does this really buy us over
> > nodiratime?
> 
> Lazy atime buys us a reduction in writes over nodiratime for any
> workload which reads files, such as grep -r, a kernel compile, or
> backup software.  Do I misunderstand the question?

At the risk of stating the obvious, let me try to explain what each
method does:

1. standard
Every read access to a file/directory causes an atime update.

2. nodiratime
Every read access to a non-directory causes an atime update.

3. lazy atime
The first read access to a file/directory causes an atime update.

4. noatime
No read access to a file/directory causes an atime update.

In comparison, lazy atime will cause more atime updates for
directories and vastly fewer for non-directories.  Effectively atime
is turned into little more than a flag, stating whether the file was
ever read since the last write to it.  And it appears as if neither
mutt nor the shell use atime for more than this flagging purpose, so I
am rather fond of the idea.

Jörn

-- 
The cheapest, fastest and most reliable components of a computer
system are those that aren't there.
-- Gordon Bell, DEC labratories
