Return-Path: <linux-kernel-owner+w=401wt.eu-S932101AbXAIOFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbXAIOFj (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 09:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbXAIOFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 09:05:39 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:59836 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932101AbXAIOFj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 09:05:39 -0500
Subject: Re: [PATCH] agpgart: Allow drm-populated agp memory types
From: Arjan van de Ven <arjan@infradead.org>
To: thomas@tungstengraphics.com
Cc: davej@redhat.com, linux-kernel@vger.kernel.org, arlied@gmail.com
In-Reply-To: <11683309992144-git-send-email-thomas@tungstengraphics.com>
References: <11682488182899-git-send-email-thomas@tungstengraphics.com>
	 <11683309992144-git-send-email-thomas@tungstengraphics.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 09 Jan 2007 06:05:37 -0800
Message-Id: <1168351537.3180.270.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2007-01-09 at 09:23 +0100, thomas@tungstengraphics.com wrote:
> +
> +void agp_vkmalloc(size_t size, unsigned long **addr, u8 *vmalloc_flag)
> +{
> +	void *tmp = NULL;
> +
> +	*vmalloc_flag = 0;
> +
> +	if (size <= 2*PAGE_SIZE) {
> +		tmp = kmalloc(size, GFP_KERNEL);
> +	}
> +	if (tmp == NULL) {
> +		tmp = vmalloc(size);
> +		*vmalloc_flag = 1;
> +	}
> +
> +	*addr = tmp;
> +}
> +EXPORT_SYMBOL(agp_vkmalloc);


if you don't do this "fallback" thing the caller can just know it is
vmalloc due to the size... (and a 2 page kmalloc isn't going to fail on
you with GFP_KERNEL; also if you really want to deal with this failure
also tell the VM you're ok with failure (__GFP_NORETRY and such)...
but unless you do, things get a lot simpler by not doing this "fall
back" thing.

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

