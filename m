Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264290AbUAHKhy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 05:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264303AbUAHKhy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 05:37:54 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:37826 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S264290AbUAHKhp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 05:37:45 -0500
Date: Thu, 8 Jan 2004 02:39:04 -0800
From: Paul Jackson <pj@sgi.com>
To: Joe Korty <joe.korty@ccur.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: seperator error in __mask_snprintf_len
Message-Id: <20040108023904.60b341da.pj@sgi.com>
In-Reply-To: <20040108033224.GA13325@rudolph.ccur.com>
References: <20040107165607.GA11483@rudolph.ccur.com>
	<20040107170650.0fca07a7.pj@sgi.com>
	<20040108033224.GA13325@rudolph.ccur.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe noted:
> Paul, there might be a problem with __mask_snprintf_len.  Won't a
> value that should be displayed as:
> 
>      d,00abcdef      be displayed as
>      d,abcdef

You are correct that it will be displayed without zero padding.

But I don't think that's a problem; rather working as designed.

An example that suggests the motivation for this design choice is given
in the examples in the mask.c comment:

 *   A mask with just bit 127 set displays as "80000000,0,0,0".

With zero padding, this example gets longer.  For masks of 500 or a 1000
bits encoding a single high set bit, it's worse, resulting in several
text lines of ",00000000" words.

If you have reason to claim that it would be better to zero fill
these words, go ahead and make your case.

There are hundreds of possible ways of formatting the ascii
representation of bit masks; I picked one that I liked.  If good reasons
or a concensus develop for some other format, that's fine.
Better to change now than later.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
