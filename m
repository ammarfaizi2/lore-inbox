Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751233AbWJ3MN5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbWJ3MN5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 07:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbWJ3MN5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 07:13:57 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:19870 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751233AbWJ3MN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 07:13:56 -0500
Subject: Re: [RFC 4/7][PATCH] AMBA DMA: Add a driver module for the DMA
	controller.
From: Arjan van de Ven <arjan@infradead.org>
To: Peter Pearse <peter.pearse@arm.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <CAM-OWA1NTX9gHWdm4j00000005@cam-owa1.Emea.Arm.com>
References: <CAM-OWA1NTX9gHWdm4j00000005@cam-owa1.Emea.Arm.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 30 Oct 2006 13:13:54 +0100
Message-Id: <1162210434.2948.13.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-30 at 12:02 +0000, Peter Pearse wrote:
> }
> +/* 
> + * Export wrapped find_module to allow drivers to find their modules
> + * Useful for e.g. controlling the usage count
> + */ 
> +struct module *try_find_module(const char *name)
> +{
> +       struct module *mod;
> +       mutex_lock(&module_mutex);
> +       mod = find_module(name);
> +       mutex_unlock(&module_mutex);
> +       return mod;
> +}
> +EXPORT_SYMBOL(try_find_module);
> + 

this looks very very wrong to me.
It's racey for one, and for another, module names sound wrong. You want
to be using the symbol it provides instead, and then use __symbol_get()
and friends...

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

