Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262546AbTLJAg3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 19:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262580AbTLJAg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 19:36:29 -0500
Received: from mail.gmx.de ([213.165.64.20]:24009 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262546AbTLJAg0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 19:36:26 -0500
Date: Wed, 10 Dec 2003 01:36:25 +0100 (MET)
From: "Svetoslav Slavtchev" <svetljo@gmx.de>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="========GMXBoundary318941071016585"
Subject: Re: Badness in kobject_get at lib/kobject.c:439
X-Priority: 3 (Normal)
X-Authenticated: #20183004
Message-ID: <31894.1071016585@www6.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME encapsulated multipart message -
please use a MIME-compliant e-mail program to open it.

Dies ist eine mehrteilige Nachricht im MIME-Format -
bitte verwenden Sie zum Lesen ein MIME-konformes Mailprogramm.

--========GMXBoundary318941071016585
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

> On Wed, Dec 10, 2003 at 12:02:56AM +0100, Svetoslav Slavtchev wrote:
> > Call Trace:
> >  [<c019a1f4>] kobject_get+0x30/0x3d
> >  [<c01dd8d3>] class_get+0x1a/0x2c
> >  [<c01ddb67>] class_device_add+0x41/0x110
> >  [<c01cc4ec>] misc_add_class_device+0x63/0xc6
> >  [<c01cc6d8>] misc_register+0xeb/0x120
> >  [<c0361fd8>] apm_init+0x2ec/0x324
> 
> Hm, here's the problem.  Can you disable APM and see if the oops goes
> away?  I bet apm_init() is being called before misc_init() is.
> 
> If you don't want to disable APM (and you should not have to) can you
> apply the patch below to misc.c and let me know if it fixes your problem
> or not?
> 
> thanks,
> 
> greg k-h
> 
> --- a/drivers/char/misc.c	Mon Oct  6 10:47:30 2003
> +++ b/drivers/char/misc.c	Tue Dec  9 15:28:10 2003
> @@ -407,4 +407,4 @@
>  	}
>  	return 0;
>  }
> -module_init(misc_init);
> +subsys_initcall(misc_init);
> 

that brought me probably to the real problem

