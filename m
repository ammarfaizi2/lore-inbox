Return-Path: <linux-kernel-owner+w=401wt.eu-S1947445AbWLHWRU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947445AbWLHWRU (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 17:17:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947444AbWLHWRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 17:17:20 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:40336 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1947445AbWLHWRT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 17:17:19 -0500
Subject: Re: [patch 1/2] agpgart - allow user-populated memory types.
From: Arjan van de Ven <arjan@infradead.org>
To: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas@tungstengraphics.com>
Cc: Dave Jones <davej@redhat.com>, Dave Airlie <airlied@linux.ie>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <4579ADE3.6040609@tungstengraphics.com>
References: <4579ADE3.6040609@tungstengraphics.com>
Content-Type: text/plain; charset=UTF-8
Organization: Intel International BV
Date: Fri, 08 Dec 2006 23:17:16 +0100
Message-Id: <1165616236.27217.108.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-12-08 at 19:24 +0100, Thomas Hellström wrote:
> 
> +       }
> +
> +       if (alloc_size <= PAGE_SIZE) {
> +               new->memory = kmalloc(alloc_size, GFP_KERNEL);
> +       }
> +       if (new->memory == NULL) {
> +               new->memory = vmalloc(alloc_size); 

this bit is more or less evil as well...

1) vmalloc is expensive all the way, higher tlb use etc etc
2) mixing allocation types is just a recipe for disaster
3) if this isn't a frequent operation, kmalloc is fine upto at least 2
pages; I doubt you'll ever want more



-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

