Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964808AbWBUW3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964808AbWBUW3I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 17:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964865AbWBUW3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 17:29:08 -0500
Received: from lugor.de ([212.112.242.222]:3536 "EHLO solar.mylinuxtime.de")
	by vger.kernel.org with ESMTP id S964808AbWBUW3H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 17:29:07 -0500
From: "Hesse, Christian" <mail@earthworm.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: hald in status D with 2.6.16-rc4
Date: Tue, 21 Feb 2006 23:22:43 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <200602202034.29413.mail@earthworm.de> <20060220211909.7964d56e.akpm@osdl.org>
In-Reply-To: <20060220211909.7964d56e.akpm@osdl.org>
X-Face: 1\p'dhO'VZk,x0lx6U}!Y*9UjU4n2@4c<"a*K%3Eiu'VwM|-OYs;S-PH>4EdJMfGyycC)=?utf-8?q?k=0A=09=3Anv*xqk4C?=@1b8tdr||mALWpN[2|~h#Iv;)M"O$$#P9Kg+S8+O#%EJx0TBH7b&Q<m)=?utf-8?q?n=23Q=2Eo=0A=09kE=7E=26T=5D0cQX6=5D?=<q!HEE,F}O'Jd#lx/+){Gr@W~J`h7sTS(M+oe5<=?utf-8?q?3O7GY9y=5Fi!qG=26Vv=5CD8/=0A=09=254?=@&~$Z@UwV'NQ$Ph&3fZc(qbDO?{LN'nk>+kRh4`C3[KN`-1uT-TD_m
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3009032.rLefmPqJkW";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602212322.48645.mail@earthworm.de>
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-2.0 (solar.mylinuxtime.de [10.5.1.1]); Tue, 21 Feb 2006 23:28:58 +0100 (CET)
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3009032.rLefmPqJkW
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 21 February 2006 06:19, Andrew Morton wrote:
> "Hesse, Christian" <mail@earthworm.de> wrote:
> > Hello everybody,
> >
> > since using kernel version 2.6.16-rc4 the hal daemon is in status D aft=
er
> > resume. I use suspend2 2.2.0.1 for 2.6.16-rc3. Any hints what could be
> > the problem? It worked perfectly with 2.6.15.x and suspend2 2.2.
>
> a) Look in the logs for any oopses, other nasties

Nothing.

> b) Do `echo t > /proc/sysrq-trigger', `dmesg -s 1000000 > foo' then find
>    the trace for `hald' in `foo', send it to this list.

Ok, here it is:

hald          D E0B50480     0  7791      1  7797   10654  7609 (NOTLB)
cc6cbccc e0b50480 000f4428 e0b50480 000f4428 c6c9605c c14dce00 c14dce00
       e0b50480 000f4428 cc3df530 dff6e5c0 cc3df530 00000296 dff6e5c8 c046f=
202
       00000001 cc3df530 c0115680 d7ea1ce0 dff6e5c8 00000003 00000001 00000=
000
Call Trace:
 [<c046f202>] __down+0x62/0xc0
 [<c0115680>] default_wake_function+0x0/0x20
 [<c046dd3f>] __down_failed+0x7/0xc
 [<c0288bbf>] .text.lock.osl+0x13/0x3c
 [<c0292678>] acpi_ex_system_wait_semaphore+0x34/0x48
 [<c028d5da>] acpi_ev_acquire_global_lock+0x67/0x6c
 [<c0293fdc>] acpi_ex_acquire_global_lock+0x14/0x3b
 [<c028f578>] acpi_ex_read_data_from_field+0x114/0x14b
 [<c029475b>] acpi_ex_resolve_node_to_value+0x123/0x1ac
 [<c028fdc2>] acpi_ex_resolve_to_value+0x5e/0x69
 [<c02923df>] acpi_ex_resolve_operands+0x277/0x4dc
 [<c028a4fd>] acpi_ds_exec_end_op+0xab/0x36e
 [<c0298fe6>] acpi_ps_parse_loop+0x5ba/0x8bc
 [<c0298881>] acpi_ps_parse_aml+0x4e/0x1f9
 [<c02998fb>] acpi_ps_execute_pass+0x72/0x83
 [<c0299824>] acpi_ps_execute_method+0x54/0x7d
 [<c0296c5f>] acpi_ns_execute_control_method+0x5a/0x67
 [<c0296bee>] acpi_ns_evaluate_by_handle+0x73/0x8a
 [<c0296aee>] acpi_ns_evaluate_relative+0xaa/0xc6
 [<c0296375>] acpi_evaluate_object+0x139/0x1fb
 [<c024e2e2>] copy_to_user+0x42/0x60
 [<c02a0107>] acpi_battery_get_status+0x6b/0x11c
 [<c02a056b>] acpi_battery_read_state+0x52/0x185
 [<c01832d8>] seq_read+0xe8/0x2f0
 [<c0162dba>] vfs_read+0xaa/0x1a0
 [<c01631d1>] sys_read+0x51/0x80
 [<c0102b5f>] sysenter_past_esp+0x54/0x75

This is with 2.6.16-rc4-git1 + suspend2 2.2.0.1.
=2D-=20
Christian

--nextPart3009032.rLefmPqJkW
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.20 (GNU/Linux)

iD8DBQBD+5K4lZfG2c8gdSURApQgAJ4oY/dN82ZeT++FW6iSDsVdo9hg5ACfTIT8
5+Ql6NtHQeDk3vhJHkk/QGg=
=haLz
-----END PGP SIGNATURE-----

--nextPart3009032.rLefmPqJkW--
