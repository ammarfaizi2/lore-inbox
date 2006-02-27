Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750856AbWB0J3p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbWB0J3p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 04:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750924AbWB0J3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 04:29:45 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:3002 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750856AbWB0J3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 04:29:44 -0500
Subject: Re: [PATCH 0/7] isdn4linux: add drivers for Siemens Gigaset ISDN
	DECT PABX
From: Arjan van de Ven <arjan@infradead.org>
To: Hansjoerg Lipp <hjlipp@web.de>
Cc: Karsten Keil <kkeil@suse.de>, i4ldeveloper@listserv.isdn4linux.de,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Greg Kroah-Hartman <gregkh@suse.de>, Tilman Schmidt <tilman@imap.cc>
In-Reply-To: <gigaset307x.2006.02.27.001.0@hjlipp.my-fqdn.de>
References: <gigaset307x.2006.02.27.001.0@hjlipp.my-fqdn.de>
Content-Type: text/plain
Date: Mon, 27 Feb 2006 10:29:37 +0100
Message-Id: <1141032577.2992.83.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-27 at 07:23 +0100, Hansjoerg Lipp wrote:
> The following patches add drivers for the Siemens Gigaset 3070 family of
> ISDN DECT PABXes connected via USB, either directly or over a DECT link
> using a Gigaset M105 or compatible DECT data adapter. The devices are
> integrated as ISDN adapters within the isdn4linux framework, supporting
> incoming and outgoing voice and data connections, and also as tty
> devices providing access to device specific AT commands.


as a general review remark: you seem to use a LOT of atomic variables.
This I think is not too good an approach in general, because you get
into all kinds of race situations if you need to access multiple (and
you do). In addition I've seen a lot of your code using 2 or more
atomics in the same function, at which point it's most likely cheaper to
just have a spinlock instead... (yes a single atomic is same cost as a
spinlock, but once you do multiple in the same function the price is
thus higher than a spinlock ;)


