Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263024AbUHSHpc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263024AbUHSHpc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 03:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263093AbUHSHpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 03:45:32 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:13576 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S263024AbUHSHpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 03:45:30 -0400
Date: Thu, 19 Aug 2004 09:28:27 +0200
From: Willy Tarreau <willy@w.ods.org>
To: joshk@triplehelix.org, linux-kernel@vger.kernel.org
Subject: Re: config language shortcomings in 2.4
Message-ID: <20040819072826.GA16709@alpha.home.local>
References: <20040819071229.GA7598@darjeeling.triplehelix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040819071229.GA7598@darjeeling.triplehelix.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Aug 19, 2004 at 12:12:29AM -0700, Joshua Kwan wrote:
 
> Eventually we continued droning through the corner cases until reaching
> 
> if [ "$CONFIG_EXPERIMENTAL" = "y" -a \
>      "$CONFIG_HOTPLUG" = "y" -a \
>      "$CONFIG_FW_LOADER" = "y" -o "$CONFIG_FW_LOADER" = "m" -a \
>      "$CONFIG_CRC32" = "y" -o "$CONFIG_CRC32" = "m" ]; then
>        dep_tristate 'Broadcom Tigon3 support' CONFIG_TIGON3 $CONFIG_PCI $CONFIG_FW_LOADER $CONFIG_CRC32
> fi
> 
> which finally has the desired effect.

I'm surprized, because I think you have a precedence problem here. Your 'if'
condition will be true if either :
  CONFIG_CRC32 = m
or
  CONFIG_CRC32 = y and CONFIG_FW_LOADER = m
or
  CONFIG_FW_LOADER = y and CONFIG_HOTPLUG = y and CONFIG_EXPERIMENTAL = y

Anyway, I believe that you have no other choice due to the way dep_tristate
works. What would you expect it to do when it depends on 3 variables which
are respectively 'n', 'm' and 'y' ? Honnestly, without looking closer at its
implementation, I would not be able to give a valid response.

BTW, have you tried defining a temporary variable somewhere ? There are
portions of config where you see things such as :

if [ CONFIG_XX = "y" -o CONFIG_YY = "m" -a CONFIG_ZZ = "y" ]; then
   TEMP=y
fi
dep_tristate "cool feature" CONFIG_COOL $TEMP

Perhaps it could help you define complex combinations.

Regards,
Willy

