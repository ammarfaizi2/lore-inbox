Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310838AbSCHMsE>; Fri, 8 Mar 2002 07:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310836AbSCHMry>; Fri, 8 Mar 2002 07:47:54 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:38630 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S310838AbSCHMrt>; Fri, 8 Mar 2002 07:47:49 -0500
Date: Fri, 8 Mar 2002 14:32:55 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Beef Arrowny <tanfhltu@yahoo.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>,
        Andre Hedrick <andre@linux-ide.org>
Subject: Re: Kernel Oops in 2.4.18 (ide.c)
In-Reply-To: <20020306230616.45503.qmail@web9904.mail.yahoo.com>
Message-ID: <Pine.LNX.4.44.0203081329140.5383-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Mar 2002, Beef Arrowny wrote:

> Code;  c01d80c6 <ide_output_data+a6/b0>
> 00000000 <_EIP>:
> Code;  c01d80c6 <ide_output_data+a6/b0>   <=====
>    0:   f3 66 6f                  repz outsw
> %ds:(%esi),(%dx)   <=====
> Code;  c01d80c9 <ide_output_data+a9/b0>

Check out drivers/ide/ide.c:ide_output_data you're dying here...

if (drive->slow) {
	unsigned short *ptr = (unsigned short *) buffer; <==
	while (wcount--) {
		outw_p(*ptr++, IDE_DATA_REG); <== whoopdedoo
		outw_p(*ptr++, IDE_DATA_REG);
		}
	} else


http://groups.google.com/groups?hl=en&threadm=linux.kernel.Pine.LNX.4.44.0202070911321.8308-100000%40netfinity.realnet.co.sz&rnum=1&prev=/groups%3Fq%3Ddrivers/ide/ide.c.orig%2Bgroup:mlist.linux.kernel%2Bgroup:mlist.linux.kernel%26hl%3Den%26selm%3Dlinux.kernel.Pine.LNX.4.44.0202070911321.8308-100000%2540netfinity.realnet.co.sz%26rnum%3D1

is my original posting. Jens sent in a patch which stopped the oops from 
happening in 2.5, i *think* it might have been backported to 2.4, 
essentially it all boiled down to something b0rking the scatter gather 
list (referenced via buffer).

Regards,
	Zwane



