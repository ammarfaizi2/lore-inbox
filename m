Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267278AbSLELM0>; Thu, 5 Dec 2002 06:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267283AbSLELM0>; Thu, 5 Dec 2002 06:12:26 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:33292 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267278AbSLELMZ>; Thu, 5 Dec 2002 06:12:25 -0500
Date: Thu, 5 Dec 2002 11:19:13 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: wli@holomorphy.com
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       kernel-janitor-discuss@lists.sourceforge.net, jgarzik@pobox.com,
       miura@da-cha.org, alan@lxorguk.ukuu.org.uk, viro@math.psu.edu,
       pavel@ucw.cz
Subject: Re: [warnings] [2/8] fix uninitialized quot in drivers/serial/core.c
Message-ID: <20021205111913.A18253@flint.arm.linux.org.uk>
Mail-Followup-To: wli@holomorphy.com, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org,
	kernel-janitor-discuss@lists.sourceforge.net, jgarzik@pobox.com,
	miura@da-cha.org, alan@lxorguk.ukuu.org.uk, viro@math.psu.edu,
	pavel@ucw.cz
References: <0212050252.hdcd1a.b3aUbzb5bCbGc3dkcCd8a1atc20143@holomorphy.com> <0212050252.AaCdAbid6d9cabJbEbmaTdZb7daa.c5a20143@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <0212050252.AaCdAbid6d9cabJbEbmaTdZb7daa.c5a20143@holomorphy.com>; from wli@holomorphy.com on Thu, Dec 05, 2002 at 02:52:59AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2002 at 02:52:59AM -0800, wli@holomorphy.com wrote:
> Give quot a default value so it's initialized. rmk, this is yours
> to ack.

Why can't we get this obvious compiler bug fixed?  I'd rather have
the compiler bug fixed rather than trying to work around the bogus
warning.

It's obvious that the loop:

	for (try = 0; try < 3; try++)

is going to be executed at least once, which will initialise quot.

As for the second hunk, its correct in so far as it'll catch the case
where we can't even do 9600 baud.  However, I think we should just
bound the lowest baud rate such that we can always do 9600 baud (and
therefore this function will never return zero.)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

