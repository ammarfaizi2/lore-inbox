Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316621AbSHBRXD>; Fri, 2 Aug 2002 13:23:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316623AbSHBRXD>; Fri, 2 Aug 2002 13:23:03 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:57351 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S316621AbSHBRXB>;
	Fri, 2 Aug 2002 13:23:01 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200208021726.g72HQFU445780@saturn.cs.uml.edu>
Subject: Re: BIG files & file systems
To: matti.aarnio@zmailer.org (Matti Aarnio)
Date: Fri, 2 Aug 2002 13:26:15 -0400 (EDT)
Cc: hch@infradead.org (Christoph Hellwig),
       braam@clusterfs.com (Peter J. Braam), linux-kernel@vger.kernel.org
In-Reply-To: <20020731230412.B1237@mea-ext.zmailer.org> from "Matti Aarnio" at Jul 31, 2002 11:04:12 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matti Aarnio writes:

>   It depends on many things:
>    - Block layer (unsigned long)
>    - Page indexes (unsigned long)
>    - Filesystem format dependent limits
>       - EXT2/EXT3: u32_t FILESYSTEM block index, presuming the EXT2/EXT3
>                    is supported only up to 4 kB block sizes, that gives
>                    you a very hard limit.. of 16 terabytes (16 * "10^12")

You first hit the triple-indirection limit at 4 TB.
http://www.cs.uml.edu/~acahalan/linux/ext2.gif

>       - ReiserFS:  u32_t block indexes presently, u64_t in future;
>                    block size ranges ?   Max size is limited by the
>                    maximum supported file size, likely 2^63, which is
>                    roughly  8 * "10^18", or circa 500 000 times larger
>                    than EXT2/EXT3 format maximum.

The top 4 st_size bits get stolen, so it's 60-bit sizes.
You also get the 32-bit block limit at 16 TB.

