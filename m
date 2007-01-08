Return-Path: <linux-kernel-owner+w=401wt.eu-S1750729AbXAHXbF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbXAHXbF (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 18:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbXAHXbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 18:31:05 -0500
Received: from mail.app.aconex.com ([203.89.192.138]:39730 "EHLO
	postoffice.aconex.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750729AbXAHXbE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 18:31:04 -0500
X-Greylist: delayed 1194 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Jan 2007 18:31:03 EST
Subject: Re: [PATCH] Make BH_Unwritten a first class bufferhead flag
From: Nathan Scott <nscott@aconex.com>
Reply-To: nscott@aconex.com
To: Christoph Hellwig <hch@infradead.org>
Cc: David Chinner <dgc@sgi.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20070108225402.GA24787@infradead.org>
References: <20070108224932.GZ33919298@melbourne.sgi.com>
	 <20070108225402.GA24787@infradead.org>
Content-Type: text/plain
Organization: Aconex
Date: Tue, 09 Jan 2007 10:14:34 +1100
Message-Id: <1168298075.32113.62.camel@edge>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2007-01-08 at 22:54 +0000, Christoph Hellwig wrote:
> this doesn't look like a full first class flag to me yet.  Don't
> we need to check for buffer_unwritten in the places we're checking
> for buffer_delay so we can stop setting buffer_delay for unwritten
> buffers?

Yep, that does need to be done.  The first of the two calls
to set_buffer_delay can be removed from __xfs_get_blocks also
(currently there is an implied association between Delay and
Unwritten, which should be removed now).

I have a vague memory of some magic sysrq code (from 2.4 days)
which counted BH state on a page - if that still exists it'd
need to be updated too, but I can't seem to find it in current
2.6 kernels (used to live in buffer.c in ye olde 2.4 days).  It
probably left us around the time of PG_private's introduction.

cheers.

-- 
Nathan

