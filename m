Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbUDHArZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 20:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbUDHArT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 20:47:19 -0400
Received: from mail2.soliscom.uu.nl ([131.211.4.74]:53783 "EHLO
	solis202.soliscom.uu.nl") by vger.kernel.org with ESMTP
	id S261313AbUDHArG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 20:47:06 -0400
Subject: [PATCH/2.6.5] fix for potential integer overflow in zoran driver
	(was: [CHECKER] 21 probable missing bounds checks)
From: "Ronald S. Bultje" <R.S.Bultje@students.uu.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       Laurent Pinchart <laurent.pinchart@skynet.be>,
       Ken Ashcraft <kash@stanford.edu>
In-Reply-To: <5.2.1.1.2.20040405173352.01be94b8@kash.pobox.stanford.edu>
References: <5.2.1.1.2.20040405173352.01be94b8@kash.pobox.stanford.edu>
Content-Type: multipart/mixed; boundary="=-nQbNfZp7ZDZSElgWWmNe"
Message-Id: <1081363673.25529.29.camel@shrek.bitfreak.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 07 Apr 2004 20:47:54 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-nQbNfZp7ZDZSElgWWmNe
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Andrew,

Attached patch fixes a potential integer overflow in zoran_procs.c (part
of the zr36067 driver). Bug was detected by Ken Ashcraft (see below),
you've probably received more of those.

Thanks to Ken for detecting.

Ronald

On Tue, 2004-04-06 at 02:45, Ken Ashcraft wrote:
> ---------------------------------------------------------
> [BUG]  vmalloc(count + 1) can overflow
> /home/kash/interface/linux-2.6.3/drivers/acpi/battery.c:591:acpi_battery_write_alarm: 
> NOTE:BOUND: Checking arg count [EXAMPLE=proc_dir_entry.write_proc-2]
> /home/kash/interface/linux-2.6.3/drivers/media/video/zoran_procfs.c:217:zoran_write_proc: 
> ERROR:BOUND: Not checking arg count [COUNTER=proc_dir_entry.write_proc-2] 
> [fit=2] [fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=13] [counter=1] [z = 
> -0.367883603690978] [fn-z = -4.35889894354067]
>                          KERN_ERR
>                          "%s: write_proc: can not allocate memory\n",
>                          ZR_DEVNAME(zr));
>                  return -ENOMEM;
>          }
> 
> Error --->
>          if (copy_from_user(string, buffer, count)) {
>                  vfree (string);
>                  return -EFAULT;
>          }
> ---------------------------------------------------------

--=-nQbNfZp7ZDZSElgWWmNe
Content-Disposition: attachment; filename=zoran-intbounds.patch
Content-Transfer-Encoding: base64
Content-Type: text/plain; name=zoran-intbounds.patch; charset=UTF-8

LS0tIGxpbnV4LTIuNi41L2RyaXZlcnMvbWVkaWEvdmlkZW8vem9yYW5fcHJvY2ZzLmMtb2xkCTIw
MDQtMDQtMDcgMjA6NDE6NTkuMDAwMDAwMDAwICswMjAwDQorKysgbGludXgtMi42LjUvZHJpdmVy
cy9tZWRpYS92aWRlby96b3Jhbl9wcm9jZnMuYwkyMDA0LTA0LTA3IDIwOjQyOjA4LjAwMDAwMDAw
MCArMDIwMA0KQEAgLTIwNCw2ICsyMDQsMTAgQEANCiAJY2hhciAqbGluZSwgKmxkZWxpbSwgKnZh
cm5hbWUsICpzdmFyLCAqdGRlbGltOw0KIAlzdHJ1Y3Qgem9yYW4gKnpyOw0KIA0KKwkvKiBSYW5k
b20gbWF4aW11bSAqLw0KKwlpZiAoY291bnQgPiAyNTYpDQorCQlyZXR1cm4gLUVJTlZBTDsNCisN
CiAJenIgPSAoc3RydWN0IHpvcmFuICopIGRhdGE7DQogDQogCXN0cmluZyA9IHNwID0gdm1hbGxv
Yyhjb3VudCArIDEpOw0K

--=-nQbNfZp7ZDZSElgWWmNe--
