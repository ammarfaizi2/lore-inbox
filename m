Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750948AbWHCAf7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbWHCAf7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 20:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbWHCAf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 20:35:59 -0400
Received: from gw.goop.org ([64.81.55.164]:36299 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1750948AbWHCAf6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 20:35:58 -0400
Message-ID: <44D144EC.3000205@goop.org>
Date: Wed, 02 Aug 2006 17:35:56 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: Jeremy Fitzhardinge <jeremy@xensource.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       Chris Wright <chrisw@sous-sol.org>
Subject: Re: [patch 2/8] Implement always-locked bit ops, for memory shared
 with an SMP hypervisor.
References: <20060803002510.634721860@xensource.com> <20060803002518.061401577@xensource.com> <Pine.LNX.4.64.0608021726540.25963@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0608021726540.25963@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> I think I asked this before....
>
> Would it not be simpler to always use the locked implementation on UP? At 
> least when the kernel is compiled with hypervisor support? This is going 
> to add yet another series of bit operations

You mean make the standard bit-ops atomic on UP when compiling for 
CONFIG_PARAVIRT?  We think its too much of a burden; there are only a 
few operations which must be locked in the hypervisor case, and bit ops 
are used everywhere.  I'd like to get it to the point where there's no 
significant overhead in configuring for PARAVIRT, even if you run on 
native hardware.

    J
