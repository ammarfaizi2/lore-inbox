Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030354AbWFCVRK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030354AbWFCVRK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 17:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030344AbWFCVRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 17:17:09 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:61779 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1030354AbWFCVRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 17:17:08 -0400
Date: Sat, 3 Jun 2006 14:16:57 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Florin Malita <fmalita@gmail.com>, mark.fasheh@oracle.com,
       kurt.hackel@oracle.com, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] ocfs2: dereference before NULL check in ocfs2_direct_IO_get_blocks()
Message-ID: <20060603211657.GK2422@ca-server1.us.oracle.com>
Mail-Followup-To: Alexey Dobriyan <adobriyan@gmail.com>,
	Florin Malita <fmalita@gmail.com>, mark.fasheh@oracle.com,
	kurt.hackel@oracle.com, linux-kernel@vger.kernel.org, akpm@osdl.org
References: <4481AC0F.6040805@gmail.com> <20060603191558.GA7268@martell.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060603191558.GA7268@martell.zuzino.mipt.ru>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 03, 2006 at 11:15:58PM +0400, Alexey Dobriyan wrote:
> On Sat, Jun 03, 2006 at 11:34:39AM -0400, Florin Malita wrote:
> > 'bh_result' & 'inode' are explicitly checked against NULL so they
> > shouldn't be dereferenced prior to that.
> >
> > Coverity ID: 1273, 1274.
> 
> AFAICS, the patch is BS, as usual with this type of patches.
> 
> Can "inode" and "bh_result" be NULL here? I bet they can't.

	This is a common result of this sort of scan.  The scan merely
provides good information, not a perfect patch.  There are two
possibilities:

	1) The scan is right, and the dereference is dangerous.  The
	   patch is correct.
	2) The dereference is not dangerous ("can't happen"), and the
	   later check for NULL is spurious.  A correct patch would
	   merely remove the check.

	This is clearly a case of (2), but I bet that (1) is seen just
as often.

Joel

-- 

Life's Little Instruction Book #444

	"Never underestimate the power of a kind word or deed."

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
