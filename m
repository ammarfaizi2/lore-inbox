Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262885AbTDYDC6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 23:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262856AbTDYDC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 23:02:58 -0400
Received: from holomorphy.com ([66.224.33.161]:29615 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262885AbTDYDC4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 23:02:56 -0400
Date: Thu, 24 Apr 2003 20:14:59 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: jds <jds@soltis.cc>
Cc: linux-kernel@vger.kernel.org
Subject: Re: busy_loop in compile kernel 2.5.68-mm2
Message-ID: <20030425031459.GR8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	jds <jds@soltis.cc>, linux-kernel@vger.kernel.org
References: <20030425022510.M26474@soltis.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030425022510.M26474@soltis.cc>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 24, 2003 at 08:28:12PM -0600, jds wrote:
>     I have problems when compile kernel 2.5.68-mm2 the message is:
>     make -f scripts/Makefile.build obj=net/unix
[...]
> arch/i386/pci/built-in.o  net/built-in.o --end-group  -o .tmp_vmlinux1
> drivers/built-in.o(.text+0x9d70b): In function `busy_loop':
> : undefined reference to `save_flags'
> drivers/built-in.o(.text+0x9d710): In function `busy_loop':
> : undefined reference to `sti'
> drivers/built-in.o(.text+0x9d72d): In function `busy_loop':
> : undefined reference to `restore_flags'
> make: *** [.tmp_vmlinux1] Error 1
>   Help me please
>   Regards

You have an SMP-unsafe driver configured.
A little birdy called grep(1) told me:

$ grep -nr busy_loop drivers           
drivers/net/pcmcia/xirc2ps_cs.c:443:busy_loop(u_long len)
drivers/net/pcmcia/xirc2ps_cs.c:1788:    busy_loop(HZ/25);                   /* wait 40 msec */
drivers/net/pcmcia/xirc2ps_cs.c:1793:    busy_loop(HZ/50);                   /* wait 20 msec */
drivers/net/pcmcia/xirc2ps_cs.c:1807:    busy_loop(HZ/50);                   /* wait 20 msec */
drivers/net/pcmcia/xirc2ps_cs.c:1809:    busy_loop(HZ/25);                   /* wait 40 msec */
drivers/net/pcmcia/xirc2ps_cs.c:1820:    busy_loop(HZ/2);               /* about 500ms */
drivers/net/pcmcia/xirc2ps_cs.c:1839:    busy_loop(HZ/25);                   /* wait 40 msec to let it complete */
drivers/net/pcmcia/xirc2ps_cs.c:1898:       busy_loop(HZ/50);
drivers/net/pcmcia/xirc2ps_cs.c:1907:       busy_loop(HZ/25);   /* wait 40 msec to let it complete */
drivers/net/pcmcia/xirc2ps_cs.c:2000:       busy_loop(HZ/10);    /* wait 100 msec */


-- wli