which seems to come from ruby ( http://linuxconsole.sf.net )

the attached oops couldn't happen in vanilla kernel ?
or should i try without the ruby patches ?

best,

svetljo

-- 
+++ GMX - die erste Adresse für Mail, Message, More +++
Neu: Preissenkung für MMS und FreeMMS! http://www.gmx.net

--========GMXBoundary318941071016585
Content-Type: text/plain; name="oopses-misc-sysfs2.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="oopses-misc-sysfs2.txt"

a3N5bW9vcHMgMi40Ljkgb24gaTY4NiAyLjYuMC1ydWJ5X3QxMV81dmNzLiAgT3B0aW9ucyB1c2Vk
CiAgICAgLXYgcnBtL0JVSUxEL2tlcm5lbC1ydWJ5L3RtcC92bWxpbnV4IChzcGVjaWZpZWQpCiAg
ICAgLUsgKHNwZWNpZmllZCkKICAgICAtbCAvcHJvYy9tb2R1bGVzIChkZWZhdWx0KQogICAgIC1v
IC9saWIvbW9kdWxlcy8yLjYuMC10MTFyNW1pc2MvIChzcGVjaWZpZWQpCiAgICAgLW0gL2Jvb3Qv
U3lzdGVtLm1hcC0yLjYuMC10MTFyNW1pc2MgKHNwZWNpZmllZCkKCk5vIG1vZHVsZXMgaW4ga3N5
bXMsIHNraXBwaW5nIG9iamVjdHMKTm8ga3N5bXMsIHNraXBwaW5nIGxzbW9kClVuYWJsZSB0byBo
YW5kbGUga2VybmVsIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSBhdCB2aXJ0dWFsIGFkZHJlc3Mg
MDAwMDAwMDAKYzAzNmMzMTUKKnBkZSA9IDAwMDAwMDAwCk9vcHM6IDAwMDAgWyMxXQpDUFU6ICAg
IDAKRUlQOiAgICAwMDYwOls8YzAzNmMzMTU+XSAgICBOb3QgdGFpbnRlZCBWTEkKVXNpbmcgZGVm
YXVsdHMgZnJvbSBrc3ltb29wcyAtdCBlbGYzMi1pMzg2IC1hIGkzODYKRUZMQUdTOiAwMDAxMDI4
MgplYXg6IDAwMDAwMDAwICAgZWJ4OiBjMDNjMjRjNCAgIGVjeDogMDAwMDAwMDEgICBlZHg6IGMw
M2MzYjEwCmVzaTogMDAwMDAxNjIgICBlZGk6IGY3ZmQ4NjhjICAgZWJwOiBjMWEzN2Y5NCAgIGVz
cDogYzFhMzdmOGMKZHM6IDAwN2IgICBlczogMDA3YiAgIHNzOiAwMDY4ClN0YWNrOiBjMDM5MjVj
YyBjMDMxMjllNCBjMWEzN2ZhNCBjMDM2YzRiOCBjMDJiMjA1MiBjMDNiOGM0YyBjMWEzN2ZjYyBj
MDM2YmRmZQogICAgICAgYzAyYjIwNTIgMDA0MDAwMDAgMDAwMDAwMDAgMDA0MDAwMDAgMDAwMDIx
ODAgYzAyYWJhMTEgMDAwMDAwMDEgMDAwMDAwMDAKICAgICAgIGMxYTM3ZmRjIGMwMzVhNmNlIGMx
YTM2MDAwIDAwMDAwMDAwIGMxYTM3ZmVjIGMwMTA1MGI0IGMwMTA1MDgyIDAwMDAwMDAwCkNhbGwg
VHJhY2U6CiBbPGMwMzZjNGI4Pl0gdnR5X2luaXQrMHhkZS8weGYxCiBbPGMwMzZiZGZlPl0gdHR5
X2luaXQrMHgyMWMvMHgyMjUKIFs8YzAzNWE2Y2U+XSBkb19pbml0Y2FsbHMrMHgzNS8weDg3CiBb
PGMwMTA1MGI0Pl0gaW5pdCsweDMyLzB4MTBlCiBbPGMwMTA1MDgyPl0gaW5pdCsweDAvMHgxMGUK
IFs8YzAxMDkyMDE+XSBrZXJuZWxfdGhyZWFkX2hlbHBlcisweDUvMHhiCkNvZGU6IGZmIGM5IDMx
IGMwIGMzIDU1IDg5IGU1IDU2IDMxIGY2IDUzIDhiIDFkIDI0IDQxIDMxIGMwIDNiIGIzIGMwIDEw
IDAwIDAwIDczCgoKPj5FSVA7IGMwMzZjMzE1IDxjb25zb2xlX21hcF9pbml0KzI2LzQyPiAgIDw9
PT09PQoKPj5lYng7IGMwM2MyNGM0IDx2Z2FfdnQrMTEwNC8xMTIwPgo+PmVkeDsgYzAzYzNiMTAg
PHF1ZXVlX2hhbmRsZXJfbG9jays2YjAvODAwPgo+PmVkaTsgZjdmZDg2OGMgPF9fY3JjX2NsaXBf
dGJsX2hvb2srODE2YTIvMTEwNjlhPgo+PmVicDsgYzFhMzdmOTQgPF9fY3JjX3VucmVnaXN0ZXJf
Y2hyZGV2KzEwYWIwMy8yYWE4Yzc+Cj4+ZXNwOyBjMWEzN2Y4YyA8X19jcmNfdW5yZWdpc3Rlcl9j
aHJkZXYrMTBhYWZiLzJhYThjNz4KClRyYWNlOyBjMDM2YzRiOCA8dnR5X2luaXQrZGUvZjE+ClRy
YWNlOyBjMDM2YmRmZSA8dHR5X2luaXQrMjFjLzIyNT4KVHJhY2U7IGMwMzVhNmNlIDxkb19pbml0
Y2FsbHMrMzUvODc+ClRyYWNlOyBjMDEwNTBiNCA8aW5pdCszMi8xMGU+ClRyYWNlOyBjMDEwNTA4
MiA8aW5pdCswLzEwZT4KVHJhY2U7IGMwMTA5MjAxIDxrZXJuZWxfdGhyZWFkX2hlbHBlcis1L2I+
CgpDb2RlOyAgYzAzNmMzMTUgPGNvbnNvbGVfbWFwX2luaXQrMjYvNDI+CjAwMDAwMDAwIDxfRUlQ
PjoKQ29kZTsgIGMwMzZjMzE1IDxjb25zb2xlX21hcF9pbml0KzI2LzQyPiAgIDw9PT09PQogICAw
OiAgIGZmIGM5ICAgICAgICAgICAgICAgICAgICAgZGVjICAgICVlY3ggICA8PT09PT0KQ29kZTsg
IGMwMzZjMzE3IDxjb25zb2xlX21hcF9pbml0KzI4LzQyPgogICAyOiAgIDMxIGMwICAgICAgICAg
ICAgICAgICAgICAgeG9yICAgICVlYXgsJWVheApDb2RlOyAgYzAzNmMzMTkgPGNvbnNvbGVfbWFw
X2luaXQrMmEvNDI+CiAgIDQ6ICAgYzMgICAgICAgICAgICAgICAgICAgICAgICByZXQgICAgCkNv
ZGU7ICBjMDM2YzMxYSA8Y29uc29sZV9tYXBfaW5pdCsyYi80Mj4KICAgNTogICA1NSAgICAgICAg
ICAgICAgICAgICAgICAgIHB1c2ggICAlZWJwCkNvZGU7ICBjMDM2YzMxYiA8Y29uc29sZV9tYXBf
aW5pdCsyYy80Mj4KICAgNjogICA4OSBlNSAgICAgICAgICAgICAgICAgICAgIG1vdiAgICAlZXNw
LCVlYnAKQ29kZTsgIGMwMzZjMzFkIDxjb25zb2xlX21hcF9pbml0KzJlLzQyPgogICA4OiAgIDU2
ICAgICAgICAgICAgICAgICAgICAgICAgcHVzaCAgICVlc2kKQ29kZTsgIGMwMzZjMzFlIDxjb25z
b2xlX21hcF9pbml0KzJmLzQyPgogICA5OiAgIDMxIGY2ICAgICAgICAgICAgICAgICAgICAgeG9y
ICAgICVlc2ksJWVzaQpDb2RlOyAgYzAzNmMzMjAgPGNvbnNvbGVfbWFwX2luaXQrMzEvNDI+CiAg
IGI6ICAgNTMgICAgICAgICAgICAgICAgICAgICAgICBwdXNoICAgJWVieApDb2RlOyAgYzAzNmMz
MjEgPGNvbnNvbGVfbWFwX2luaXQrMzIvNDI+CiAgIGM6ICAgOGIgMWQgMjQgNDEgMzEgYzAgICAg
ICAgICBtb3YgICAgMHhjMDMxNDEyNCwlZWJ4CkNvZGU7ICBjMDM2YzMyNyA8Y29uc29sZV9tYXBf
aW5pdCszOC80Mj4KICAxMjogICAzYiBiMyBjMCAxMCAwMCAwMCAgICAgICAgIGNtcCAgICAweDEw
YzAoJWVieCksJWVzaQpDb2RlOyAgYzAzNmMzMmQgPGNvbnNvbGVfbWFwX2luaXQrM2UvNDI+CiAg
MTg6ICAgNzMgMDAgICAgICAgICAgICAgICAgICAgICBqYWUgICAgMWEgPF9FSVArMHgxYT4KCiA8
MD5LZXJuZWwgcGFuaWM6IEF0dGVtcHRlZCB0byBraWxsIGluaXQhCg==

--========GMXBoundary318941071016585--

