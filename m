Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261330AbTBOLGv>; Sat, 15 Feb 2003 06:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261426AbTBOLGv>; Sat, 15 Feb 2003 06:06:51 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:21513 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261330AbTBOLGv>; Sat, 15 Feb 2003 06:06:51 -0500
Date: Sat, 15 Feb 2003 11:16:42 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Bob Miller <rem@osdl.org>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.60 2/9] Update parport class driver to new module loader API.
Message-ID: <20030215111642.A17769@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Bob Miller <rem@osdl.org>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <20030214234557.GC13336@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030214234557.GC13336@doc.pdx.osdl.net>; from rem@osdl.org on Fri, Feb 14, 2003 at 03:45:57PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2003 at 03:45:57PM -0800, Bob Miller wrote:
> -	void (*inc_use_count)(void);
> +	int (*inc_use_count)(void);
>  	void (*dec_use_count)(void);

This is broken.  You need

	struct module *owner;

here and use try_module_et/module_put before calling into the module.

