Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751013AbWHEW1D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbWHEW1D (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 18:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbWHEW1D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 18:27:03 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:60839 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751013AbWHEW1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 18:27:01 -0400
Date: Sat, 5 Aug 2006 15:22:47 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>,
       Dave Kleikamp <shaggy@austin.ibm.com>, Christoph Hellwig <hch@lst.de>,
       Valerie Henson <val_henson@linux.intel.com>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Akkana Peck <akkana@shallowsky.com>,
       Jesse Barnes <jesse.barnes@intel.com>, jsipek@cs.sunysb.edu,
       Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [RFC] [PATCH] Relative lazy atime
Message-ID: <20060805222247.GQ29686@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <20060803063622.GB8631@goober> <20060805122537.GA23239@lst.de> <1154797123.12108.6.camel@kleikamp.austin.ibm.com> <1154797475.3054.79.camel@laptopd505.fenrus.org> <20060805183609.GA7564@tuatara.stupidest.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060805183609.GA7564@tuatara.stupidest.org>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 05, 2006 at 11:36:09AM -0700, Chris Wedgwood wrote:
> should it be atime-dirty or non-critical-dirty? (ie. make it more
> generic to cover cases where we might have other non-critical fields
> to flush if we can but can tolerate loss if we dont)
So, just to be sure - we're fine with atime being lost due to crashes,
errors, etc?

I don't see why not, but I figure it'd be good to make sure there's some
concensus on that.

If that is in fact the case, OCFS2 could do the same thing as XFS and
update disk only when we're going there for some other reason. The only
thing that we would have to add on top of that is a disk write when we're
dropping a cluster lock and the inode is still 'atime-dirty'. 
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com
