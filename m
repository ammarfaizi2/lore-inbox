Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265693AbUFOPkL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265693AbUFOPkL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 11:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265696AbUFOPkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 11:40:11 -0400
Received: from web25105.mail.ukl.yahoo.com ([217.12.10.53]:32446 "HELO
	web25105.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S265693AbUFOPjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 11:39:22 -0400
Message-ID: <20040615153920.24928.qmail@web25105.mail.ukl.yahoo.com>
Date: Tue, 15 Jun 2004 16:39:20 +0100 (BST)
From: =?iso-8859-1?q?Shaun=20Colley?= <shaunige@yahoo.co.uk>
Subject: Re: i2c device driver bugs
To: linux-kernel@vger.kernel.org
Cc: Greg KH <greg@kroah.com>
In-Reply-To: <20040614212130.GA3292@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> Please let us know exactly what kernel version you
> see this in.  It
> looks to me that it is fixed in the latest 2.4 and
> 2.6 versions.  If you
> do not think so, please let us know.

I was actually looking at a fairly old version of the
source tree (2.4.19, 2.4.20) -- it appears that a
quick fix fixed this vulnerability in 2.4.21:

http://lxr.linux.no/diff/drivers/i2c/i2c-dev.c?diffval=2.4.21;diffvar=v

If you scroll down a bit, you should see:

---
if (rdwr_arg.nmsgs > 42)
          return -EINVAL;
---

It looks like a quick sanity check was added in the
'I2C_RDWR' option, to fix the issue.

I'm downloading the 2.4.21 patch to check if the
fixing of this was recorded, or whether it was
silently fixed (looks like it was).

Confirmed.  2.4.21 fixed the bug:

---
[shaun@cpc2-mars1-3-0-cust191 shaun]$ grep -n -A 10
"sent at once" * 
patch-2.4.21:162276:+		 * be sent at once */
patch-2.4.21-162277-+		if (rdwr_arg.nmsgs > 42)
patch-2.4.21-162278-+			return -EINVAL;
patch-2.4.21-162279-+		
patch-2.4.21-162280- 		rdwr_pa = (struct i2c_msg *)
patch-2.4.21-162281- 			kmalloc(rdwr_arg.nmsgs *
sizeof(struct i2c_msg), 
patch-2.4.21-162282- 			GFP_KERNEL);
patch-2.4.21-162283-@@ -270,6 +275,11 @@
patch-2.4.21-162284- 			        res = -EFAULT;
patch-2.4.21-162285- 				break;
patch-2.4.21-162286- 			}
[shaun@cpc2-mars1-3-0-cust191 shaun]$ 
---


It's also fixed in all versions of 2.6...

However, the vulnerbility seems to still be present in
2.5 -- latest version.  

So, to sum it up:

- Not present in 2.2, because the driver wasn't
implemented as fully as it is now.
- Present in 2.4 versions 2.4.20 and below.
- Present in 2.5
- Not present in 2.6



As for the second bug, it's fixed in 2.4.9, 2.5, and
2.6.



Thank you for your time.
Shaun.



	
	
		
___________________________________________________________ALL-NEW Yahoo! Messenger - sooooo many all-new ways to express yourself http://uk.messenger.yahoo.com
