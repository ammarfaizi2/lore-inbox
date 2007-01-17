Return-Path: <linux-kernel-owner+w=401wt.eu-S1750956AbXAQWoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbXAQWoO (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 17:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750957AbXAQWoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 17:44:14 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:58913 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955AbXAQWoN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 17:44:13 -0500
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Jan 2007 17:44:13 EST
Date: Wed, 17 Jan 2007 23:36:10 +0100 (CET)
From: Bodo Eggert <7eggert@gmx.de>
To: Arjan van de Ven <arjan@infradead.org>
cc: 7eggert@gmx.de, Helge Hafting <helge.hafting@aitel.hist.no>,
       Michael Tokarev <mjt@tls.msk.ru>, Chris Mason <chris.mason@oracle.com>,
       Linus Torvalds <torvalds@osdl.org>, dean gaudet <dean@arctic.org>,
       Viktor <vvp01@inbox.ru>, Aubrey <aubreylee@gmail.com>,
       Hua Zhong <hzhong@gmail.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel@vger.kernel.org, hch@infradead.org,
       kenneth.w.chen@intel.com, akpm@osdl.org
Subject: Re: O_DIRECT question
In-Reply-To: <1169013342.3457.60.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.58.0701172319570.2544@be1.lrz>
References: <7BYkO-5OV-17@gated-at.bofh.it> <7BYul-6gz-5@gated-at.bofh.it> 
 <7C74B-2A4-23@gated-at.bofh.it> <7CaYA-mT-19@gated-at.bofh.it> 
 <7Cpuz-64X-1@gated-at.bofh.it> <7Cz0T-4PH-17@gated-at.bofh.it> 
 <7CBcl-86B-9@gated-at.bofh.it> <7CBvH-52-9@gated-at.bofh.it> 
 <7DyYK-6lE-3@gated-at.bofh.it>  <E1H6utT-0000g3-Aw@be1.lrz>
 <1169013342.3457.60.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@gmx.de
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:9b3b2cc444a07783f194c895a09f1de9
X-Provags-ID2: V01U2FsdGVkX1+0A2h9j4iqdvVDRu2rzivmKrNufvH838C3sAg7JdSeGHavSC4LNMp90hKLbThxhqtOOBUqGnWwUza4YwIZ1dqwejLhbg/gcTsU6gzeLfsStQ==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jan 2007, Arjan van de Ven wrote:
> On Tue, 2007-01-16 at 21:26 +0100, Bodo Eggert wrote:
> > Helge Hafting <helge.hafting@aitel.hist.no> wrote:
> > > Michael Tokarev wrote:

> > >> But seriously - what about just disallowing non-O_DIRECT opens together
> > >> with O_DIRECT ones ?
> > >>   
> > > Please do not create a new local DOS attack.
> > > I open some important file, say /etc/resolv.conf
> > > with O_DIRECT and just sit on the open handle.
> > > Now nobody else can open that file because
> > > it is "busy" with O_DIRECT ?
> > 
> > Suspend O_DIRECT access while non-O_DIRECT-fds are open, fdatasync on close?
> 
> .. then any user can impact the operation, performance and reliability
> of the database application of another user... sounds like plugging one
> hole by making a bigger hole ;)

Don't allow other users to access your raw database files then, and if
backup kicks in, pausing the database would DTRT for integrety of the
backup. For other applications, paused O_DIRECT may very well be a
problem, but I can't think of one right now.

-- 
Logic: The art of being wrong with confidence... 
