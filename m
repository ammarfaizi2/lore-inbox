Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161180AbWHJLew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161180AbWHJLew (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 07:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161182AbWHJLew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 07:34:52 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:50828 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S1161177AbWHJLeu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 07:34:50 -0400
Date: Thu, 10 Aug 2006 13:34:49 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: =?iso-8859-15?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Valerie Henson <val_henson@linux.intel.com>,
       Matthew Wilcox <matthew@wil.cx>, dean gaudet <dean@arctic.org>,
       David Lang <dlang@digitalinsight.com>,
       Mark Fasheh <mark.fasheh@oracle.com>, Chris Wedgwood <cw@f00f.org>,
       Arjan van de Ven <arjan@linux.intel.com>,
       Dave Kleikamp <shaggy@austin.ibm.com>, Christoph Hellwig <hch@lst.de>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Akkana Peck <akkana@shallowsky.com>,
       Jesse Barnes <jesse.barnes@intel.com>, jsipek@cs.sunysb.edu,
       Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [RFC] [PATCH] Relative lazy atime
Message-ID: <20060810113449.GA7627@janus>
References: <20060805122537.GA23239@lst.de> <1154797123.12108.6.camel@kleikamp.austin.ibm.com> <1154797475.3054.79.camel@laptopd505.fenrus.org> <20060805183609.GA7564@tuatara.stupidest.org> <20060805222247.GQ29686@ca-server1.us.oracle.com> <Pine.LNX.4.63.0608051604420.20114@qynat.qvtvafvgr.pbz> <Pine.LNX.4.64.0608051612330.20926@twinlark.arctic.org> <20060806030147.GG4379@parisc-linux.org> <20060809063947.GA13474@goober> <20060809122134.GF27863@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20060809122134.GF27863@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2006 at 02:21:34PM +0200, Jörn Engel wrote:
> At the risk of stating the obvious, let me try to explain what each
> method does:
> 
> 1. standard
> Every read access to a file/directory causes an atime update.
> 
> 2. nodiratime
> Every read access to a non-directory causes an atime update.
> 
> 3. lazy atime
> The first read access to a file/directory causes an atime update.
> 
> 4. noatime
> No read access to a file/directory causes an atime update.

5. lazy atime writeout

To reduce the pain of a fully functional atime only flush "atime-dirty"
inodes when the on-disk/in-core atime difference becomes big enough
(e.g. by maintaining an "atime dirtyness" level for the in-core inode).

I haven't seen anyone mentioning it but properly written cleanup programs
for /tmp et.al. do depend on atimes. When a system crashes after a long
time then (3) and (4) will probably cause /tmp to be wiped out because
at the next boot all atimes will be really old.

-- 
Frank
