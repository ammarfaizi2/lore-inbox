Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262067AbVCAVCz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262067AbVCAVCz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 16:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262068AbVCAVCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 16:02:55 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:45459 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262067AbVCAVCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 16:02:52 -0500
Subject: Re: [PATCH] New operation for kref to help avoid locks
From: Arjan van de Ven <arjan@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: Corey Minyard <minyard@acm.org>, Sergey Vlasov <vsu@altlinux.ru>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20050301201528.GA23484@kroah.com>
References: <42209BFD.8020908@acm.org>
	 <20050226232026.5c12d5b0.vsu@altlinux.ru> <4220F6C8.4020002@acm.org>
	 <20050301201528.GA23484@kroah.com>
Content-Type: text/plain
Date: Tue, 01 Mar 2005 22:02:43 +0100
Message-Id: <1109710964.6293.166.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-01 at 12:15 -0800, Greg KH wrote:
> On Sat, Feb 26, 2005 at 04:23:04PM -0600, Corey Minyard wrote:
> > Add a routine to kref that allows the kref_put() routine to be
> > unserialized even when the get routine attempts to kref_get()
> > an object without first holding a valid reference to it.  This is
> > useful in situations where this happens multiple times without
> > freeing the object, as it will avoid having to do a lock/semaphore
> > except on the final kref_put().
> > 
> > This also adds some kref documentation to the Documentation
> > directory.
> 
> I like the first part of the documentation, that's nice.
> 
> But I don't like the new kref_get_with_check() function that you
> implemented.  If you look in the -mm tree, kref_put() now returns if
> this was the last put on the reference count or not, to help with lists
> of objects with a kref in it.
> 
> Perhaps you can use that to implement what you need instead?

note that I'm not convinced the "lockless" implementation actually is
faster. It still uses an atomic variable, which is just as expensive as
taking a lock normally...

