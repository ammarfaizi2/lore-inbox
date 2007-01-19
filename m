Return-Path: <linux-kernel-owner+w=401wt.eu-S965166AbXASPCl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965166AbXASPCl (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 10:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965171AbXASPCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 10:02:40 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:31713 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965166AbXASPCk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 10:02:40 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:subject:from:to:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=JjA7U2aCMRT/xEHUjpN4jSYeV05AhC1+e8t5BJEK/v1enPAjMEEzBP6Wp7aGK6yL1n7cCXrofxCeGY5gnRanMFx22xijfyCIitjUyoRAPvcwp9FKccmIP1LCh5cnT+9uybh5+RNBUV1opbMBAQGAsDyGiH/hdKtoC7qlhj1sfMQ=
Subject: question about identiry map(x86)
From: asgard <just.asgard@gmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 19 Jan 2007 18:02:36 +0300
Message-Id: <1169218956.5191.21.camel@midgard>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all.

On early boot stage linux maps only 8M(arch/i386/kernel/head.S).
It creates identity map and kernel map like this:
0x00000000 - 0x007FFFFF -> 0x00000000 -> 0x007FFFFF /* identity map */
0xC0000000 - 0xC07FFFFF -> 0x00000000 -> 0x007FFFFF /* kernel map */

On early boot stage identity map is needed for jumping to 0xC0000000.
Intel manual says, that after such jumping identity map can be deleted.

(arch/i386/mm/init.c)
Linux deletes early boot identity map, but when it maps 1G(all kernel
space) in kernel_physical_map_init, it creates another one identity map:
0x00000000 - 0x01FFFFFF -> 0x00000000 - 0x01FFFFFF /* NEW identity map
*/
0xC0000000 - 0xC1FFFFFF -> 0x00000000 - 0x01FFFFFF /* 1G kernel map */

so, question is: are there any significant reasons to create identity
map after jumping was done? As I know, after jumping kernel doesn't need
in identity map. So, if, for example, PAE is enabled for creation middle
directory kernel allocates 4K. And when identity map creates, kernel
loses some mem. So, why identity map is created in this case.

Thanks and good luck. 

