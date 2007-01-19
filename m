Return-Path: <linux-kernel-owner+w=401wt.eu-S964894AbXASUOB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964894AbXASUOB (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 15:14:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964899AbXASUOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 15:14:00 -0500
Received: from minus.inr.ac.ru ([194.67.69.97]:47647 "HELO ms2.inr.ac.ru"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S964898AbXASUOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 15:14:00 -0500
X-Greylist: delayed 3385 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Jan 2007 15:13:59 EST
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=ms2.inr.ac.ru;
  b=AZ6uLTDW+0kt4q9hYWYD1uEj3jgH1B5LJ75vpkF8ve7J57srDokLrUvuXa74UkI3DQAJYsjq+l7XR3wTCLS/CqhlZnvk30VLm6iO88YdhgTu31XKxSLa0YeU7kCu3m9eFjmqIakJET4Cj1Ki0nfWTcFwWrTD7ACzlVFLZK+zHgs=;
Date: Fri, 19 Jan 2007 22:16:15 +0300
From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
To: Hugh Dickins <hugh@veritas.com>
Cc: Alexey Dobriyan <adobriyan@openvz.org>, Andrew Morton <akpm@osdl.org>,
       Richard Purdie <richard@openedhand.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Don't map random pages if swapoff errors
Message-ID: <20070119191615.GA16601@ms2.inr.ac.ru>
References: <20070119163030.GA12507@localhost.sw.ru> <Pine.LNX.4.64.0701191754020.10013@blonde.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701191754020.10013@blonde.wat.veritas.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Getting an error there is all the more reason to proceed
> with the swapoff, not to give up and break out of it.

Yes, from this viewpoint more reasonable approach would be to untie
corresponding ptes from swap entry and mark them as invalid to trigger
fault on access.

Not even tried simply because it is definitely not that thing, which
we needed. We used this for process migration and for that purpose
we really need to know when swapoff() fails ASAP to abort migration,
to kill processes which got invalid pages and to resume original copy.
Obviously, delayed fault is absolutely inappropriate for this particular
purpose.

Alexey
