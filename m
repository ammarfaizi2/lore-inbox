Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261270AbVFHOpC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbVFHOpC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 10:45:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261261AbVFHOpC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 10:45:02 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:41154 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261283AbVFHOog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 10:44:36 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Pavel Machek <pavel@ucw.cz>, Jeff Garzik <jgarzik@pobox.com>,
       Netdev list <netdev@oss.sgi.com>,
       kernel list <linux-kernel@vger.kernel.org>,
       "James P. Ketrenos" <ipw2100-admin@linux.intel.com>
Subject: Re: ipw2100: firmware problem
Date: Wed, 8 Jun 2005 17:44:20 +0300
User-Agent: KMail/1.5.4
References: <20050608142310.GA2339@elf.ucw.cz>
In-Reply-To: <20050608142310.GA2339@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506081744.20687.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 June 2005 17:23, Pavel Machek wrote:
> Hi!
> 
> I'm fighting with firmware problem: if ipw2100 is compiled into
> kernel, it is loaded while kernel boots and firmware loader is not yet
> available. That leads to uninitialized (=> useless) adapter.
> 
> What's the prefered way to solve this one? Only load firmware when
> user does ifconfig eth1 up? [It is wifi, it looks like it would be
> better to start firmware sooner so that it can associate to the
> AP...].

Do you want to associate to an AP when your kernel boots,
_before_ any iwconfig had a chance to configure anything?
That's strange.

My position is that wifi drivers must start up in an "OFF" mode.
Do not send anything. Do not join APs or start IBSS.
Thus, no need to load fw in early boot.

Driver may load firmware and start actively doing something
only when iwconfig gets executed and thus driver is
instructed what to do.

Some drivers currently do not act this way, and thus
less advanced users may unknowingly run a wireless STA
(or worse, an AP!) on their notebook for years, interfering
with neighbors and/or violating local regulations (there are
countrles where 802.11 use needs licensing).
--
vda



