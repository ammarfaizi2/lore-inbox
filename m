Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266227AbUFPJ4Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266227AbUFPJ4Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 05:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266233AbUFPJ4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 05:56:25 -0400
Received: from ipx-98-250-190-80.ipxserver.de ([80.190.250.98]:61704 "EHLO
	taytron.net") by vger.kernel.org with ESMTP id S266227AbUFPJ4N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 05:56:13 -0400
Message-ID: <40D01928.1080309@tuxbox.org>
Date: Wed, 16 Jun 2004 11:55:52 +0200
From: Florian Schirmer <jolt@tuxbox.org>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
CC: "Randy.Dunlap" <rddunlap@osdl.org>, akpm <akpm@osdl.org>,
       B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [STACK] >3k call path in ide
References: <20040609122921.GG21168@wohnheim.fh-wedel.de> <20040615163445.6b886383.rddunlap@osdl.org> <200406160911.11985.jolt@tuxbox.org> <20040616094737.GA2548@wohnheim.fh-wedel.de>
In-Reply-To: <20040616094737.GA2548@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>Leak memory.  I also tend to depend on the fact that kfree(NULL) works
>just fine:
>
>err_kfree:
>	kfree(cfginfo);
>	kfree(def_cte);
>	kfree(tbuf);
>	printk(KERN_NOTICE "ide-cs: ide_config failed memory allocation\n");
>	goto failed;
>
>Makes the error path a little simpler.
>  
>

Nope. It will deadlock just like the original patch because failed falls 
through to err_kfree which then will jump to failed...

Regards,
    Florian

