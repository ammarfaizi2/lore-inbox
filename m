Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932227AbWFDJPf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbWFDJPf (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 05:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbWFDJPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 05:15:34 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:5266 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932227AbWFDJPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 05:15:34 -0400
Subject: Re: [PATCH] ocfs2: dereference before NULL check in
	ocfs2_direct_IO_get_blocks()
From: Arjan van de Ven <arjan@infradead.org>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, Florin Malita <fmalita@gmail.com>,
        mark.fasheh@oracle.com, kurt.hackel@oracle.com,
        linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <20060603211657.GK2422@ca-server1.us.oracle.com>
References: <4481AC0F.6040805@gmail.com>
	 <20060603191558.GA7268@martell.zuzino.mipt.ru>
	 <20060603211657.GK2422@ca-server1.us.oracle.com>
Content-Type: text/plain
Date: Sun, 04 Jun 2006 11:15:30 +0200
Message-Id: <1149412530.3109.84.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-06-03 at 14:16 -0700, Joel Becker wrote:
> On Sat, Jun 03, 2006 at 11:15:58PM +0400, Alexey Dobriyan wrote:
> > On Sat, Jun 03, 2006 at 11:34:39AM -0400, Florin Malita wrote:
> > > 'bh_result' & 'inode' are explicitly checked against NULL so they
> > > shouldn't be dereferenced prior to that.
> > >
> > > Coverity ID: 1273, 1274.
> > 
> > AFAICS, the patch is BS, as usual with this type of patches.
> > 
> > Can "inode" and "bh_result" be NULL here? I bet they can't.
> 
> 	This is a common result of this sort of scan.  The scan merely
> provides good information, not a perfect patch.  There are two
> possibilities:
> 
> 	1) The scan is right, and the dereference is dangerous.  The
> 	   patch is correct.
> 	2) The dereference is not dangerous ("can't happen"), and the
> 	   later check for NULL is spurious.  A correct patch would
> 	   merely remove the check.
> 
> 	This is clearly a case of (2), but I bet that (1) is seen just
> as often.

and in case of (2); newer gcc is often smart enough to do that
automatically :)

