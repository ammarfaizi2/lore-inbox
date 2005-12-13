Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932605AbVLMKQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932605AbVLMKQP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 05:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932606AbVLMKQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 05:16:15 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:27364 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932605AbVLMKQN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 05:16:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=uHTMiF/cSSBiNbwKySc90vsTsy8mKNqm/RUJK0gT26UqGzXKxPoTTC1yKlSQ431OJNUdLn39bt5LlYsd8CGfGv8crhpdJkEgQ609nll/yp8AQOSfCQjMr3SRw4uBSzB/H+hzTF8c1ZM6VlvpFUOluxWiMgICBKsMtqYP/PnrsVQ=
Date: Tue, 13 Dec 2005 13:31:35 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, ak@suse.de, mingo@elte.hu,
       dhowells@redhat.com, torvalds@osdl.org, arjan@infradead.org,
       matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: drivers/scsi/sd.c gcc-2.95.3
Message-ID: <20051213103135.GA19500@mipter.zuzino.mipt.ru>
References: <dhowells1134431145@warthog.cambridge.redhat.com> <20051212161944.3185a3f9.akpm@osdl.org> <20051213075441.GB6765@elte.hu> <20051213075835.GZ15804@wotan.suse.de> <20051213004257.0f87d814.akpm@osdl.org> <20051213090331.GB27857@infradead.org> <20051213011413.1288f4cf.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051213011413.1288f4cf.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2005 at 01:14:13AM -0800, Andrew Morton wrote:
> drivers/scsi/sd.c: In function `sd_read_capacity':
> drivers/scsi/sd.c:1301: internal error--unrecognizable insn:
> (insn 1274 1273 1797 (parallel[ 
>             (set (reg:SI 0 %eax)
>                 (asm_operands ("") ("=a") 0[ 
>                         (reg:DI 1 %edx)
>                     ] 
>                     [ 
>                         (asm_input:DI ("A"))
>                     ]  ("drivers/scsi/sd.c") 1282))
>             (set (reg:SI 1 %edx)
>                 (asm_operands ("") ("=d") 1[ 
>                         (reg:DI 1 %edx)
>                     ] 
>                     [ 
>                         (asm_input:DI ("A"))
>                     ]  ("drivers/scsi/sd.c") 1282))
>         ] ) -1 (insn_list 1269 (nil))
>     (nil))
> 
> It'll be workable aroundable of course, but it's a hassle.

FWIW,

--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1282,9 +1282,9 @@ got_data:
 		sector_div(mb, 1950);
 
 		printk(KERN_NOTICE "SCSI device %s: "
-		       "%llu %d-byte hdwr sectors (%llu MB)\n",
+		       "%llu %d-byte hdwr sectors\n",
 		       diskname, (unsigned long long)sdkp->capacity,
-		       hard_sector, (unsigned long long)mb);
+		       hard_sector);
 	}
 
 	/* Rescale capacity to 512-byte units */

