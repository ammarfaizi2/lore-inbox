Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285279AbRLFWtz>; Thu, 6 Dec 2001 17:49:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285269AbRLFWty>; Thu, 6 Dec 2001 17:49:54 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:13192 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S285279AbRLFWtA>;
	Thu, 6 Dec 2001 17:49:00 -0500
Date: Thu, 6 Dec 2001 17:48:42 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Larry McVoy <lm@bitmover.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Daniel Phillips <phillips@bonn-fries.net>,
        "David S. Miller" <davem@redhat.com>, davidel@xmailserver.org,
        rusty@rustcorp.com.au, Martin.Bligh@us.ibm.com, riel@conectiva.com.br,
        lars.spam@nocrew.org, hps@intermeta.de, linux-kernel@vger.kernel.org
Subject: Re: SMP/cc Cluster description
In-Reply-To: <20011206143218.O27589@work.bitmover.com>
Message-ID: <Pine.GSO.4.21.0112061742480.29985-100000@binet.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 6 Dec 2001, Larry McVoy wrote:

> I'm not sure what the point is.  We've already agreed that the multiple OS
> instances will have synchonization to do for file operations, ftruncate
> being one of them.

That's nice.  But said operation involves serious wanking with metadata
and _that_ would better have exclusion with write(2) and some warranties
about pageouts.

You can do lockless get_block() and truncate().  And it will be a hive
of races always ready to break out.  We used to try that and it was
a fscking mess of unbelievable proportions - worse than that in full-blown
rename() support.

