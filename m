Return-Path: <linux-kernel-owner+w=401wt.eu-S932213AbXADR6s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbXADR6s (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 12:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbXADR6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 12:58:48 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:58360 "EHLO mailgw.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932217AbXADR6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 12:58:47 -0500
X-Greylist: delayed 1855 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Jan 2007 12:58:47 EST
Message-ID: <459D38DA.4030803@vc.cvut.cz>
Date: Thu, 04 Jan 2007 09:26:50 -0800
From: Petr Vandrovec <vandrove@vc.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061105 Iceape/1.0.6 (Debian-1.0.6-1)
MIME-Version: 1.0
To: Pierre Ossman <drzeus-list@drzeus.cx>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: NCPFS and brittle connections
References: <459D1794.2060009@drzeus.cx>
In-Reply-To: <459D1794.2060009@drzeus.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Ossman wrote:
> Hi Petr,
> 
> What is the status of this bug?
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=3328
> 
> I do not see anything in the history of fs/ncpfs that seems to suggest that this, rather critical, issue has been resolved. Is anyone working on it?

Nobody is working on it (at least to my knowledge), and to me it is 
feature - it always worked this way, like smbfs did back in the past - 
if you send signal 9 to process using mount point, and there is some 
transaction in progress, nobody can correctly finish that transaction 
anymore.  Fixing it would require non-trivial amount of code, and given 
that NCP itself is more or less dead protocol I do not feel that it is 
necessary.

If you want to fix it, feel free.  Culprit is RQ_INPROGRESS handling in 
ncp_abort_request - it just aborts whole connection so it does not have 
to provide temporary buffers and special handling for reply - as buffers 
currently specified as reply buffers are owned by caller, so after 
aborting request you cannot use them anymore.
							Petr Vandrovec

