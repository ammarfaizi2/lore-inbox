Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266161AbRGLQKE>; Thu, 12 Jul 2001 12:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266158AbRGLQJy>; Thu, 12 Jul 2001 12:09:54 -0400
Received: from inet-mail4.oracle.com ([148.87.2.204]:6106 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id <S266164AbRGLQJm>; Thu, 12 Jul 2001 12:09:42 -0400
Message-ID: <3B4DCBB1.A9EC8C04@oracle.com>
Date: Thu, 12 Jul 2001 09:09:21 -0700
From: Lance Larsh <Lance.Larsh@oracle.com>
Organization: Oracle Corporation
X-Mailer: Mozilla 4.7 [en]C-CCK-MCD  (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <freitag@alancoxonachip.com>
CC: llarsh@oracle.com, linux-kernel@vger.kernel.org, mason@suse.com
Subject: Re: 2x Oracle slowdown from 2.2.16 to 2.4.4
In-Reply-To: <Pine.LNX.4.21.0107111530170.2342-100000@llarsh-pc3.us.oracle.com.suse.lists.linux.kernel> <oup8zhue9on.fsf@pigdrop.muc.suse.de>
Content-Type: multipart/mixed;
 boundary="------------35A2B0643D74B48D1725D962"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------35A2B0643D74B48D1725D962
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Andi Kleen wrote:

> My understanding is that this is normally true for Oracle, but probably
> not for iozone so it would be better if you benchmarked random writes
> to an already allocated file.

You are correct that this is true for Oracle:  we preallocate the file at db create
time, and we use O_DSYNC to avoid atime updates.  The same is true for iozone:  it
performs writes to all the blocks (creating the file and allocating blocks), then
rewrites all of the blocks.  The write and rewrite times are measured and reported
in separate.  Naturally, we only care about the rewrite times, and those are the
results I'm quoting when I casually use the term "writes".  Also, we pass the "-o"
option to iozone, which causes it to open the file with O_SYNC (which on Linux is
really O_DSYNC), just like Oracle does.  So, the mode I'm running iozone in really
does model Oracle i/o.  Sorry if that wasn't clear.

Thanks,
Lance



--------------35A2B0643D74B48D1725D962
Content-Type: text/x-vcard; charset=us-ascii;
 name="Lance.Larsh.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for Lance Larsh
Content-Disposition: attachment;
 filename="Lance.Larsh.vcf"

begin:vcard 
n:Larsh;Lance
x-mozilla-html:FALSE
url:http://www.oracle.com
org:Oracle Corporation;<img src=http://www.geocities.com/TheTropics/3068/oraani.gif>
version:2.1
email;internet:Lance.Larsh@oracle.com
title:Principal Software Engineer
adr;quoted-printable:;;500 Oracle Pkwy=0D=0AMS 401ip4;Redwood Shores;CA;94065;
x-mozilla-cpt:;6896
fn:Lance Larsh
end:vcard

--------------35A2B0643D74B48D1725D962--

