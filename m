Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262634AbUENUeZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262634AbUENUeZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 16:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262744AbUENUeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 16:34:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:28349 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262634AbUENUeY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 16:34:24 -0400
Date: Fri, 14 May 2004 13:33:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Michael Buesch <mbuesch@freenet.de>
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.6] bootmem.c cleanup
Message-Id: <20040514133353.236acf3a.akpm@osdl.org>
In-Reply-To: <200405142205.27214.mbuesch@freenet.de>
References: <200405142205.27214.mbuesch@freenet.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Buesch <mbuesch@freenet.de> wrote:
>
>  -		if (!test_and_clear_bit(i, bdata->node_bootmem_map))
>  -			BUG();
>  +		BUG_ON(!test_and_clear_bit(i, bdata->node_bootmem_map));

Please don't put expressions whihc actually change state inside BUG_ON(). 
Someone may decide to make BUG_ON() a no-op to save space.

I'm not aware of anyone actually trying that, but it's a good objective.
