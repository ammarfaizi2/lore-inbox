Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265200AbTFEVsW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 17:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265203AbTFEVsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 17:48:21 -0400
Received: from fmr01.intel.com ([192.55.52.18]:22013 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S265200AbTFEVsU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 17:48:20 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780D6F141B@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'lkml (linux-kernel@vger.kernel.org)'" 
	<linux-kernel@vger.kernel.org>
Subject: RE: How to initialize complex per-cpu variables?
Date: Thu, 5 Jun 2003 15:01:14 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Perez-Gonzalez, Inaky [mailto:inaky.perez-gonzalez@intel.com]
> ...
> Now the question is: how do I walk each structure that is
> associated to each CPU - I mean, something like:
> 
> struct rtf_h *h;
> for_each_cpu (h, rtf_lh) {
> 	rtf_h_init (h);
> }

Uh, I think it can be done perfectly as:

on_each_cpu (rtf_h_init, NULL, 1, 1);

with:

rtf_h_init (void *dummy) {
	const int cpu = get_cpu();
	struct rtf_h *h = per_cpu (rtf_lh, cpu);
	/* ... blah ... init the queues */
	put_cpu();
}

If I am wrong, pls let me know ...

TIA again

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)

