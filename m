Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030813AbWJDLDO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030813AbWJDLDO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 07:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030820AbWJDLDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 07:03:14 -0400
Received: from mx1.suse.de ([195.135.220.2]:33712 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030813AbWJDLDN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 07:03:13 -0400
From: Andi Kleen <ak@suse.de>
To: vgoyal@in.ibm.com
Subject: Re: [PATCH 3/12] i386: Force section size to be non-zero to prevent a symbol becoming absolute
Date: Wed, 4 Oct 2006 13:02:46 +0200
User-Agent: KMail/1.9.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, horms@verge.net.au, lace@jankratochvil.net,
       hpa@zytor.com, magnus.damm@gmail.com, lwang@redhat.com,
       dzickus@redhat.com, maneesh@in.ibm.com
References: <20061003170032.GA30036@in.ibm.com> <20061003170908.GC3164@in.ibm.com>
In-Reply-To: <20061003170908.GC3164@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610041302.46672.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>    /* writeable */
> @@ -64,6 +66,7 @@ SECTIONS
>  	*(.data.nosave)
>    	. = ALIGN(4096);
>    	__nosave_end = .;
> +	LONG(0)
>    }
>  
>    . = ALIGN(4096);

You're wasting one full page once for each of these LONG(0)s because
of the following 4096 alignment.

Isn't there some way to do this less wastefull?

-Andi
