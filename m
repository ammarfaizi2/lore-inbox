Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261569AbVAGTtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261569AbVAGTtE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 14:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261574AbVAGTrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 14:47:55 -0500
Received: from peabody.ximian.com ([130.57.169.10]:48546 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261560AbVAGTpI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 14:45:08 -0500
Subject: Re: /dev/random vs. /dev/urandom
From: Robert Love <rml@novell.com>
To: Ron Peterson <rpeterso@mtholyoke.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050107190536.GA14205@mtholyoke.edu>
References: <20050107190536.GA14205@mtholyoke.edu>
Content-Type: text/plain
Date: Fri, 07 Jan 2005 14:40:43 -0500
Message-Id: <1105126843.9311.41.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-01-07 at 14:05 -0500, Ron Peterson wrote:

>     read( fd, dat, RAND_LEN );
>     for( i = 0; i < RAND_LEN; i++ ) {
>       dat[i] = (dat[i] & 0x07) + '0';
>     }

Your problem is probably because read() need not actually read RAND_LEN
bytes.  Particularly with /dev/random, since it will only return bytes
up to the entropy estimate.  But you assume it read RAND_LEN, when those
are unread.  And possibly zero.  So that is probably your bug.

The AND makes zero sense, either.

Just use dd(1).

	Robert Love


