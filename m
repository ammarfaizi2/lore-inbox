Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317269AbSILTta>; Thu, 12 Sep 2002 15:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317278AbSILTt3>; Thu, 12 Sep 2002 15:49:29 -0400
Received: from gherkin.frus.com ([192.158.254.49]:9612 "HELO gherkin.frus.com")
	by vger.kernel.org with SMTP id <S317269AbSILTt3>;
	Thu, 12 Sep 2002 15:49:29 -0400
Message-Id: <m17pa2L-0005khC@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob_Tracy)
Subject: 2.5.34: IR __FUNCTION__ breakage
To: dag@brattli.net
Date: Thu, 12 Sep 2002 14:54:01 -0500 (CDT)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been painstakingly going through all the IR code and fixing up
the __FUNCTION__ breakage.  One of the not obvious patches is for
linux/net/irda/irnet/irnet.h, where string concatenation was fully
taken advantage of :-).

The problem lies in statements such as

#define DERROR(dbg, args...) \
	{if(DEBUG_##dbg) \
		printk(KERN_INFO "irnet: " __FUNCTION__ "(): " args);}

where you really want to avoid having any format strings because
"args" could legally have one (and probably will).  Under the
circumstances, one option might be something like

define DERROR(dbg, args...) \
	{if(DEBUG_##dbg){\
		printk(KERN_INFO "irnet: %s(): ", __FUNCTION__);\
		printk(KERN_INFO args);}}

which strikes me as not quite what the author intended, although it
should work.  Better ideas are welcome, and if a consensus is reached,
I'll be happy to submit the full IR __FUNCTION__ patch set against
2.5.34 for inclusion in a later kernel version.

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
