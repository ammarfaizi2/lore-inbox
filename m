Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261691AbTCaP2a>; Mon, 31 Mar 2003 10:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261693AbTCaP2a>; Mon, 31 Mar 2003 10:28:30 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:37843 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S261691AbTCaP23>; Mon, 31 Mar 2003 10:28:29 -0500
Date: Mon, 31 Mar 2003 16:39:39 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Lawrence Walton <lawrence@the-penguin.otak.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: MCE error
Message-ID: <20030331153939.GA32463@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Lawrence Walton <lawrence@the-penguin.otak.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20030330184756.GA22307@the-penguin.otak.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030330184756.GA22307@the-penguin.otak.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 30, 2003 at 10:47:56AM -0800, Lawrence Walton wrote:
 > I just got a MCE error while running 2.5.65 "MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
 > Bank 2: 940040000000017a" did a google search and found Dave Jones's parsemce, and decoded it to
 > 
 > Status: (ba) Error IP valid
 > Restart IP invalid.
 > 
 > And was wondering what that actually meant. :) 

Incomplete dump, what it really means.. 

(davej@deviant:davej)$ ./a.out -b 2 -e 0xba -s 940040000000017a -a 0
Status: (186) Error IP valid
Restart IP invalid.
parsebank(2): 940040000000017a @ 0
	External tag parity error
	Correctable ECC error
	Address in addr register valid
	Error enabled in control register
	Memory heirarchy error
	Request: Generic error
	Transaction type : Generic
	Memory/IO : I/O

Looks like the L2 cache ECC checking spotted something going wrong,
and fixed it up. This can happen in cases where there is inadequate
cooling, power, or overclocking (or in rare circumstances, flaky CPUs)

		Dave

