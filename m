Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266851AbUHSRkA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266851AbUHSRkA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 13:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266850AbUHSRkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 13:40:00 -0400
Received: from smtp02.ya.com ([62.151.11.161]:45517 "EHLO smtpauth.ya.com")
	by vger.kernel.org with ESMTP id S266871AbUHSRed (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 13:34:33 -0400
From: David Martinez Moreno <ender@debian.org>
To: linux-kernel@vger.kernel.org, Nathan Scott <nathans@sgi.com>
Subject: Random crashes (was Re: Crashes and lockups in XFS filesystem (2.6.8-rc4).)
Date: Thu, 19 Aug 2004 19:35:09 +0200
User-Agent: KMail/1.6.2
Cc: ender@debian.org
References: <200408181816.57940.ender@debian.org> <20040819084410.GA14750@frodo>
In-Reply-To: <20040819084410.GA14750@frodo>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_NTOJBAO5lReZxqI"
Message-Id: <200408191935.09717.ender@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_NTOJBAO5lReZxqI
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

El Jueves, 19 de Agosto de 2004 10:44, Nathan Scott escribi=F3:
> On Wed, Aug 18, 2004 at 06:16:57PM +0200, David Martinez Moreno wrote:
> > 	Hello, I am getting persistent lockups that could be IMHO XFS-related.=
 I
> > created a fresh XFS filesystem in a SCSI disk, with xfsprogs version
> > 2.6.18.
> >
> > 	Mounted /dev/sda1 under /mnt, after that, I have been copying lots of
> > files from /dev/md0, then run a find blabla -exec rm \{\{ \; over /mnt
> > and then voil=E0! the lockup:
>
> Did /mnt run out of space while doing that?  Or nearly?  There's
> a known issue with that area of the XFS code, in conjunction with
> 4K stacks at the moment - was that enabled in your .config?
>
> Looks like something stamped on parts of the xfs_mount structure
> for the filesystem mounted at /mnt, a stack overrun would explain
> that and your subsequent oopsen.

	Hello, Nathan. I am here at the University now, and yes, the kernel were=20
compiled with 4K stacks. I rebuilt it with 8K and rebooted:

ulises:~# zcat /proc/config.gz |grep STACKS
# CONFIG_4KSTACKS is not set

	I ran a disk test and waited.

	After an hour, the system crashed. I forgot to plug in a console, so reboo=
ted=20
and waited again. And here it is:

=2D-----------[ cut here ]------------
kernel BUG at mm/vmscan.c:565!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c01307f1>]    Not tainted
EFLAGS: 00010046   (2.6.8.1)
EIP is at shrink_cache+0x7c/0x2c7
eax: 00000000   ebx: c0415d24   ecx: c12485f8   edx: c12485f8
esi: 0000001d   edi: c0415d48   ebp: 0000001c   esp: c15bfeb0
ds: 007b   es: 007b   ss: 0068
Process kswapd0 (pid: 10, threadinfo=3Dc15be000 task=3Dc15720b0)
Stack: c15ab080 00000002 c15be000 00000020 c10444f8 c10f8b18 00000000 00000=
001
       00000286 c15c0130 c15bfee4 c012ddd8 00000000 00000286 00000000 00000=
000
       00000000 00000000 c15bfef8 c15bfef8 00000000 00000000 00000000 dff28=
180
Call Trace:
 [<c012ddd8>] drain_cpu_caches+0x40/0x42
 [<c0130085>] shrink_slab+0x7b/0x186
 [<c0130f19>] shrink_zone+0x9e/0xb8
 [<c01312d6>] balance_pgdat+0x1c9/0x22d
 [<c0131401>] kswapd+0xc7/0xd7
 [<c0112dac>] autoremove_wake_function+0x0/0x57
 [<c0112dac>] autoremove_wake_function+0x0/0x57
 [<c013133a>] kswapd+0x0/0xd7
 [<c0101fdd>] kernel_thread_helper+0x5/0xb
Code: 0f 0b 35 02 02 81 3c c0 8b 51 04 8b 01 89 50 04 89 02 c7 41
 <1>Unable to handle kernel NULL pointer dereference at virtual address=20
00000004
 printing eip:
c012e3c7
*pde =3D 00000000
Oops: 0000 [#2]
CPU:    0
EIP:    0060:[<c012e3c7>]    Not tainted
EFLAGS: 00010006   (2.6.8.1)
EIP is at free_block+0x43/0xcb
eax: 00800000   ebx: 00000000   ecx: 00000000   edx: c1000000
esi: c0415d48   edi: 00000000   ebp: c0415d54   esp: c15bfb20
ds: 007b   es: 007b   ss: 0068
Process kswapd0 (pid: 10, threadinfo=3Dc15be000 task=3Dc15720b0)
Stack: c022b4c2 dffe0090 c0415d64 2002002c d242f800 00000286 c1401480 c012e=
499
       c0415d48 c1161948 2002002c c1161948 c1161938 d242f800 00000286 00000=
62a
       c012e7a6 c0415d48 c1161938 c1a4ce80 dcdab000 00000004 c0338237 d242f=
800
Call Trace:
 [<c022b4c2>] memmove+0x4d/0x4f
 [<c012e499>] cache_flusharray+0x4a/0xb6
 [<c012e7a6>] kfree+0x5e/0x62
 [<c0338237>] kfree_skbmem+0x13/0x2c
 [<c03382b8>] __kfree_skb+0x68/0xdd
 [<c03591aa>] tcp_clean_rtx_queue+0x12f/0x3a0
 [<c0359a53>] tcp_ack+0xb4/0x560
 [<c035bc4d>] __tcp_data_snd_check+0xd3/0xe2
 [<c035c454>] tcp_rcv_established+0x419/0x84a
 [<c036470d>] tcp_v4_do_rcv+0x117/0x11c
 [<c0364d51>] tcp_v4_rcv+0x63f/0x884
 [<c025b3a5>] scrup+0xe3/0xf7
 [<c034badf>] ip_local_deliver+0xa3/0x1a2
 [<c034bec4>] ip_rcv+0x2e6/0x3fe
 [<c033d335>] netif_receive_skb+0x14b/0x17e
 [<c033d3dd>] process_backlog+0x75/0xf6
 [<c033d4c8>] net_rx_action+0x6a/0xe2
 [<c0117d52>] __do_softirq+0x7e/0x80
 [<c0117d7a>] do_softirq+0x26/0x28
 [<c0105e79>] do_IRQ+0xc4/0xdf
 [<c0104e82>] do_invalid_op+0x0/0xcb
 [<c0104460>] common_interrupt+0x18/0x20
 [<c0104e82>] do_invalid_op+0x0/0xcb
 [<c0104b61>] die+0x7a/0xcd
 [<c0104f4b>] do_invalid_op+0xc9/0xcb
 [<c01307f1>] shrink_cache+0x7c/0x2c7
 [<c02217da>] vn_purge+0x108/0x116
 [<c010451d>] error_code+0x2d/0x38
 [<c01307f1>] shrink_cache+0x7c/0x2c7
 [<c012ddd8>] drain_cpu_caches+0x40/0x42
 [<c0130085>] shrink_slab+0x7b/0x186
 [<c0130f19>] shrink_zone+0x9e/0xb8
 [<c01312d6>] balance_pgdat+0x1c9/0x22d
 [<c0131401>] kswapd+0xc7/0xd7
 [<c0112dac>] autoremove_wake_function+0x0/0x57
 [<c0112dac>] autoremove_wake_function+0x0/0x57
 [<c013133a>] kswapd+0x0/0xd7
 [<c0101fdd>] kernel_thread_helper+0x5/0xb
Code: 8b 53 04 8b 03 89 50 04 89 02 c7 43 04 00 02 20 00 2b 4b 0c
 <0>Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing

	Last time I seem to remember some function related to ext3, so this is mor=
e a=20
data/stack corruption than others, what do you think?

	I attach current dmesg and config, if it helps.

	Is there anything else I could do? Patches, other trees, special=20
configurations? This machine seems impossible to stabilize.

	The machine is using SiI libata driver, if it could have some problem=20
related...

	Many thanks in advance,


		Ender.
=2D-=20
 Why is a cow? Mu. (Ommmmmmmmmm)

--Boundary-00=_NTOJBAO5lReZxqI
Content-Type: application/x-gzip;
  name="dmesg.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="dmesg.gz"

H4sICJPiJEECA2RtZXNnAMxbe3PbOJL/n5+iq2av1s5JNEFSFKVbp04PO9HGcjySnEmdb0pFkZTF
MyVqSMqPqfnw92uApGTHzyR1t6qEBoFGo9HobnQ3wPf94YBM3aR1GmbhKte1Tu9s0KbRuH9Ge9eG
YdBglYfxiF7x26f/JOMWfeZNyzW2mCYSkygxdX4b9bkNsLZpGWZoCVmn+sqfwiTm87mFtwLTcecH
MdklpuGPYXLCClN/Z3ank6OTe5i4l2AWDsfHE34XEpFf8Un+Ckwnie/F1Dkb9MgLAqxGBph5GN6D
kc17nr+OplFwwTh+p9hbR/72NVx5szgM9rWzNPGBJUnpF4NEo20q5NdhmkXJisynkYr7SPEaRFmB
dafP9BSy84CYRXS5oDC4DCmOVjkqxe8/0mfwWRGnYM3fS9ZcMGt8yZrf6TKLpjMvCy8M9FM9UGxT
J8uiy1UYUDEXMndbq8paxRIL5V3eqwFq9GGM1aybVknU6WQ6HvWmn7+MaG+2ASzhOY3SP1C6jJOZ
F8sXk4J5zP/3X+7Y2u3YUiyJw+tw23f0q0GbDLOZ3VECitMoCPVto/lcY+uRxiOWk2h1qaRimQRh
m+g49nKd6DzjBoj0wWfZnGmqRsr1HmvPPs0hWOPhGfnJah5dblIvZxZGK9QvZVnrbqI4B5Y/k1UY
R1meaZ/CFEV0WS69VcDLjUG9TZ5Q9/PnyXQw7Hw4OkTt5pbSBP+S/NAyGjxElsThYZ7fjY1ay4FG
7VQZ2mAV5ZEXR38yjb2z818M7WzQp4WXLShnuYVS5GkUZm1Ive3SXpIGYUpCtEk4lmuDMXmY7Wv9
MA/9HIwyG5ajO6ZDw49/wjIWeqQXXMgzX86eF6kOYaE8WoZZskn9UOsputogMEYNffnQ+XdyjVuz
Aewg4o58z1+Ej9ImLGE0zYK6NjVr1DBt03VL8gYrLFL96f5OA2RX3Z0amY4p7Gp2w3CZpHdtagjb
FM7VASM37Svyrr0olpj2zKaNiqtylYKwRi3Tdq+IN4f0Ogxq5FrGFQVe7tXINgAcgfc1Qh1zYxku
97XeIvSvmE/RnPJFlG0ZSItkBaaAYZjBb2c0i3KCjLPUULZZY4SIoVgWdV2nz1e61sOyzli2gC8I
Y++O4iRZc2vDEJbeMKibXCbDwdlYGyabVf4Mexpiy1uDqW85JWsgMzAX8xxCcRmuwjTyCTqyyqP5
XQ0Ltkbv2TyczWfzOZVm+9vCLhrMKsBUHmJ5PZpJ6vmhEhZIhvmJNsk6q9GJoH5Z635SoCdmWYMp
ftqlwotjuUBZNb76vUiFy0qFjZGWQAwtJZ8XlbwUb6wjmzTkFVsnKdRFfxQ2DbmV163YkQjmQSqn
ziQabbX10pl98DVE09FtDp4BbNg7woY5ymhPmPtb6Sw6TRYh7AsGSzCvJN3BryYuke6N9umMOb9Z
ctHmceHlNKwP0OcsD9dr7mc0t0Zw7mU5HQMq865DYuMEkQd+KYgBDNiOwdysll52BUrHg2Ffdgpv
/XAt7V/BlG2vShv+vojzv2M1sjzd+AwrRfyTrpXsAQOwQVRc0o7GI7r24k1IsxDmJlTzZFTXWIGE
pbiUmC2oJ9f9GcjTTvdkcPoBO2tdGn7sDpnGMoKa6bamat/jfTIK6uDYPpl1KI5ZF458NuXTlc8W
P03Zagr5NOXTolWSs7VeScuqa7o+GQyPRu2CtEPjFp4WkItDk/+Yh3VRmNl46xCxgYUyYWnTdLPO
M13zd+zCDgh4ihGYs7ziPlBcUbYOwV3YIVj1hm60Wi6b9RJukWDheS9+ACwsSzfspqVgT48m8GTD
S+xiYQoAmLQ8gYmH3Cyj+A7biHbWw16LB3UHn8eQHtgy6WbpwiBl+b2cvYqZaYNNsaeGPTRVRzXl
+3tpfrcOSWjLPMUKXpu6AQNtGKbREK3SKxhvZtkdaFruDGjAz7VMp9z9mWlw7iuxgKKoFjVk4WHx
flbxFzvvhjlbAPKkRtiLqQvPAV7aBSrgdu0ZRhtecTHxNJkxOoZdeGlw40FglY9TggwuV0pfu52R
UbcomdOgf8RzztMkjkEfSyhQtsVcF6oPrOAqWwPXCtxSo9e3YKFu7JA4qMgfKfJpIjeAi/+ejrtT
nYnWp2ejye9v7PPxvPtcx5NodUUXJ6efOmAJ6w5ZMDgNcqgJRw6L/04IGHASNpzw/edRdB9D8Q44
Xo+i9wQVwPDulSj6uyje3cfxShRHP86L4x/nhfE0LyoM9A7aWIY3+vP4xLf43n3LmHEP4UJWKWZU
OqdQvE0282HJ29DWypSswhsK0gh+OZz02Tx7CWixme2aDOmSs/aCsEf0dqvTldYEunEBWa2/l3GN
gMcoAw3YpORmn6sZk3BeQiIuulskrceRtF5CYl70tkjcx5G4LyFpXvQrJNhwHkNSxW5PIIHB2eXJ
91Ey161dnjQfR9J8CUnjB5EI4PnhJTa/QfIdSwwk5j0kpvH46hgvIdkVNlM8jkQ8j8S6T8l3yAmQ
hPd58qScrDbLGXQVWxwiZK5T4SEHeQ19p7X0sn4xK23nINXWNcQlcj/iUGmgonD98Z9WNANJUSEd
mxIf/QLaCW6DcgCLThwFtGm9uMuiysuKAoa7D9FH5A6rc0cTOCNovt96Mhlvs39l6+7Igl1P0XQx
/G5PwC49xPhhEKWhdIa3YRrDP4A9AwOj5ToOl4AKQaV4AFByoEjkMBLzW2LMHT/4fn8vRSiqvC6G
+aanVfV8OHKX/aL+RL2oRmWJd6Ym49C2RqcjOkngIi3uaIgAAs5NBP9rNKIzOJLjHO5hH4suWU5f
0JfDNY1UTMZ/SPAwRvkwdl+KhwF4wSzkPw9aK3hRPawW4M03wAvAW6+HtxnefgM809N4PXyD8Ttv
gGf8zdfDO4zffQM842/dhxfPwDcZv/d6/E3GP3s9vMv4/TfAM/7g9fAtxh++AZ7xz18P3wF+YVTw
4h4/xSPwwC/E6+F7DG++Hr7L8NYb4Jl++/XwfYZvvAGe6XHeZh9E8w38ERobszzh0BwmW+ZNsrYm
k9HY7Yy2yWWhyhLYUmWLy7Yq21xuqHKDy44qO1xuqnKTy64qu5pMWctyS+IvBhOGfCuHk+Nh+dSb
oqQYXsjxRUGAkBSIggQhaRAFEUJSIQoyhKRDFIQISYkoSBGSFrOcuKTFLGgxJS1mMTq8CP0VvyJD
NLyXNtumktYIiqUHIDMbWe6pXNv4w4C+Ho/pJsoXtEooCGebyweh/Vlygy7dTZ4Dz97x8T5i9t9G
x2UAe+yt6OK4c4pwJllVMVSVpb3gTBvailxWBjEogcrs23+BcrqYfBwNAddoUG9fG4Won4BW6slM
Sl+FK9dCx9KMk3kuUwK/ebm/CLALMiQnpnTY450QSYenNM+nq2TGyX9DvS299DJaHTp4DX3aWyU3
3h0inUMy9rUTeVrgXa4vwR/lss05c3pt6AI6sefvU59Tev8ExZlWwLFfU6T6wQqVh3TtxgfqLaJ1
Fub6FnDo3UbLzRLCzxogU+isD5sslFEX4IraNtlWa7jt2PlwRt46TGWuVGafnKE89/NLH2Qcpph1
m1yzYRwIp9Ewyhjvb6MimwOfQm8Z9DdySS5FTTmTC08mUsqwVZMHI5xf4gMb49aawzHlg6RDsvd5
bI8k+o4EFFtAcwto3QfkLHsbXq3HGdk9dtZcSNp15HO6/Kf42ZbfaN1iIZKVFwfUhexzwnoVUAKX
N810urm50TP/Lg50P1kerML8JkmvDq455XyrL/JlrO2O2SarlywlUZbfMho9miTpygsSlXabAVSH
V5VmdPIJIqlDm89XER9W0XAT51H9LPZy+XpU57RUsRLbhWjqhuHF64VnahGflXWybLPkVbAsPiUq
on3OeKkcIkvHGRxTPs3I/qM6eFN6G7HWZoe3t9qg99FuP0yEgWSeSBYn92PUnxPEqiF9Jeo7icOi
gRO2UJ1/oxUcYmiOOhq8ieKY054zCHP6R0bgVphqvElgLuB+d1jvDztFjhMU1eWfZk2lQzFQLrcO
WgReG4A1FGZcKFGIb1C4CsX8ERR+ex0ljCLggsY4aTyxTMM2LaDuTDrUH4w/qUXUeCT6eFLvT+rj
Sf9Lvz76PKQP/ZErHNGV0GcD6vUPyibVS6VXvFUe+dHay1nvo4QyWOlggzViITAUrWLOsxXzZo1V
z+EMPusUdh1JmIp0/tiwb5/BxvFxjvsp6qpWG5uxsAxp2jBIxjle223QsLtPNwd8oBN1qcfHOzXq
fRwfWi2nZcFaHDhWjc7Brz3H2dckW/kh+GHSP/hPgx8OP5r8cOm9YoWasO1+pXszrrGJuqoGk7gt
a79Sk94O7K5iWPrL8fv/YRIg87PIQDDWCbw1bDx1Br1m6+tXRlv/SjI597EL+RgNvhyNajwP2FhL
hzdRBrL/KLtaLYhUn85jxIYoqc6ebEzfV+Be5DdbHFxWcL+xnvcW3oqPUSGPst8gOIQ2SPtkEWyD
4wwXf9bkqeS41800bU9S3u60nX0w1cTOaBjD7kFGOSfB52y69oSjqmFwRv3xZDT8qz/5a3D+16+d
cQ2mG1EsZAFmjg8f+ZrL18lneXNnCB2OeeVPOuNz4J42relvJwjeMX0onm3BMSxCfHiVMnKtd3z2
Bx6/6dM5xYzktNJKDgxLq2bQ5pM67/ISdvDXTbjZOaVD4NyHg7NgJZDw4l9orbqvXas4mnm5V10c
ETqiaLVZ6lqGlmkWxVWroTfsn5NWAmbYyTHbN7YqrKIH7OX4SwRtt0eG2xCGi9c83r52aLYMll5V
AXBpnSQ28yVsvfvYet9gc3ewgTb4CAgi/PklYvm2CfMN76Zt2c6MXKvdDBB1uHYbNs8it8H1LXKd
tuVzfbOod+FbN+f38IHE2g6NFkyfadm2LRzbLQ0nvJWZZz+gozhPK7bjcoZS7kzIXblUBSt+KvHm
dxJvvoZ4a5f4rcLzUqpfofDYFAWfGTqdMlEnFR7+UuMnKHzj/3NoWaNcUsp49xO25TiOaJmsp3W+
2YFd7ybdbqxNq9Fo8sb6bV+5qZW3KG7SCH1nnn+lqVY84HrlOTcHxPxn1/uK69kDkFavBodKGREU
o4Cv38Qb6P6DsbD9bhf/CTqZbZb9CKGzZwmdMaGzJwidlYSaDwk1HifU/xFC/WcJ9ZlQ/wlC/ZJQ
60lCf8pxULjwo+nCD+71LO+k9JJ0rUP5XUP0u7THfvE+nY+7Jh19xLC9ylNXJ3Fj5ZpKn3jl3xUR
ezIvGbI7BAePjv3U8PLaIGa+9iMOKymEkZU3YJ+A53NB0CXDju1xYY288uojNxTHDcWRurogxVfv
pDfKZGIr5uCPHf/qUg9fFnyE/KcIYSL4hkKxy9cUo7Av8umq8hj5YkJ96N3VhaEtNjMSdXTmwI37
csU82ayC+02OCntBiQrXNYaFQ8pbqxfTR768sV0NdWYrw/9izGtTN3/OaejmkXkbL8kLnTMXfhFv
FhOjEJMnRpVbLiwMAhK++CpbAxdi8gT8W8TElCtgPr04VZP5cHF+yonxY1MQr2S0+WZGi2cYLQpG
tx4w2niC0eJtjLYkN62nGW19L6Nfd6r+2BTMVzLaejOjzWcYbRaMdh8w2n6C0ebbGG1LbtpPM9p+
ktH3bhZzxyEGoDG2P++yNDJ84vryxY56pjpp32ApTO5OV11bgntY4PGBScuEc40FQ/nmNCIKmXmM
Y2IwLQvTKAEHXcM2qXP+Vc5BZSYco4aHrbhr3of81O0/BalFq/WGU5gTdQGLlzfgxQaDrsK7WeKl
8jZnlHmG4RgHEq+hRaZPB+y7Fme5xey1ZQC+eFFg0Bpmm/N9UX63yykPS8WGhwERexRMM/QWgl0O
YqfD/rR/9GV8aDZg9PAy7k45v4OKptYJrr2VDywqEzzmVaXO7kXVIhP9ZRus6TbtDVHEbsTnIcJu
W6Jt23KLovNJb1//OZc03qYkwFooCQ8Zu7fGdBl6GaYw9fxWcypvKIJDqi5AkGKbDc5E+1nVo63u
Mcpzg4RsV347cjLulIPxPfw2/O9fqr2r0PE6q7iShcBRn63UlDQ0X7z9aGqDs3Z5+ejbC+6Yqrps
vfGvQs5hW+YnefFam/TQ72MFme3GPHthxpVRxh6iZTYdl2YRllbect/XPoyOZE6VBmfXNuUbdhRl
TlzJ3IsXNl+GMDCra+eHBmlqMnV51O+jyo+k3PPBhKOcoX9uVnWzUSO7TK0XNon1oLPJE2WGeMBR
Z9AnL029u0yXzfzRRApvmI0Pv/P3EFEQymMBdq6rBv6g5ZnK2bbST0Op58vAkO/M7X8wxPvdV794
xeAroGiTqqsAIVdFppZj3mkZK0AY+euaLLxcyrucPE9PHaW4oiU0aR/4wCGRsssxAIcIRTWx4Vt7
1ez2hGiawhVNZ1/l0x9Ubvsdnfa3L4eH7+n8dPDr+VFZpz5OyR4dfvbE8LO3DP/reeekfD0enHZO
Hg6pzgCVeWTrN5VOOZ8XIfqyHKth0ow1OtsCsZLU37OCTbM1xIo/tXgOfjWb8pDyVvO2thPzBWu5
UMUnIuqjFqBV8sAnlKWY9T+fHuna0deJVZ9n/CHT8Wfe6/xE3g3i7HaUqhv+ECJMCcI/j6DQ8lBk
p6MKBD0V7csjhVlYfR8QbCSHS7S6dvU/ySaVx0Py9BONOsEzWS6j4qTvGjFAg+PRZBVk21EqwnjZ
YijRDgVL/kqEUyoVeWoJ5YchTATn9eQXKNqX43GbhgU8f4wEm3SbWztd96vp6tpxGobq6wD5rVXx
EU11NsjfyswBAudN6Z7darVMFyHvjbdmxvHOecC5eszxDPspOHXXrgsK+buIPGsLOQc6HjMwZ/dr
igfgDxV8+h6GbRGKRxB+D9t+iAjnX4EI9ycRwcf0Elx+YbKFZws7LsiSZ/mVwLJvV8GxOTBoL/jf
gYbNgCxNLte8FBJ1pJZkgLp/+QrgqgxUQ4OmEaB7fbkA420Qk/07AAA=

--Boundary-00=_NTOJBAO5lReZxqI
Content-Type: application/x-gzip;
  name="config.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="config.gz"

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
nOUWPC6Vyln8VuE/kjqMX71kAAA=

--Boundary-00=_NTOJBAO5lReZxqI--
