Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932304AbWBPQJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbWBPQJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 11:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbWBPQJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 11:09:29 -0500
Received: from mo01.iij4u.or.jp ([210.130.0.20]:21733 "EHLO mo01.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S932304AbWBPQJ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 11:09:29 -0500
Date: Fri, 17 Feb 2006 01:09:19 +0900 (JST)
Message-Id: <20060217.010919.121148551.toriatama@inter7.jp>
To: paulkf@microgate.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: PPP with PCMCIA modem stalls on 2.6.10 or later
From: Kouji Toriatama <toriatama@inter7.jp>
In-Reply-To: <1140019368.3119.12.camel@amdx2.microgate.com>
References: <1139937159.3189.4.camel@amdx2.microgate.com>
	<20060215.221135.121135595.toriatama@inter7.jp>
	<1140019368.3119.12.camel@amdx2.microgate.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Fulghum <paulkf@microgate.com> wrote:
  > Try the following patch, and report the syslog output.
  > 
  > This may be lost receive data due to full flip buffer.
  > 2.6.9 would try processing rx data in the ISR if the
  > flip buffer was full. This violated locking requirements
  > and was changed to only process rx data in scheduled work.
  > This can slow the processing of data.

I have tried your patch.  The following is a part of syslog
output.
------------------------------------------------------------------
Feb 16 23:52:40 moka kernel: receive_chars:flip full:low_latency=0
Feb 16 23:52:40 moka kernel: receive_chars:flip full:discard char
------------------------------------------------------------------
I have got this pair of two lines many times while running the
wget command.


  > Also try using the setserial utility to set
  > the 'low_latency' option for the device. That should
  > operate the same as 2.6.9 (which can be dangerous).

With 'low_latency' option in 2.6.15 with your patch, the problem
did not occur and no output from syslog.


  > The improved flip buffering code in 2.6.16-rc3
  > should also prevent any loss of data. If possible,
  > try 2.6.16-rc3.

I have tried 2.6.16-rc3.  With or without 'low_latency' option,
the problem did not occur.  It seems to work fine!  I will use
2.6.16-rc3 or later.

If you have any additional plan to pin down this problem, I will
try your patch.


Thank you for your help,
Kouji Toriatama
