Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291423AbSBNLOF>; Thu, 14 Feb 2002 06:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291452AbSBNLNz>; Thu, 14 Feb 2002 06:13:55 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:49671 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S291423AbSBNLNt>; Thu, 14 Feb 2002 06:13:49 -0500
Date: Thu, 14 Feb 2002 12:13:38 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: <roman@serv>
To: Hanna Linder <hannal@us.ibm.com>
cc: <viro@math.psu.edu>, <lse-tech@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH 2.4.17] Your suggestions for fast path walk
In-Reply-To: <9230000.1013648509@w-hlinder.des>
Message-ID: <Pine.LNX.4.33.0202141153300.24637-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 13 Feb 2002, Hanna Linder wrote:

> -	return NULL;
> +        struct dentry *dentry = NULL;

Could you please configure your editor to use tabs instead of spaces?
It would make the patch smaller and easier to read.

> +	if(flags & LOOKUP_LOCKED){

IMO it would be better to use a count, which limits to number of lookups
done with the spinlock held. This count could be put into nameidata, this
would change the prototype of cached_lookup/lookup_hash into using a
pointer to struct nameidata, but AFAICS it's not a really problem, as most
of the time the data is already available in a nameidata struct.
Since spinlocks are a dummy on UP, it would make sense to make this test a
inline function/macro, where it could be made a dummy as well.

bye, Roman

