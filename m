Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269241AbTCBQ7s>; Sun, 2 Mar 2003 11:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269242AbTCBQ7s>; Sun, 2 Mar 2003 11:59:48 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:26103 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S269241AbTCBQ7r>; Sun, 2 Mar 2003 11:59:47 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [PATCH] reduce large stack usage
Date: Sun, 2 Mar 2003 18:07:53 +0100
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <3E6222A7.9030705@colorfullife.com>
In-Reply-To: <3E6222A7.9030705@colorfullife.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303021807.54284.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 02 March 2003 16:26, Manfred Spraul wrote:

> What do you mean with broken? On i386, the function needs 32 byte stack
> + the space for register saving.
> It must be either a gcc bug, or a bug in your detection script - I don't
> see anything special in twofish_setkey.

You are right that the code itself is not broken -- I did not read it 
properly at first. The stack frame gets small if I compile for s390x
with -fno-schedule-insn, so I suppose that optimization does
not work to well on this particular code. I'll try a different compiler
tomorrow.

I can verify the 32 bytes on i386 with both gcc-3.2 and gcc-3.3-snapshot.
However, when compiling i386 twofish with gcc-2.95, I get an 804 bytes
stack frame. Other architectures are probably somewhere in between
i386 and s390x here, so there should be done something about this.

	Arnd <><
