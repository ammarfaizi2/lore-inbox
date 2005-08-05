Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262948AbVHEKJb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262948AbVHEKJb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 06:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262952AbVHEKIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 06:08:07 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:14053 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262948AbVHEKIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 06:08:00 -0400
Date: Fri, 5 Aug 2005 12:07:50 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: David Teigland <teigland@redhat.com>
Cc: Arjan van de Ven <arjan@infradead.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-cluster@redhat.com
Subject: Re: [PATCH 00/14] GFS
Message-ID: <20050805100750.GA9818@wohnheim.fh-wedel.de>
References: <20050802071828.GA11217@redhat.com> <1122968724.3247.22.camel@laptopd505.fenrus.org> <20050805071415.GC14880@redhat.com> <1123227279.3239.1.camel@laptopd505.fenrus.org> <20050805094452.GD14880@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050805094452.GD14880@redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 August 2005 17:44:52 +0800, David Teigland wrote:
> 
> linux/lib/crc32table.h : crc32table_le[] is the same as our crc_32_tab[].
> This looks like a standard that's not going to change, as you've said, so
> including crc32table.h and getting rid of our own table would work fine.
> 
> Do we go a step beyond this and use say the crc32() function from
> linux/crc32.h?  Is this _function_ as standard and unchanging as the table
> of crcs?  In my tests it doesn't produce the same results as our
> gfs2_disk_hash() function, even with both using the same crc table.  I
> don't mind adopting a new function and just writing a user space
> equivalent for the tools if it's a fixed standard.

The function is basically set in stone.  Variants exists depending on
how it is called.  I know of four variants, but there may be more:

1. Initial value is 0
2. Initial value is 0xffffffff
a) Result is taken as-is
b) Result is XORed with 0xffffffff

Maybe your code implements 1a, while you tried 2b with the lib/crc32.c
function or something similar?

Jörn

-- 
And spam is a useful source of entropy for /dev/random too!
-- Jasmine Strong
