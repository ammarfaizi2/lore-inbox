Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261502AbUKPJxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261502AbUKPJxT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 04:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbUKPJvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 04:51:45 -0500
Received: from canuck.infradead.org ([205.233.218.70]:49416 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261368AbUKPJqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 04:46:23 -0500
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
From: Arjan van de Ven <arjan@infradead.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <E1CTzpJ-0000ap-00@dorka.pomaz.szeredi.hu>
References: <E1CToBi-0008V7-00@dorka.pomaz.szeredi.hu>
	 <Pine.LNX.4.58.0411151423390.2222@ppc970.osdl.org>
	 <E1CTzKY-0000ZJ-00@dorka.pomaz.szeredi.hu>
	 <1100596704.2811.17.camel@laptop.fenrus.org>
	 <E1CTzpJ-0000ap-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Message-Id: <1100598372.2811.21.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Tue, 16 Nov 2004 10:46:13 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?ip=80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-16 at 10:40 +0100, Miklos Szeredi wrote:
> > somehow I find dropping the lock and then doing a list_del() without
> > any kind of verification very suspicious.
> 
> list_del() is done with the lock held.  Look closely. 

yes but how do you know the entry is still on the list and valid ?
you dropped the lock. A normal code pattern is that you then HAVE 
to revalidate the assumptions which you guard by that lock.
If there are no such assumptions... then you didn't need the lock.


