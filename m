Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751315AbWEAHjM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbWEAHjM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 03:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbWEAHjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 03:39:12 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:62082 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751315AbWEAHjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 03:39:11 -0400
Subject: Re: [RFC: 2.6 patch] kernel/sys.c: possible cleanups
From: Arjan van de Ven <arjan@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060501073514.GQ3570@stusta.de>
References: <20060501071134.GH3570@stusta.de>
	 <20060501001803.48ac34df.akpm@osdl.org>  <20060501073514.GQ3570@stusta.de>
Content-Type: text/plain
Date: Mon, 01 May 2006 09:39:06 +0200
Message-Id: <1146469146.20760.31.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > We have a process for the latter.  And even if we ignore that process, the
> > patch ends up sitting in -mm for ages because of the API change, along with
> > the cleanups, which could be merged up promptly.
> 
> The problem is that we have a lack of a process at the other end:
> 
> There is no process to review added exports.
> 
> And there are so many exports added with "we will soon use them".

.. and many never will, leading to about 900 unused ones, each taking
quite a bit of space.

Some are really stupid (eg sys_openat export is just braindead, sys_open
was temporarily exported until all in-kernel users were switched over to
the firmware loading api, sys_openat seems to just have blindly copied
this without thinking)


> If removing exports requires a process, adding exports requires a 
> similar process.

alternatively we should bite the bullet, and just stick those 900 on the
"we'll kill all these in 3 months" list, have a thing to disable them
now via a config option (so that people actually notice rather than just
having them in the depreciation file) and fix the 5 or 10 or so that
actually will be used soon in those 3 months.



