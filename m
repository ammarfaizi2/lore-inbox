Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262415AbSLOT4G>; Sun, 15 Dec 2002 14:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262418AbSLOT4G>; Sun, 15 Dec 2002 14:56:06 -0500
Received: from magic.adaptec.com ([208.236.45.80]:26857 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP
	id <S262415AbSLOT4F>; Sun, 15 Dec 2002 14:56:05 -0500
Date: Sun, 15 Dec 2002 13:01:45 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Keith Owens <kaos@ocs.com.au>, Kevin Easton <kevin@sylandro.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 st + aic7xxx (Adaptec 19160B) + VIA KT333 repeatable
 freeze 
Message-ID: <17460000.1039982505@aslan.btc.adaptec.com>
In-Reply-To: <1047.1039952560@ocs3.intra.ocs.com.au>
References: <1047.1039952560@ocs3.intra.ocs.com.au>
X-Mailer: Mulberry/3.0.0b9 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 13 Dec 2002 11:51:27 +1100, 
> Kevin Easton <kevin@sylandro.com> wrote:
>> I'm not sure exactly where this problem fits in, but I'm getting a 
>> completely repeatable freeze (100% lockup, no response to keyboard)
>> triggered by writing to /dev/st0 (dd if=/dev/urandom of=/dev/st0 bs=512
>> count=163840 will reproduce it).
>> So... does anyone have any ideas how I should start trying to track this
>> down?

You might also look into your BIOS to ensure that the option "PCI Byte
Merging" is disabled.  This option allows the chipset to perform illegal
byte merging on the PCI bus that will upset the Adaptec.  Since the byte
merging will only occur in certain scenarios (heavily dependent on what
is going on with the SCSI bus), you may only see the lockup when accessing
a particular device or running a certain program.

The latest versions of the aic7xxx and aic79xx drivers will automatically
detect this broken VIA behavior and will fall back to using PIO for register
access.  Although I haven't generated patches against 2.4.20, you can pull
down a src tarball for 2.4.X that should just drop in:

http://~people.FreeBSD.org/~gibbs/linux/SRC/

--
Justin

