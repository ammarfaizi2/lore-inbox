Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262409AbVBCB6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262409AbVBCB6l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 20:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262711AbVBCBx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 20:53:28 -0500
Received: from waste.org ([216.27.176.166]:24261 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262308AbVBCBw4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 20:52:56 -0500
Date: Wed, 2 Feb 2005 17:52:36 -0800
From: Matt Mackall <mpm@selenic.com>
To: Christophe Saout <christophe@saout.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Clemens Fruhwirth <clemens@endorphin.org>, dm-crypt@saout.de,
       Alasdair G Kergon <agk@redhat.com>
Subject: Re: dm-crypt crypt_status reports key?
Message-ID: <20050203015236.GO2493@waste.org>
References: <20050202211916.GJ2493@waste.org> <1107394381.10497.16.camel@server.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1107394381.10497.16.camel@server.cs.pocnet.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2005 at 02:33:01AM +0100, Christophe Saout wrote:
> Am Mittwoch, den 02.02.2005, 13:19 -0800 schrieb Matt Mackall:
> 
> > From looking at the dm_crypt code, it appears that it can be
> > interrogated to report the current key. Some quick testing shows:
> > 
> > # dmsetup table /dev/mapper/volume1
> > 0 2000000 crypt aes-plain 0123456789abcdef0123456789abcdef 0 7:0 0
> > 
> > Obviously, root can in principle recover this password from the
> > running kernel but it seems silly to make it so easy.
> 
> I already tried that. It took me about five minutes using a shell, dd
> and hexdump to get the key out of the running kernel...

Indeed.

> Yes, the reason is that the device-mapper supports on-the-fly
> modifications of the device. cryptsetup has a command to resize the
> mapping for example. It can do that without asking for the password
> again. Features like this are the reason I'm doing this. Userspace tools
> should be able to assume that they can use the result of a table status
> command to create a new table with this information.

Hmm, interesting. A password per resize is not terribly onerous though.

> An alternativ would be to use some form of handle to point to the key
> after it has been given to the kernel. But that would require some more
> infrastructure.

There's been some talk about such infrastructure already. I believe
some pieces of it may already be in place.

> BTW: The setkey command also seems to return the keys in use for IPSEC
> connections.

While possibly suboptimal, this won't surprise anyone. But dmsetup has
no mention of security in its manpage and doesn't show keys in typical
LVM usage. So people might reasonably assume that data from dmsetup
tables is not secret.

-- 
Mathematics is the supreme nostalgia of our time.
