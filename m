Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272411AbTHKIgi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 04:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272343AbTHKIgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 04:36:38 -0400
Received: from smtp3.wanadoo.fr ([193.252.22.25]:7920 "EHLO
	mwinf0601.wanadoo.fr") by vger.kernel.org with ESMTP
	id S272411AbTHKIgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 04:36:37 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Mon, 11 Aug 2003 10:38:15 +0200
From: Pascal Brisset <pascal.brisset-ml@wanadoo.fr>
To: James Morris <jmorris@intercode.com.au>
Cc: Fruhwirth Clemens <clemens-dated-1061346967.29a4@endorphin.org>,
       <linux-kernel@vger.kernel.org>, <mbligh@aracnet.com>,
       <kernel@gozer.org>, <axboe@suse.de>
Subject: Re: [PATCH] loop: fixing cryptoloop troubles.
In-Reply-To: <Mutt.LNX.4.44.0308110226530.8288-100000@excalibur.intercode.com.au>
References: <20030810160706.5D083400211@mwinf0501.wanadoo.fr>
	<Mutt.LNX.4.44.0308110226530.8288-100000@excalibur.intercode.com.au>
Message-Id: <20030811083634.B5817340013E@mwinf0601.wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris writes:
 > Ok, please take into account the case where src == dst.

OK, looks like there is a tricky interplay between algorithms and
transforms.  Cipher implementors will need documentation here, e.g.
"cia_encrypt and cia_decrypt are always called with src==dst UNLESS
we are running in CBC mode AND cia_ivsize!=0" (Please confirm...)

Anybody who tries to bypass the scatterlist-based api by exporting
and calling crypto_alg_lookup() (as I did) will get bitten badly.

-- Pascal

