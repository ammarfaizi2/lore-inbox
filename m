Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264945AbTAXTy5>; Fri, 24 Jan 2003 14:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264925AbTAXTy5>; Fri, 24 Jan 2003 14:54:57 -0500
Received: from pizda.ninka.net ([216.101.162.242]:12012 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264945AbTAXTy4>;
	Fri, 24 Jan 2003 14:54:56 -0500
Date: Fri, 24 Jan 2003 11:52:52 -0800 (PST)
Message-Id: <20030124.115252.24531266.davem@redhat.com>
To: bgoglin@ens-lyon.fr
Cc: linux-kernel@vger.kernel.org
Subject: Re: AH transformation broken since 2.5.56
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030124100530.GA32263@ens-lyon.fr>
References: <20030124100530.GA32263@ens-lyon.fr>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Brice Goglin <bgoglin@ens-lyon.fr>
   Date: Fri, 24 Jan 2003 11:05:30 +0100

   My problem was based on the fact that you can disable
   CONFIG_CRYPTO_HMAC by disabling CONFIG_CRYPTO. But this will not
   disable CONFIG_INET_AH.
   
   Shouldn't there be a fix in dependencies between CONFIG_CRYPTO
   and CONFIG_CRYPTO_HMAC, or between CONFIG_INET_AH and
   CONFIG_CRYPTO ?

If you override the defaults, the responsibility lands in your
hands to do the right thing.

The only facility we have right now is to choose the defaults
sensibly for you, and if you look at crypto/Kconfig we are
doing exactly that.  It checks there fore whether AH or ESP
have been enabled, and chooses a default based upon that.

Also, CRYPTO selection comes after the ipsec choices.  So the
only thing we can do is make decisions based upon whether
you've enabled AH or ESP not the other way around.

Whether there should be a way to FORCE config options on or off
(instead of controlling the default) to avoid situations like this is
a seperate topic.
