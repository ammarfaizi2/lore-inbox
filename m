Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263612AbUD0Anl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263612AbUD0Anl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 20:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263628AbUD0Anl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 20:43:41 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32949 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263612AbUD0Anj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 20:43:39 -0400
Date: Tue, 27 Apr 2004 01:43:38 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       raven@themaw.net
Subject: Re: 2.6.6-rc2-bk3 (and earlier?) mount problem (?)
Message-ID: <20040427004338.GX17014@parcelfarce.linux.theplanet.co.uk>
References: <20040426013944.49a105a8.akpm@osdl.org> <Pine.LNX.4.58.0404270105200.2304@donald.themaw.net> <Pine.LNX.4.58.0404261917120.24825@alpha.polcom.net> <Pine.LNX.4.58.0404261102280.19703@ppc970.osdl.org> <Pine.LNX.4.58.0404262350450.3003@alpha.polcom.net> <Pine.LNX.4.58.0404261510230.19703@ppc970.osdl.org> <Pine.LNX.4.58.0404270034110.4469@alpha.polcom.net> <20040426225620.GP17014@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0404270157160.6900@alpha.polcom.net> <20040427002323.GW17014@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040427002323.GW17014@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	BTW, why on the earth had the damn thing tried to grab hda 6
times?  It was _not_ touching partitions - all claims (i.e. open_dev()
calls in dm-table.c) had been for dev == MKDEV(3.0).

	What userland tools do you have and how are they invoked?  Having
a leak like that (it looks like we have a struct dm_dev leaking there,
so destructor is never called) is a bug in any case, but I really wonder
what had triggered these opens in the first place.
