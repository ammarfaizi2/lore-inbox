Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262732AbVBCEGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262732AbVBCEGN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 23:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262826AbVBCEGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 23:06:13 -0500
Received: from waste.org ([216.27.176.166]:20187 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262732AbVBCEGF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 23:06:05 -0500
Date: Wed, 2 Feb 2005 20:05:42 -0800
From: Matt Mackall <mpm@selenic.com>
To: Christophe Saout <christophe@saout.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Clemens Fruhwirth <clemens@endorphin.org>, dm-crypt@saout.de,
       Alasdair G Kergon <agk@redhat.com>
Subject: Re: dm-crypt crypt_status reports key?
Message-ID: <20050203040542.GQ2493@waste.org>
References: <20050202211916.GJ2493@waste.org> <1107394381.10497.16.camel@server.cs.pocnet.net> <20050203015236.GO2493@waste.org> <1107398069.11826.16.camel@server.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1107398069.11826.16.camel@server.cs.pocnet.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2005 at 03:34:29AM +0100, Christophe Saout wrote:
> The keyring API seems very flexible. You can define your own type of
> keys and give them names. Well, the name is probably irrelevant here and
> should be chosen randomly but it's less likely to collide with someone
> else.
 
Dunno here, seems that having one tool that gave the kernel a key named
"foo" and then telling dm-crypt to use key "foo" is probably not a bad
way to go. Then we don't have stuff like "echo <key> | dmsetup create"
and the like and the key-handling smarts can all be put in one
separate place.

Getting from here to there might be interesting though. Perhaps we can
teach dm-crypt to understand keys of the form "keyname:<foo>"? in
addition to raw keys to keep compatibility. Might even be possible to
push this down into crypt_decode_key() (or a smarter variant of same).

Meanwhile, I'd still like to hide the raw key in crypt_status().

-- 
Mathematics is the supreme nostalgia of our time.
