Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964982AbWEVBzX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964982AbWEVBzX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 21:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964984AbWEVBzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 21:55:23 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:40134 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964982AbWEVBzW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 21:55:22 -0400
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1-RC1
From: Keith Owens <kaos@ocs.com.au>
To: Willy Tarreau <willy@w.ods.org>
cc: George Nychis <gnychis@cmu.edu>, linux-kernel@vger.kernel.org
Subject: Re: cannot load *any* modules with 2.4 kernel 
In-reply-to: Your message of "Sun, 21 May 2006 10:40:55 +0200."
             <20060521084055.GA14593@w.ods.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 22 May 2006 11:53:29 +1000
Message-ID: <6366.1148262809@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau (on Sun, 21 May 2006 10:40:55 +0200) wrote:
>On Sun, May 21, 2006 at 03:00:39AM -0400, George Nychis wrote:
>> Grepping 2 or 3:
>> [root@emu-5 net]# grep enable_irq /proc/ksyms
>> c010a5e0 enable_irq_R__ver_enable_irq
>> c0343610 matroxfb_enable_irq_R__ver_matroxfb_enable_irq
>> [root@emu-5 net]# grep printk /proc/ksyms
>> c011aee0 printk_R__ver_printk
>> [root@emu-5 net]# grep kmalloc /proc/ksyms
>> c0132c60 kmalloc_R__ver_kmalloc
>> c03c07e0 sock_kmalloc_R__ver_sock_kmalloc
>                        ^^^^^^^^^^^^^^^^^^^
>
>There should be and 'R' followed by 8 hex digits here. I remember I
>already came across this once, but unfortunately I don't remember how
>nor how I fixed it.

Broken kernel build system in 2.4.  It does not always build the module
version data correctly.  Save your 2.4 .config, make mrproper
(critical), restore your .config then
  make oldconfig
  make dep
  make bzImage modules
  make modules_install
  install

