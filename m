Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261193AbUKNEYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbUKNEYc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 23:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbUKNEYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 23:24:32 -0500
Received: from fw.osdl.org ([65.172.181.6]:53941 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261193AbUKNEY2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 23:24:28 -0500
Message-ID: <4196DD9B.10001@osdl.org>
Date: Sat, 13 Nov 2004 20:22:51 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Karel Kulhavy <clock@twibright.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: pcf8591 range list syntax
References: <20041112142525.GA19825@beton.cybernet.src>
In-Reply-To: <20041112142525.GA19825@beton.cybernet.src>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karel Kulhavy wrote:
> Hello
> 
> modinfo pcf8591 in 2.6.8.1 says:
> "parm:           probe_range:List of adapter,start-addr,end-addr triples to
> scan additionally "
> 
> when I call modprobe pcf8591 probe_range=..., what is the syntax of the list?
> Are the addresses in decimal (0,255) or hexa (0,ff) or variable base
> (0,0xff)?
> 
> When I want to specify 2 triples say 0,0,8 and 1,4,6 , is it
> probe_range=0,0,8,1,4,6 or probe_range={0,0,8},{1,4,6} or something like
> this or something completely different?

Wow.  Good questions.  Those I2C module param. macros are fugly.

probe_range=list_of_up_to_48_entries
It's just a comma-separated list.
Don't put braces or parens or anything around the "triples".
E.g.,
probe_range=0,0,8,1,4,6
(that's 6 entries in the 'probe_range' list, not 2)

Parameter conversion is done by calling simple_strtoul (in this case),
since the parameter type is ushort.  The specified number base
is 0, which means base 10, unless some other base is specified,
with 0x or 0X meaning hex, or a leading 0 without an [xX]
following it means octal.

-- 
~Randy

PS:  This is just from scanning the source code.  I don't
know the I2C code.
