Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261609AbUKCOKb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbUKCOKb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 09:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbUKCOKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 09:10:31 -0500
Received: from hell.sks3.muni.cz ([147.251.210.30]:63883 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S261609AbUKCOK0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 09:10:26 -0500
Date: Wed, 3 Nov 2004 15:10:01 +0100
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Francois Romieu <romieu@fr.zoreil.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 - e1000 - page allocation failed
Message-ID: <20041103141001.GA27969@mail.muni.cz>
References: <20041021221622.GA11607@mail.muni.cz> <20041021225825.GA10844@electric-eye.fr.zoreil.com> <20041022025158.7737182c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20041022025158.7737182c.akpm@osdl.org>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2004 at 02:51:58AM -0700, Andrew Morton wrote:
> I'd be interested in knowing if this fixes it - I don't expect it will,
> because that's a zero-order allocation failure.  He's really out of memory.
> 
> The e1000 driver has a default rx ring size of 256 which seems a bit nutty:
> a back-to-back GFP_ATOMIC allocation of 256 skbs could easily exhaust the
> page allocator pools.
> 
> Probably this machine needs to increase /proc/sys/vm/min_free_kbytes.

However. I have two machines very similar and one opses and one does not.
I wondered why. I've found out that if I turn whole netfilter to module and
disable:
CONFIG_NET_IPGRE=y
CONFIG_IP_MROUTE=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y

Then problem seems to disappeare on both...

(I do not use iptables on any machine)

-- 
Luká¹ Hejtmánek
