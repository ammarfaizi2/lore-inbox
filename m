Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261772AbULUPVo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261772AbULUPVo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 10:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbULUPVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 10:21:43 -0500
Received: from main.gmane.org ([80.91.229.2]:27300 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261772AbULUPVj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 10:21:39 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ed L Cashin <ecashin@coraid.com>
Subject: Re: [PATCH] ATA over Ethernet driver for 2.6.10-rc3-bk11
Date: Tue, 21 Dec 2004 10:21:28 -0500
Message-ID: <87vfav65jb.fsf@coraid.com>
References: <87k6rhc4uk.fsf@coraid.com>
	<1103356085.3369.140.camel@sfeldma-mobl.dsl-verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-34-230-221.asm.bellsouth.net
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
Cancel-Lock: sha1:w1ElLVbASK/9q/FeMTOMLAttTJk=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Scott Feldman <sfeldma@pobox.com> writes:

> On Fri, 2004-12-17 at 07:38, Ed L Cashin wrote:
>
>> +       ETH_P_AOE = 0x88a2,
>
> include/linux/if_ether.h already defines this as ETH_P_EDP2=0x88A2; use
> that.
>
>> +static int
>> +aoehdr_atainit(struct aoedev *d, struct aoe_hdr *h)
>> +{
>> +       u16 type = __constant_cpu_to_be16(ETH_P_AOE);

> How about __constant_htons()?

Hi.  Andi Kleene and you both ask why we're using the __cpu_to_be16
kind of byte-swappers.

I think it comes down to a semantics thing, and it's probably
controversial.  We are using fixed-size integers, so we specify the
size of the integers.  A short happens to be 16-bits wide on most
architectures, but it needn't be, esp. in the future, so it's more
clear to say what we mean.

-- 
  Ed L Cashin <ecashin@coraid.com>

