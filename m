Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261193AbVCMMk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbVCMMk3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 07:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261199AbVCMMk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 07:40:29 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:35983 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S261193AbVCMMkX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 07:40:23 -0500
Date: Sun, 13 Mar 2005 13:43:34 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: John Cherry <cherry@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Gerd Knorr <kraxel@bytesex.org>
Message-ID: <20050313124333.GA26569@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	John Cherry <cherry@osdl.org>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, Gerd Knorr <kraxel@bytesex.org>
References: <200503130508.j2D58jTQ014587@ibm-f.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503130508.j2D58jTQ014587@ibm-f.pdx.osdl.net>
User-Agent: Mutt/1.5.6+20040907i
X-SA-Exim-Connect-IP: 217.86.187.3
Subject: Re: IA32 (2.6.11 - 2005-03-12.16.00) - 56 New warnings
X-SA-Exim-Version: 4.2 (built Tue, 25 Jan 2005 19:36:50 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 12, 2005 at 09:08:45PM -0800, John Cherry wrote:
> drivers/media/dvb/frontends/dvb-pll.c:104: warning: (near initialization for `dvb_pll_unknown_1.entries')
> drivers/media/dvb/frontends/dvb-pll.c:104: warning: excess elements in array initializer
> drivers/media/dvb/frontends/dvb-pll.c:105: warning: (near initialization for `dvb_pll_unknown_1.entries')
> drivers/media/dvb/frontends/dvb-pll.c:105: warning: excess elements in array initializer
[snip]

Gerd's original patch had

	struct dvb_pll_desc {
		char *name;
		u32  min;
		u32  max;
		void (*setbw)(u8 *buf, int bandwidth);
		int  count;
		struct {
			u32 limit;
			u32 offset;
			u32 stepsize;
			u8  cb1;
			u8  cb2;
		} entries[];
	};

while 2.6.11-mm3 changed it into entries[0]. I assume this was made
for gcc-4.0 compatibility? But the element type for entries is
fully defined, so it should not be a problem (as long as no one tries to
created arrays of struct dvb_pll_desc)?

Johannes
