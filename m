Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261263AbVARMPL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbVARMPL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 07:15:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbVARMPL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 07:15:11 -0500
Received: from piggy.rz.tu-ilmenau.de ([141.24.4.8]:20388 "EHLO
	piggy.rz.tu-ilmenau.de") by vger.kernel.org with ESMTP
	id S261263AbVARMPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 07:15:04 -0500
Date: Tue, 18 Jan 2005 13:15:00 +0100
From: Mario Holbe <Mario.Holbe@TU-Ilmenau.DE>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Andries Brouwer <aebr@win.tue.nl>, linux-kernel@vger.kernel.org
Subject: Re: 2.4: "access beyond end of device" after ext2 mount
Message-ID: <20050118121500.GF2839@darkside.22.kls.lan>
Mail-Followup-To: Mario Holbe <Mario.Holbe@TU-Ilmenau.DE>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Andries Brouwer <aebr@win.tue.nl>, linux-kernel@vger.kernel.org
References: <20050115233530.GA2803@darkside.22.kls.lan> <20050117194635.GD22202@logos.cnet> <20050118105547.GD8747@pclin040.win.tue.nl> <20050118084526.GB25979@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050118084526.GB25979@logos.cnet>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2005 at 06:45:26AM -0200, Marcelo Tosatti wrote:
> So this is either not a Linux error and not a disk error, its just that the
> "use with filesystem" then "direct access" is a unfortunate combination.
> What would be the correct fix for this for this, if any? 

Well, I personally think at least the EOF behaviour should be fixed
somehow.
I understand the point that the device's blocksize affects the device's
length... obviously a block device can only consist of full blocks,
not half a block or something like that.
However, if that's right, a block device's length should IMHO also be
affected by it's blocksize - thus, the block device should return an
EOF after the last block was read.

In my case this would mean, it should return an EOF if blocksize is
1024 and 4996183 blocks (9992366 sectors) are read or better, if the
4996184th block is attempted to read and it should return an EOF if
blocksize is 4096 and 1249045 blocks (9992360 sectors) are read or
better, if the 1249046th block is attempted to read.

Another approach could be to allow 'fractions of blocks' :)
Then, the device could have a blocksize of 4096 and consist of
1249045 full blocks and a 6/8 block. However, I'm not sure, if this
is possible at all.

> v2.6 should suffer from the same issues?

I don't know, but if it doesn't, one could just backport 2.6's
solution :)


Mario
-- 
Independence Day: Fortunately, the alien computer operating system works just
fine with the laptop. This proves an important point which Apple enthusiasts
have known for years. While the evil empire of Microsoft may dominate the
computers of Earth people, more advanced life forms clearly prefer Mac's.
