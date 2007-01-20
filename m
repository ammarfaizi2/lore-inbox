Return-Path: <linux-kernel-owner+w=401wt.eu-S965305AbXATQiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965305AbXATQiV (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 11:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965307AbXATQiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 11:38:20 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:15113 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965305AbXATQiU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 11:38:20 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=tNQkZXjGmI84K3KLrk68TeZsL1rlI4EHbkQFVMUT2JulJER5j+jay1aSOBJ0qURy6gXea9LWf8P+oZZlvWzf1quuoOGNhlZ3tI0FH9vkSDyYrWIxGX+KHJ9o0pwXnQMT4c614mnm9rwXxEuOMWYZ0LNI2nJdZEjIDyUgn/O5XSo=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: O_DIRECT question
Date: Sat, 20 Jan 2007 17:36:22 +0100
User-Agent: KMail/1.8.2
Cc: Linus Torvalds <torvalds@osdl.org>, Viktor <vvp01@inbox.ru>,
       Aubrey <aubreylee@gmail.com>, Hua Zhong <hzhong@gmail.com>,
       Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       hch@infradead.org, kenneth.w.chen@intel.com, akpm@osdl.org
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com> <Pine.LNX.4.64.0701110750520.3594@woody.osdl.org> <45A6704A.40205@tls.msk.ru>
In-Reply-To: <45A6704A.40205@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701201736.22553.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 January 2007 18:13, Michael Tokarev wrote:
> example, which isn't quite possible now from userspace.  But as long as
> O_DIRECT actually writes data before returning from write() call (as it
> seems to be the case at least with a normal filesystem on a real block
> device - I don't touch corner cases like nfs here), it's pretty much
> THE ideal solution, at least from the application (developer) standpoint.

Why do you want to wait while 100 megs of data are being written?
You _have to_ have threaded db code in order to not waste
gobs of CPU time on UP + even with that you eat context switch
penalty anyway.

I hope you agree that threaded code is not ideal performance-wise
- async IO is better. O_DIRECT is strictly sync IO.
--
vda
