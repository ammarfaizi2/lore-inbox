Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262013AbTFZQLC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 12:11:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262018AbTFZQLB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 12:11:01 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:4612 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S262013AbTFZQKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 12:10:50 -0400
Date: Fri, 27 Jun 2003 01:26:12 +0900 (JST)
Message-Id: <20030627.012612.71439745.yoshfuji@wide.ad.jp>
To: inoueh@uranus.dti.ne.jp
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: Re: [PATCH] Repeatable kernel crash in tty_io.c (2.5.73 & 2.4.21)
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@wide.ad.jp>
In-Reply-To: <20030627001520.5237.INOUEH@uranus.dti.ne.jp>
References: <20030627001520.5237.INOUEH@uranus.dti.ne.jp>
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030627001520.5237.INOUEH@uranus.dti.ne.jp> (at Fri, 27 Jun 2003 01:17:37 +0900), Hiroshi Inoue <inoueh@uranus.dti.ne.jp> says:

>  		o_tty->driver->refcount--;
> -		file_list_lock();
> -		list_del(&o_tty->tty_files);
> -		file_list_unlock();
> +		if (o_tty->tty_files.next != &o_tty->tty_files) {
> +			file_list_lock();
> +			list_del(&o_tty->tty_files);
> +			file_list_unlock();
> +		}
>  		free_tty_struct(o_tty);

I'm not familiar with this area, however,
we should test o_tty->tty_files.next != &o_tty->tty_files 
under the lock, shouldn't we?

file_list_lock(o_tty)
if (o_tty->tty_files.next != &o_tty->tty_files)
    list_del(&o_tty->tty_files);
file_list_unlock(o_tty);

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
