Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932392AbVHIAxB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbVHIAxB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 20:53:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbVHIAxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 20:53:00 -0400
Received: from NS6.Sony.CO.JP ([137.153.0.32]:30111 "EHLO ns6.sony.co.jp")
	by vger.kernel.org with ESMTP id S932392AbVHIAxA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 20:53:00 -0400
Date: Tue, 09 Aug 2005 09:48:14 +0900 (JST)
Message-Id: <20050809.094814.48829802.kaminaga@sm.sony.co.jp>
To: linux-os@analogic.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [HELP] How to get address of module
From: Hiroki Kaminaga <kaminaga@sm.sony.co.jp>
In-Reply-To: <Pine.LNX.4.61.0508080931130.18723@chaos.analogic.com>
References: <20050808.204022.30161255.kaminaga@sm.sony.co.jp>
	<Pine.LNX.4.61.0508080931130.18723@chaos.analogic.com>
X-Mailer: Mew version 4.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Subject: Re: [HELP] How to get address of module
Date: Mon, 8 Aug 2005 09:51:25 -0400

> What do you want the address of in your driver? Do you want the
> address of its various entry points (hint, the stuff you put
> into the "struct file_operations"), or its startup code, module_init(),
> exit code, module_exit(), etc.
> 
> These are can all be obtained using conventional 'C' syntax. You
> don't need to search some list somehere. You driver isn't just
> put somewhere en-masse. The code is in the .text segment, relocated
> to exist in allocated memory. The data sections are also relocated
> to different sections of allocated memory.
> 
> You get the address of a function by referencing its name:
> 
> static int ioctl(struct inode *inp, struct file *fp, size_t cmd, unsigned long
> arg)
> {
>      unsigned long val;
>      switch(cmd)
>     {
>      case GET_ADDRESS_OF_IOCTL:
>          val = (unsigned long) ioctl;
>          if(put_user(val, (unsigned long *)arg))
>              return -EFAULT
>          break;
>      case ETC:
>     }
> 
> Your driver probably has many functions, therefore it has many
> addresses. It's not just a single "module" somewhere.

Thank you.

What I wanted is: given the segfault address, I would like to 

1) get which module it is in
2) in that module, within which function it segfaulted

module_address_lookup() would do!

HK.
--
