Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266005AbTFWL3C (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 07:29:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266007AbTFWL3B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 07:29:01 -0400
Received: from firewall.ocs.com.au ([203.34.97.9]:5510 "EHLO
	firewall.ocs.com.au") by vger.kernel.org with ESMTP id S266005AbTFWL26
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 07:28:58 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: simon@nuit.ca
cc: linux-kernel@vger.kernel.org
Subject: Re: problems patching XFS against current benh 
In-reply-to: Your message of "Mon, 23 Jun 2003 10:17:51 GMT."
             <20030623101751.GD2102@nuit.ca> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 23 Jun 2003 21:42:40 +1000
Message-ID: <17391.1056368560@firewall.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jun 2003 10:17:51 +0000, 
simon raven <simon@nuit.ca> wrote:
>/usr/src/kernel_benh/include/linux/modules/ksyms.ver:387:1: warning: "__ver_mark_page_accessed" redefined
>In file included from /usr/src/kernel_benh/include/linux/modversions.h:100,
>                 from /usr/src/kernel_benh/include/linux/module.h:21,
>                 from exec_domain.c:14:
>/usr/src/kernel_benh/include/linux/modules/filemap.ver:7:1: warning: this is the location of the previous definition

mark_page_accessed is exported in both ksyms.c and filemap.c, both XFS
and benh add that export.  Remove one of the
EXPORT_SYMBOL(mark_page_accessed).

>in include/linux/sysctl.h, two resources (?) want a VM_ set to 14:
>
>1 =>        VM_HEAP_STACK_GAP=14,   /* int: page gap between heap and stack */
>2 =>        VM_PAGEBUF=14,          /* struct: Control pagebuf parameters */
>        VM_LAPTOP_MODE=15,
>        VM_BLOCK_DUMP=16,
>
>number 1 is from benh, and number 2 is from XFS. i need both - benh's for some drivers for my hardware, and XFS 
>because most of my FSes are XFS. 

The sysctl numbers have nothing to do with the compile error.  Pick
another number for one of the conflicting sysctls.

