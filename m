Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288248AbSBUXqw>; Thu, 21 Feb 2002 18:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288012AbSBUXqj>; Thu, 21 Feb 2002 18:46:39 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:26838 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S288325AbSBUXqY>;
	Thu, 21 Feb 2002 18:46:24 -0500
Date: Thu, 21 Feb 2002 15:46:01 -0800
To: fabrizio.gennari@philips.com
Cc: linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk, abbotti@mev.co.uk
Subject: Re: [PATCH] Kernel support for 16C950's CPR register
Message-ID: <20020221154601.B5273@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <OFB97BA691.962BF699-ONC1256B66.00546B48@diamond.philips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <OFB97BA691.962BF699-ONC1256B66.00546B48@diamond.philips.com>; from fabrizio.gennari@philips.com on Wed, Feb 20, 2002 at 04:56:03PM +0100
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2002 at 04:56:03PM +0100, fabrizio.gennari@philips.com wrote:
> The 16C950 serial port from Oxford Semiconductor has a special register, 
> called CPR (Clock Predivisor Register). This increases in steps of 1/8, 
> thus allowing a finer control on the generated baud rate than the ordinary 
> divisor registers DLL and DLM, that only increase in steps of 1.
> 
> There are 3 patches for CPR:
> 1. one written by me
> 2. one written by Jean Tourrilhes
> 3. one written by Ian Abbott
> 
> Patches 1 and 3 are available at 
> http://sourceforge.net/tracker/?atid=300310&group_id=310&func=browse . 
> Patch 2 is available at 
> http://www.geocrawler.com/archives/3/8352/2001/10/0/6948700/ .

	My patch is also available at :
		http://www.hpl.hp.com/personal/Jean_Tourrilhes/bt/

> 1. My patch is crap :) Avoid
> 2. Jean Tourrilhes' patch does not use CPR if the requested speed is 
> higher than 115200 b/s. This is fine if the clock frequency is an integral 
> multiple of 16*115200=1843200, but otherwise it does not exploit CPR's 
> potential of fine-tuning speed.
> 3. Ian Abbott's patch is by far the best

	Well... I disagree. My patches has advantage over Ian's patch :
		o autoset baud_base/CPR (Ian's patch doesn't)
		o allow to set custom MSR (Ian's patch doesn't)
		o much simpler. My code is readable, has minimal
impact on the general path (non 16C950) and doesn't have ugly gotos
all over the place.
	To claim that Ian's patch is the best, you would need to at
least fix 1 and 2. Number 3 is debatable.
	Regards,

	Jean
