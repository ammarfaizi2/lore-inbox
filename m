Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265285AbTCEVaf>; Wed, 5 Mar 2003 16:30:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266114AbTCEVaf>; Wed, 5 Mar 2003 16:30:35 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:55942 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S265285AbTCEVaA>; Wed, 5 Mar 2003 16:30:00 -0500
Date: Wed, 5 Mar 2003 22:40:17 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Russell King <rmk@arm.linux.org.uk>, kraxel@bytesex.org,
       linux-kernel@vger.kernel.org
Subject: Re: reducing stack usage in v4l?
Message-ID: <20030305214017.GA25225@wohnheim.fh-wedel.de>
References: <32833.4.64.238.61.1046841945.squirrel@www.osdl.org> <87u1eigomv.fsf@bytesex.org> <20030305093534.A8883@flint.arm.linux.org.uk> <20030305073437.0673458e.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030305073437.0673458e.rddunlap@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 March 2003 07:34:37 -0800, Randy.Dunlap wrote:
> Russell King <rmk@arm.linux.org.uk> wrote:
> | On Wed, Mar 05, 2003 at 10:15:52AM +0100, Gerd Knorr wrote:
> 
> | > Not sure what is the best idea to fix that.  Don't like the kmalloc
> | > idea that much.  The individual structs are not huge, the real problem
> | > is that many of them are allocated and only few are needed.  Any
> | > chance to tell gcc that it should allocate block-local variables at
> | > the start block not at the start of the function?
> | 
> | Not a particularly clean idea, but maybe creating a union of the
> | structures and putting that on the stack? (ie, doing what GCC should
> | be doing in the first place.)
> 
> That's an idea.  Or make separate called functions for each ioctl and declare
> the structures inside them?

As far as I have seen, at least ds_ioctl uses the union trick. And the
three marked (*) ioctl-functions appear to be suffering from the same
gcc inability.

How much complaining is necessary for the gcc folks to worry about
this?

0xc0ad420b <snd_emu10k1_fx8010_ioctl+3/5ec>:             sub    $0x814,%esp
0xc06dbd77 <v4l_compat_translate_ioctl+3/159c>:          sub    $0x804,%esp
0xc0521e43 <ida_ioctl+3/388>:                            sub    $0x528,%esp
* 0xc01ed733 <presto_ioctl+3/13c4>:                        sub    $0x4d0,%esp
* 0xc0bfbfd3 <br_ioctl_device+3/454>:                      sub    $0x474,%esp
0xc07968bb <megadev_ioctl+3/c94>:                        sub    $0x394,%esp
* 0xc068ff5b <ray_dev_ioctl+3/8b8>:                        sub    $0x2e0,%esp
0xc0583a63 <netdev_ethtool_ioctl+3/e64>:                 sub    $0x2c8,%esp
0xc0865963 <ds_ioctl+3/6b0>:                             sub    $0x2ac,%esp
0xc04370c3 <vt_ioctl+3/1a84>:                            sub    $0x29c,%esp
0xc054c5eb <e1000_ethtool_ioctl+3/6f8>:                  sub    $0x290,%esp
0xc0299b23 <ncp_ioctl+3/13b0>:                           sub    $0x278,%esp
0xc0532e67 <DAC960_UserIOCTL+3/17c0>:                    sub    $0x230,%esp

Jörn

-- 
Optimizations always bust things, because all optimizations are, in
the long haul, a form of cheating, and cheaters eventually get caught.
-- Larry Wall 
