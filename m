Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264543AbUFPS7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264543AbUFPS7O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 14:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264542AbUFPS7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 14:59:13 -0400
Received: from mail2.iserv.net ([204.177.184.152]:1767 "EHLO mail2.iserv.net")
	by vger.kernel.org with ESMTP id S264530AbUFPS7A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 14:59:00 -0400
Message-ID: <40D0984B.3050405@didntduck.org>
Date: Wed, 16 Jun 2004 14:58:19 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7) Gecko/20040608
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       jolt@tuxbox.org, akpm@osdl.org, B.Zolnierkiewicz@elka.pw.edu.pl,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [STACK] reduce >3k call path in ide
References: <20040609122921.GG21168@wohnheim.fh-wedel.de>	<20040615163445.6b886383.rddunlap@osdl.org>	<200406160911.11985.jolt@tuxbox.org>	<20040616094737.GA2548@wohnheim.fh-wedel.de>	<40D01928.1080309@tuxbox.org>	<20040616100008.GB2548@wohnheim.fh-wedel.de> <20040616103741.042f8029.rddunlap@osdl.org>
In-Reply-To: <20040616103741.042f8029.rddunlap@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> +    tbuf = kmalloc(128 * sizeof(u_short), GFP_KERNEL);
> +    if (!tbuf) goto err_kfree;
> +    def_cte = kmalloc(sizeof(*def_cte), GFP_KERNEL);
> +    if (!def_cte) goto err_kfree;
> +    memset(def_cte, 0, sizeof(*def_cte));
> +    cfginfo = kmalloc(sizeof(*cfginfo), GFP_KERNEL);
> +    if (!cfginfo) goto err_kfree;
> +    cisparse = kmalloc(sizeof(*cisparse), GFP_KERNEL);
> +    if (!cisparse) goto err_kfree;

This can be condensed into a single kmalloc.  Define a struct that 
contains these variables and kmalloc the whole struct in one call.

--
				Brian Gerst
