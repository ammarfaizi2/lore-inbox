Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266535AbUHXFEi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266535AbUHXFEi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 01:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266527AbUHXFEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 01:04:36 -0400
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:23954 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266535AbUHXFE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 01:04:26 -0400
Message-ID: <412ACC56.1020902@triplehelix.org>
Date: Mon, 23 Aug 2004 22:04:22 -0700
From: Joshua Kwan <joshk@triplehelix.org>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040819)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: config language shortcomings in 2.4
References: <20040819071229.GA7598@darjeeling.triplehelix.org> <20040819072826.GA16709@alpha.home.local>
In-Reply-To: <20040819072826.GA16709@alpha.home.local>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
> Anyway, I believe that you have no other choice due to the way dep_tristate
> works. What would you expect it to do when it depends on 3 variables which
> are respectively 'n', 'm' and 'y' ? Honnestly, without looking closer at its
> implementation, I would not be able to give a valid response.
> 
> BTW, have you tried defining a temporary variable somewhere ? There are
> portions of config where you see things such as :
> 
> if [ CONFIG_XX = "y" -o CONFIG_YY = "m" -a CONFIG_ZZ = "y" ]; then
>    TEMP=y
> fi
> dep_tristate "cool feature" CONFIG_COOL $TEMP
> 
> Perhaps it could help you define complex combinations.

Sorry for the belated response, but certainly it should not be necessary 
to do:

if [ "$CONFIG_FW_LOADER" = "m" -o "$CONFIG_FW_LOADER" = "y" ]; then
	HAVE_SOME_FW_LOADER=y
fi
if [ "$CONFIG_CRC32" = "m" -o "$CONFIG_CRC32" = "m" ]; then
	HAVE_SOME_CRC32=y
fi

if [ "$HAVE_SOME_CRC32" = "y" -a "$HAVE_SOME_FW_LOADER" = "y" ]; then
	dep_tristate 'Broadcom Tigon3 support' CONFIG_TIGON3 $CONFIG_PCI 
$HAVE_SOME_FW_LOADER $HAVE_SOME_CRC32
fi

just to enforce an explicit dependency on some form of CONFIG_CRC32 and 
CONFIG_FW_LOADER. This is necessary because "$CONFIG_CRC32" != "n" 
doesn't work the way you think it would.

Anyway, it's all very disgusting and I'm inclined to just ignore it and 
maybe some benevolent soul will one day port Kconfig back to 2.4.

-- 
Joshua Kwan
