Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269305AbRGaPPe>; Tue, 31 Jul 2001 11:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269207AbRGaPPY>; Tue, 31 Jul 2001 11:15:24 -0400
Received: from weta.f00f.org ([203.167.249.89]:39302 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S269305AbRGaPPO>;
	Tue, 31 Jul 2001 11:15:14 -0400
Date: Wed, 1 Aug 2001 03:15:54 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Chris Mason <mason@suse.com>
Cc: Hans Reiser <reiser@namesys.com>, Rik van Riel <riel@conectiva.com.br>,
        Christoph Hellwig <hch@caldera.de>, linux-kernel@vger.kernel.org
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
Message-ID: <20010801031554.B7728@weta.f00f.org>
In-Reply-To: <687650000.996586885@tiny>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <687650000.996586885@tiny>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, Jul 31, 2001 at 09:41:25AM -0400, Chris Mason wrote:

    if (some_error) {
    #ifdef CONFIG_REISERFS_CHECK
        panic("some_error") ;
    #else
        gracefully_recover
    #endif

What a terrible construct... if would be much more elegant as:

        if(some_error) {
                _namesys_internal_foo("some_error");
                recover_bar();
        }

where _namesys_internal_foo is compiled differently and may not return
depending on CONFIG_REISERFS_CHECK and maybe also the error type.

That way we don't end up with even more #ifdef BLAH / #endif cruft
which obfuscates what is already hard to read code in places!

Flames welcome :)





  --cw

