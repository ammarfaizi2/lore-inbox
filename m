Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269090AbUJEPgg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269090AbUJEPgg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 11:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269087AbUJEPgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 11:36:35 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:17540 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id S269143AbUJEPfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 11:35:00 -0400
From: Martin Emrich <emme@emmes-world.de>
Reply-To: emme@emmes-world.de
To: linux-kernel@vger.kernel.org
Subject: PROBLEM, PATCH: 2.6.9rc3 build fails with ISDN CAPI
Date: Tue, 5 Oct 2004 17:34:38 +0200
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_O8rYBEPMK56psiP"
Message-Id: <200410051734.38741.emme@emmes-world.de>
X-ID: VshjT8ZcoeUnPosAGOkfx-DI9ly1B7HuFv2Zz8TyaK9xTHNY4ZxBZ3@t-dialin.net
X-TOI-MSGID: 82d528e3-c01f-4cd0-a215-99a5c7cfb7c2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_O8rYBEPMK56psiP
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi!

Building Linux 2.6.9-rc3 fails with this message:

drivers/isdn/capi/capi.c: In Funktion =BBcapi_recv_message=AB:
drivers/isdn/capi/capi.c:649: error: `tty' undeclared (first use in this=20
function)
drivers/isdn/capi/capi.c:649: error: (Each undeclared identifier is reporte=
d=20
only once
drivers/isdn/capi/capi.c:649: error: for each function it appears in.)

* Output from sh scripts/ver_linux :

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux sauron 2.6.7 #1 SMP Tue Sep 28 12:14:36 CEST 2004 i686 GNU/Linux

Gnu C                  3.3.4
Gnu make               3.80
binutils               2.15
util-linux             2.12
mount                  2.12
module-init-tools      3.1-pre5
e2fsprogs              1.35
reiserfsprogs          line
reiser4progs           line
PPP                    2.4.2
isdn4k-utils           3.3
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.1
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1
Modules Loaded         skystar2 stv0299 dvb_core zaptel ip_queue sd_mod=20
scsi_mod cls_fw sch_tbf sch_sfq sch_prio ipt_MARK iptable_mangle ipt_state=
=20
ipt_REJECT ipt_LOG iptable_filter ppp_deflate zlib_deflate zlib_inflate=20
bsd_comp ppp_async lp tun 8250 serial_core tulip crc32 i2c_core uhci_hcd=20
parport_pc parport evdev capi capifs fcpci kernelcapi pppoe pppox ppp_gener=
ic=20
slhc ipt_conntrack ip_nat_irc iptable_nat

* Attached: my .config

* Possible Patch:

=2D-- capi.c.orig 2004-10-05 16:45:40.000000000 +0200
+++ capi.c      2004-10-05 16:45:59.000000000 +0200
@@ -646,7 +646,7 @@
                kfree_skb(skb);
                (void)capiminor_del_ack(mp, datahandle);
                if (mp->tty)
=2D                       tty_wakeup(tty);
+                       tty_wakeup(mp->tty);
                (void)handle_minor_send(mp);

        } else {

* I am no kernel hacker, so I don't know what this could break.
If my ISDN card stops working, I'll get back to you.

Ciao

Martin
PS: Please CC me, I'm not on the list

--Boundary-00=_O8rYBEPMK56psiP
Content-Type: application/x-gzip;
  name="config-2.6.9rc3.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="config-2.6.9rc3.gz"

H4sICAmoYkEAA2NvbmZpZy0yLjYuOXJjMwCMPElz2ziz9/kVrG8OL6lKYlGSHTlVPkAgKGHEBSag
bS4sxWYSvciSPy0zyb9/DS4iQAL0O3hRdwNoNBq9AA39+cefDrqcDy+b8/Zps9v9dr5n++y4OWfP
zsvmZ+Y8Hfbftt+/OM+H/f+cnex5e4YWwXZ/+eX8zI77bOf8kx1P28P+i9P/dPfp/uPxaQAU4pI5
8dPZcW4d9/ZLv/9lOHD6vd7wjz//wHHk00m6Gt09/K4+hOG8/jCnnqvgJiQiCcUp5Sj1QmRAxCFi
AIa+/3Tw4TkDzs+X4/b829ll/wCHh9czMHiqxyYrBi1DEgkUQENoVcBxQFCU4jhkNCDO9uTsD2fn
lJ2rduMknpGo5qD4nMZRysMrB5NcgDvZ7vJajxnEGAULknAaRw//+U8F5suc9+rTmi8owzWAxZyu
0vBxTuZEGZd7KUtiTDhPEcZCnUMTly4GhpnAQFhoc0dzjwoDZRBDn3M/5VPqiwf3toJPY8GC+UTt
gs6Kf9RerkgSjonnEc8wxAwFAV+HXO2rgqXw19jflYCsRIJShjg3dO3PBVnVgiMsDoL6I405nhIv
jeKYtaGIt2EeQV5AI9LGYP9RUyWcxkzQkP5NUj9OUg7/mNZhGpJQbSdotC6gKnWuWMFh87z5ugP1
Pjxf4M/p8vp6OJ5rFQtjbx4QhesCkM6jIEZeCwxs4TYyHvM4IIJIKoaSUGtW6q8yxAygiv6KmKUh
wtNCRDnb7Hh4yk6nw9E5/37NnM3+2fmWyQ2anTRrkOZ6fxWEhJAARcbFl8hFvEYTkljx0TxEj1Ys
n4ehru8aekwnsKXtY1O+5FZsaZhQgqdWGsI/93o9IzocjO7MiKENcduBEBxbcWG4MuPu9A4rMAOT
SechpepK1VBq7qzEh53YoRk7s0xs9tkCH5nhOJnzmJhxSxqBxjJsGapE9zuxA88y7jqhK6tkFhTh
QWruWdEkw1JILA7ZCk8n9faTwBXyPB0SuCmGLUlKE3614MmSkzCVPUATsLOTOKFiGuqNlyxdxsmM
p/FMR9BoEbDG2GPdm+WbOmbIazWexDGMyChu9ilIkM45SXDM1joOoCkDx5bCTPAMtm+NnjIiwHCG
JGnASDgPEJiyRCgDFa66/BAlKWZz/jCq5V6Ycx6ajQNLCAmZyVHmopZO3jSx2ACEjakDQkyaFhBA
4J0iH0GkYtUSScSGYkqS0EIlYlj7MTLi6Ghm2uoUQxARe+ThRWORJzoApEc9AOWm3t8eX/7dHDPH
O25lWFhEZKXr9UyuP4qndNL0gSVoaA4kSuydjq7YRmJaLruMs2rfJRJFOWjyOEbgW7Dix6doQcC9
Y7mGM5WbhEykH2y5Y3b4NztCqLnffM9esv25CjOddwgz+sFBLHyvCoCZ7R8LYdTxfNLqX/YCfT3/
s9k/QTSO80D8AqE5DJJ70YIBuj9nx2+bp+y9w68BQR3VyU7aYpLgdBzH4ho2s7njH7P/XrL902/n
BKnAdv9d7QgIUj8hjy02x5dTPXOGYeIMh5iiDw6BiP2DE2L4Bf+9r509UKkCho9gEMYQSJkFlKPD
sCO2LEg8mhBs2pkFGkWKRZEgOaIOKXpo8hZykwglJiAThNd5uK13FKFQjcNg+mqnUjAWb2GGc/yr
rwcLhQbmgr7Bm+OzXIVTe/kLCiP3EiE5H9eBGqbO9HB+3V2+K6qkh/v52r0YgKmPZtJW1NtUwcmM
yhKLqWR0bN4iWleSy7eI4Mfs6lUiPmW4JVLyK3u6nPMo+9tW/jocIZlUAtUxjfwQPEvgK+lYAUPx
XNSyKYEhBStfmkcv+2f7pBrHOl/cPpVgJ74mq/XyCxR5KIgjUwYBDmkBEVTq0yRcooRAskYDJQLw
l6kM8HPfeO0xtzipl9CFHkDno4bZy+H42xHZ04/9YXf4/rtkHPZ3KDzNpsHntlZuIPvdQdotFaid
pIAtZXGiCKoEyPDfAIMgJ3BVvapQECRQ3du12/rUj5WNWSP4XB4AxNpOL7Gx9KMd3br90fC6Y+RW
yU3xbvPbMNWIaSNEzGLqIUU6H54OO0XPwEQUzevGDXtVAHLjk/q8Ymm8Ozz9dJ6LBVPUNpjB2IvU
97SzghK6MgevMGXqmTeSbInZY+qZDVaFxpTzBk1jaA/h+7ueial5IwduoAOZs780oThZMxGbcdHY
UxWpAvOVOWW48jHuRCfIbLSCcXtrQBR3Az+M3oR+eJMEQVtnQOCKYSnHKIClymWbE+T+GdiRw9NF
Bh55RHCzfc4+nX+dpcVyfmS715vt/tvBgVBBLuGztC2aTVG6Tjnw1DnHqZc2FKHdi0e5FjaVoBRi
MUHl2cEb7bFRMwEB8rLrYEnjBzFj6+4BOOZUXX85c4GAQxpjYQ6bKxKfBgTIWusphfL0Y/sKgGol
b75evn/b/lL3nuylTORMU8Shdzc0nwQo3MN2755eEVTVQxYuTjoEiHZN48a+P45RYorKK5IOruXh
1l3f7d4af7uNMw6D2oSoGQ82sPkxlYnLunWK5iJuKh+g4ihYSyXs5BIRfNdfmc9BrjQBdW9Xg26a
0Ps8fKsfQenKfKykqUN3LyKhfkC6afB61Md3990sY3572+9WPUky6CaZMjF4g2NJcmc+XrmaYez2
O5WFgehMahLx0eehe9vZOfNwvweLnMaB2dW1CCOy7GZ3sZyZDpyveEpDNCFGh0NBpm73yvAA3/fI
GyITSdi/716bBUWgByuLWkrL1EhtNZw82OJEdM2z2GmGvUcXY/uebe7X2tG0bKw022U80/aWpU1X
PjXjobx52a44gH73vD39/OCcN6/ZBwd7H5M4fN8OlLhX94unSQET6nJW0JhzU9J57Sgx6kCSQtTu
xaZI8zrcpEoc+OElUwUBkXj26fsn4N7538vP7Ovh1/vrHF8uu/P2FVKXYB6ddEmVvhgQquxzDPwv
swxhTsFzkiCeTGjUDl5zvsRxsz/l46Pz+bj9ejlnzcE5AzstRMJVeeQYHxcIc9e7w78fi3u85/ap
UiXPwTIFJV9BNEbNGzwfCKjubXshJ5Bn8j5qLKhOgnDDZzbQU+Te9juGyAmG5iPfggDh5iw0NMWf
YQ61dpYA6TggGyC57lBMHvq3gyZJQmA3Az5A6zTkD+4tTFc5KyqpiuSQRGhsvATVyUIIjx4MnSQk
T02FkMcjNOoSaNnCZpqvRPddK+cxkdJ+bJWat0ARX7d1j0Z96z0MmSC5EtIXQCTUTVMcBdmGlxF2
a89JoPQjHbMGAun27BR5H9HiDQKwiSHl5ihaYWU17OIf/FbQEl+J6DAbOcWC2g62agpBODdekUqa
8ZyD/aG4xQBMTKR+gPiUxZ1qBumoj7vsmxeuBu6926GEnsCD/sgUo+RoIhe5yZ8EQg4xmRAvzW/x
7d3npAGNZvI2OQ5DFHkmz1vThmglu4aNfNdGMho3PKM/F3NIB7w4RDRq4CaemDZBZXlFhJPbwajX
jU3DMB9Pn5FGhIeWfVbsQ9axNDSiQk+/WnjkGoPHIiRg7XWhluvIAvk3ZSlhzDXHXzUNKOUyxcLk
xXOiauJ3qCE+vg4BMQKz17di8kDJ88Boc/C7eQr94NpoiY/AuRvVoaa6KszdsLkHrzR5NQ0jHduA
MvOleyFrxLukBsma1d5eCfr9nvmMt6DgtD/sInjMLUUKfvxNGsrNyZjWj/n6XCVxO6zCY4D6hb9u
NkV9t8ujSQJbXnolGHTJMifod4QaQHA3cN8i6OqBEzRBwmq2C7Uaunet6Xt4cH/7y9ZOYnui1UiA
oO28zN1hOhj6HQSBSBAXcYf6RpwNOqZrPr6Nd89lIlGFqM47SSCbfMhJIe3Rzs2xrDmqDqXaB/Ay
hP+o5zzOuzwolIfNwUJNWEKvfV6owkJP+hSCEg0kO+u1IG4b0ia61Wo/CpilcsIrMg6GhLkQ5noI
3L5d9S+yqNCRV+2t5O/a3p/LaqT2sRwhxHEH90Pnnb89Zkv4eW9qLulyslYHEEjaR22EmTkqys7/
Ho4/t/vv7SQ1ItdrVoWsVZTIEJ4R/fIxh4BrRaazP+hWBgtSgLULmUdUKXcDknRG1jWaFrxUn1ix
Phg2hQbNo2UMYUgSz4VaVVG1YIE8GB1rxWaAy8lTfxmiRD8LrlBGdWgSLUgyjjlpdGA+AJUzpIwq
p/0FZJJoRy9XoCzZRJ6csPnQA+aXM2HEooQZ07K1rBmNZ5RoFYxS1pDtmceROGJxPrTgVl6amsQk
sWIeRSSojgco++IstsfzZbNzeHaUt4hatYCmvCxdmP0iZQtTzRcM59NA6PeHV6DFIkqOQNe/bXdn
AzM1K5EvTx4iMMu4qTASJfIKVrOuFHjIbEQMtlkoGlAgfcE03QQQTXATJPx2SyQjb9SEFiW4DSBl
hl0A8BAJPAW7C8lJs0mBghgKRZNWfwUyRNiMYDPIp5m1FWw6Mybfddqlq4oWMTcjEoJJZGlEcGRG
eBy3JFpg0FSqvBkXkGiiZiAafyKwIDALuYX3KQkYScw4LiBkMaNqbTSi42VEtPM8bX4Qq8vlsepr
JVUUhLY+pCa/0V6mhoZlKTdpAypQMgF7kZC/ZGGLGQkxrAUzt6PMso9QaxAAgbkgHvFae6/oKUQc
9laCvNaSXJkv63LMaLBFsv7fjOQoJG1ZS57yUj2rqCUFj0KWjhGnrd0osdKYGMAGeyLBJjsj4WZb
A8BJYBOHYbuWGMOeLDGmTXkVf9tslCgcIEg9/XUTnaClbS1i4+YBx1nayTbCrLeAaElh5SdamaD8
nBeLGs6NYRfpBXPv1Dcf7zUnVHoPJdIXLPXGEL9yc7nZlSAe/4WtZ05AMwVLLss3bYc+FQmfItcU
WFwJQj3qRsJ8eDFOqDcx2Z9FgKJ01Ou7j+pEPVAYYmY/CLA5DaLMnJHKAlXzPeuqb76bCxAzV1bI
AMeTlUlm1gj8tXC9hFkWIau14+ky9YN4CRCRxEFLcx4PXOZYN4ej822zPTr/vWSXrCiFVDrJS4T1
MJtLywzpzF/U9xuBoIqGTSILlWPfQ2srjxWxLMo0h7w5xfhRj3olcCrGBqDPcRvKEvWEsIKCsW0D
uW8YSpDHwAAd+23gxNirx0vb05o8/DXW/lR4Gk3kqZje5aNaHVXE1yBqBOm+DsYBbwHAndHIIyu9
R4nI1Wlogbf78Zdt0vmgr90bFiB5VWM+q6jaAUcWGeQM8AUzsAXQu6ZIJQIZ4+gKy+KAYtLIUp1z
djo3yoBlA4hCbdchgJYvrKzTksi03HuBZZdOUQjBgOW4lya2ijPL9IrLMGXFvXkYrrUr2TjyGvea
laV5nKOA/q16J0i86g9ElgoKxFoqPG7WvRTVXwneZ+d2bR7AZVqudFJAUrffM7mFCtu7dQ2NwDlb
ktccDdHjfe/Xr/8HiWUFqmFomJrPYOte+r1evy0Gcv4hH46enXduzwE7C7IKv27P73UTm8tWO61o
vDqaIsbWIbE8eOBzyK5sJqS4eU8HwKJWlh2Yy5lIYHaFkGEEc3MuDV2Zj8RIYK77GOBbvYSlctyQ
talmCfKLaRwrOli8YmgoYDlBHpqPrhUSiNZQ2wuKy277Cg7wZbv77exLa2CrwSjOIwKqpNse6bu9
ocp2jle4zAHy8ZRhziUupErtbgGLEKMmmPTqkGrTSePVh0eGq9uaiyWN5GZPR0PlNssL792ecgmD
hPu5p+IJw0qAPmVujtWPlripxDU3eGpVHpMbY6COFXoj13Wlsms7uQCTfG4mA+AhJgiWeWzi00QJ
kZuYSmJ113jQt1wZIAgIcGwOrMZD8/O8ojaPWI53MR/d/zIP5k0S090mISyJGwKuYPJG09SkSS5J
m4KrGQaDEZkjWEjHOAlN8o5If6Y/fBi5g3s1o5KfRaxdgJagJtctPHgUkool5baotSIcuf17K4Gs
nkiTssLDlEpQft+QE6PYtd0ezSEpBbtiRArbo9wFRWkiX/5asQsCWTcV9siXxfLEu9NlAMuVu1C0
mkTUbOu8oG9OS0jTR9eM8NFgZCmLhOBEvm424tYkgMzCp2bpJCP3zrx+fHY/CiytwKbF0eANgRgk
QlcTc3LF+4Y6ZnH4me2dRF5L1NFJzUM7wZZXKrvsdHKkLrzbH/Yff2xejpvn7aHhxvNIroor46+n
wy47Z3Xzp83x+VRfcb0es4+QpX5yXW0yXCTUfFSOEpsyLtGi+Xpc57wY56t8mnYj3xRprGjKRRPz
DpbvLYnJikF6TpTUKC9QLkHlc4/t6cWZiBvvkp1BHAUr7zY3X2++v5fPsPInXV+1J11VXwnl4W0j
H1mCpQ9kPlTKebnZO9vqWaC2lEuLtHzPs7yqoszoglig3rkwpn8oTpzl7ZTi/AB8vUhQYIivI6y3
lpBUiLUOlVX+2rmtBI65J+9JNGCs0HCNT/kpf4wms0c1g88RMh3V7t9yqCy7yP8zB3RS/r7pgTaH
AFU/KwZS+E9+u0L7voR7ESz219Pv0zl7UV8BeVGlNfKWWX4e5t++om12gKZ02I7jsHSDlm5TiVSO
3STISxYpWoRjt7qDk4fVXI2ori0h3vK8gMgXZyas/NXvNbq/YnwuH58GtoY+r+acT+AHbIb8VfGz
/nAOPZ3hswMMF5tXu2CXfUlMKwkrGpHt02HveHSBqhszcxcEQqK2ERFgQl5/HPa/TU9uIUCPDCu8
f72crTE0jdj8ekk8P2XHnbzo1/awSglKOQf9JQtFgho8ZRzNV1YsxwkhUbp6gMh32E2zfvh8pzyO
L4j+itdAYrm8lASCN/AaliyKO+tGI7IwXiXmgqM3san8d4JCIi+2TPsvhiDmSqBs9fLhn/oxpaPe
sN8Ewu+yaW0RcgQWoz7+7Fpip5yEoWQ2ttRQFQSYMm6pNMkJGnm8IovWM1JNijOyzp/1KF/RUkLA
CQFP6nSuGAj4bOxeaYLZmyQr8SZJRJZC31Ft9VO/cib/2gfe12pOcmD7/WeDADqMLUfIBYGs3bK8
OC7Hxa7bY8jyzR45yYKvVitk+WKFaq9wQbE5CC13SzzH02K/2QVD1W+LKGAMczbT7uUL+Dz/0/YG
YEg3T/JCvnUEtVA2yEKkpZtSvhxhqcA0RUWBvOAoXignhtcb2XG7USv39aaj/q1aWFoD5RdzzMEd
84dha7wcT1aCRI2vkyoOLyEYlRQAyYc2v0Iuu8L/19i1NDeO4+D7/orUXHb3sDWRbMvyYQ7Uy9ZY
r5bkR/qi8iTetGvTcSqP2u1/vwAp2aQEKLmkYnzgUyAJgiCY67tndJ5ZuE1R32n2wu6OP0OELDZZ
/Yc9u/hcSnd3c+VPiq77SCkoCm42RWeZofYdF2ls+nSkMexMsiAhzsJ2h/f7Hw/nxxu/v8Dt8Dg5
yCnLJ3zvEvLLU03R3JZC+6lCqly3WTVz+lNOFg5tOxAFKJGgjNFzYJ7dFUPPuEjd2oHdz82/n84v
L7/kNZ5uWVVSZjiI9S+PdmUvjZvZ8BOv+NHVRKwewVJ6fmgxh/KpR0zGuulXQgXASZm4UciRbeOA
caZHmHPFl5gM5MPCnI8+YmEUxX5IztuBHiIMfjR1EBnerkiDZTilTGSIlZbtauY2pIgglDZOI4/Y
ZVZcBTKXFCW4YK4HIpgu6WYjxvVmirtLWtzFjgiroJkPsqWMX6TCFQ1Htu0TyqGtexrYfuOvYKqV
GtQlkXh6PL+e3n/8fDPSyahOnuGE1BILP6KIQs901SneTHQRlSy2ZhO6ey+4Qxu9Lzhzs1biaTCf
0VuvFkZTKYvDvnjNOfwiDoofn5iVOAkyMVwQy6RdlDlAB7yNJfEZ3iTxckW6vyFPHO+nhhKNxDKv
xFYsaeFEDgXTM7IKM9MInzYdyeR4d3XBf27AHWYktvDCYe6iAsxNQS1WMIYYCed5kOe8HIFo9z+Z
FOWLjFfH57fz6xtoSacXcgyCzgBLuLGuK0rViCCFnRQtSCYP3XMGz+STfOTp4ihLUFnc1fyOJUIX
BsYPvmVZJjPLrZjlueWJa5eOw9cxJOl8vMnA8GkOjM//hcEd7w5goOVCY/isksw1644hFXvLsRjz
bstTpZU/nafj3wWk3HEdaqnsOHbuZO5aga41X4Bk7s7qipJQAB17vooG8p+jJVnO9j3BH2Qhz2HG
xQEWFXc2ZyYXnWcx3gugXLozRm3EkaiunqLy/gkLLmqfsHjMEa5Wzsq0PqtYToenp8Pb399urH/9
9wTTx18fpm5tDVKkp7d7yrwOe1AY1ENLlbwF8vP4cDoQ+7UYNKRG0wG2p4fj+SY6v9501kGNLB4O
L+89y4nKwavdKT26FF6kdOe0qXfffCb6jWLwP8F3iwUT4qBNX5DByxRYCTGzp/rNOp2+MHw2wrKZ
3E4Mx5iWucYTirFGfs9L9rxL4uXEsWzq+telOnNrMh0Wne7pZbb9tgV9nqXQVbiPN2mTl73rLzTb
MkzjjN7BtP28d8ekIN/CZyRHQYlHPqR8yYOfxgdNnlZzFF5Kd9FPGWhNSnGI73XI7JcUA7S+DsfK
UAwNF1hOMcEMH/NuSR1PCPI0xlFFlhOlY+UojnKsxXVYlgIaPcZSbpgbLi2u3EhGOL7nSV2aN8/V
vHd6PL0fntqZxXs9Hx7uD9JNrIsSd52lgq2nbQ23XmduUZYhtdIcH26i1/Pz+/H54SaVca3NDGCE
bm/txcLYDSK5cN05rUkiLJKigp1o4tHKhcaSjrHgqR38nTu+M6OXLNmsvT21uM0p4MtykwXwv72Y
3U6bKbP4EZyk+xfypfXEsvtdsg0ryyVnog7dLyb9RHWAN6eZ8D3IkO1rh/Jmu34/OcNNnZu/Dm/w
C4cRNSHI/tzOx/rJ2wRLZrq4wg0zTDUOsR2p7aby2PrVNaCfVUMxBeEweKQm0k/H//nnlzi++Ydn
+/Y/9RL1+gLWVOs7dNcZjgtYnEH1HaZUk7Jc1fprn7eJ+qT4kvPy9fDy43RPbuUjKlhPu4DBHtq/
Boo9P+Mh/s3D6e0Fgx4qm9tww7RdCspknAaCMoV2fYK+mVqyNvjNx/ODZrnFc52uSZfouOpFCsl6
I17vf5zej/cYYl5Ll+k6cxa0AaMNUuGnJmG1C8LCJJVil8ZBbBKr8NsmzPx+fkC++Jtq5LyqMESx
dt4ExDTeg5aS617NbZVa4lVL1gtEkNotYE1rv2ujkbY725WGanphRDb6Zl8XrXSgkso2FBuYs6Th
vtfiIpk0SewNqNOWapaMXcbWaxuX+AFYPK0LwQREkR0nDf8by5nNmD3dpSFD81wl6IaLwHItI8hD
S5y6Js2vpvbEImg2QXNMWlgtHLdPshx3SHN78QbwIHRTqes8TDQDxYJvaYQpc11FsYAixMLy4IO1
jRocsK5TU44Sizpe2Huy/zqM6keJTQYtrzyXKajyrF4XV57YhcMMLAcKZCJFAAO2JyrzjDyGRkFI
Kkt3KZW07zV89B7RT2N3MrkdjIf61lrwvY6DqxI218ilSMT+btCoyu8djfytiwFNS7i/mDcYD97v
5ySSeDZltCOJ8zEPr7B0s2GMC8i0cXu22B7Y70mkDTsSOn0y4UJIAI4rLt/PIHMOF4+jHbIu3w0w
41u3ax5f5+XSsrlgHGqBEIzNGOEstRk7uVwL0pCLa6HQxWjahTPjU6+CkbFRYwjhjK/2XRpxG692
6EzZeDFqxIwlD7PKmsz55Aof+WiVtZjw8oKww8PtfpAxPgJDlHLHD3Ku9ENrPiIQErcZa1s71ybu
nm99x8CPuyrPYn8beyETSkcux8Jlw9QgvrfNADJKcUtgKUVVnJxsUMHG96jy/gBGYFPt7btBhvnL
8bnV/6rO2+2aVPoCFXj9c5AQKzHQXoGoa61K4afUITTqHZ+eDs/H88ebzGsQ10Ml3sLXijQPArnR
EFmwizHyVr+su0yksQ9DPstLuuuRLa+HFcIqrM5v76iov7+en55AOSde48Dk4cqPm5VPH1/L/AkG
Dd60cKeMY9Gtb5L/dHh7G3p96N9V74dkE9Z5Xq9Mp0+ETFVbptd1dCRc/S00Ikb56YVf1cjDj0ly
lTtgrOk3JYzcRC0i4ZkftwOjMgzVRSMCjKvAvr2lsQB3IySyKmC9uz3SYBUE5e2Cx2YzGvtzkxbV
6voiiBSkj5+H5+sLI9d3AFZx8E/zs67iwPwCQOi8Gi+dC7QmipjeBFB5NF6Lj4Mb7wycXXx8ygUQ
k3JeZ1KC0E+LRUVccMZBhHeCc1BRxdaCtuFKucx3+CAPE0tGVk06frFwKDU3Ft5znmmyXXXcgCaf
1/SEF/88PDLe/rJige8yi64alH6Zj3XbqoC/ZGgrLJw82DDnP+EhI5c9zKXMsYJMXHn0wSaCsZeO
pV3jeid29B5JTonbGeNtIMdSOGXWc4lmC9+6pddzNRK3jjs0tGFPdDdyD2gMOg8HgC9qvs5r2NMw
N7SknIKcVcwhGOJlnbgWs1dW67GXEXd2sNrS945cBTZVNZc6+4W39RSEZQu43w2TUq+P+36fV8Ey
FmNmrgjT2OG/AaA2rQkjWsdL2uNULWxhWe0EE8VW9mScz0aGVRIu8xonDZ5jZLFOmJCNUjzu5ONg
vAisMG5EDV27pU8vZOPDiv7Ky8PD4/GdcoXHZEvRt6YqTz58XUfdSzAeZq3tRleTWkKzxwDRQ7J6
HlX4yRCqQn9TxvWdgUz6mU/ozCd85hM68z9Nz2r4OVQyWgzSp558kU9PUYYx9H+ErhnkJ/hzAF2z
I2q6l+y6/oMU0lMegW+bvBZmaq2NRh6Xwois8Jxxr/r42rA85areK/UbPpi01aw6iqCZxmSCwcO1
dc53m0KnPVgJqQzZ+HuwDaQ0DoQxrvKF49yqbuy+Qp7E+qX078Cki5T6bSTZBNHgd5ZcLmsFefV7
JOrfYY9M1iLCoEJa8rSCFAZl22fB311AWDTZFKgJTydzCo9z9CasoE2/nd7Orjtb/Mu6PE6c1b22
SIKUay30BdLK3eWBmrfjx8NZvp41aMs1Nr9OWMtjQf0NZFOAQCvkvy+ARV1dRjEhZHVamPmtNjAh
JR6TYYs2hSAj6ZQivT4uYC44ZpOvEhiMSGfEY6tRCEMP0IPKCwdDX5K46cgbsId8yb5sPwlt9yMV
LnjsW7afchMEvodtDp5BZRWl2cFUNdR1O71JrjZVXxwzldkv/fd20vs9NX+rUGT6DSKgBuavfiZB
P5cAw6dptwlyfx30fhpJwj26g+pVrTZZqb8Trn43y0rjAQLM4Uhr1qVnBJDSoKpYp+QL4aln9Dz+
hmmrmzi0oltAbTf++O3+xZ3d/qaJTMx8+Mwv6K8Oc5bofeWWJK+5c3f7xUCK1IR0eH0/yRhg9a8X
c69RiLLGyOLZJeIptabJCffCegmSc5AXCZPD8+PH4fE4fDER5/if2o9Lz1ETLcDdTN3ATG1cG9Wx
+YT2VjCZ5lQoEYPFnd2yZbiMrbfHRLtM9pi+UFvXYa7hm0z0vqrH9JWKM87oPSbarNpj+koXMA5u
PSbaddRgWky+kNOC2aj1cvpCPy2mX6iTyzh7IhNoQijlDW0fN7Kx7K9UG7gofxjkEZUfx+Zo64q3
+nLeAXwfdBy8oHQcn7eeF5GOg/+qHQc/iDoO/lNduuHzxljUVSWDYdbvy3Ueuw0TbK+DyRh2GAOt
jtxrRIQzaE9m9OzrLF3mEQYTGBq71xgE4+nmx+H+P0aMPuW3u8YAUtqWKBUYqx9UCvM9PMVcJYwp
r4WLOMN1+QsskFUY0gdiijHOInqXHYFyFTbyHRPyCdJQlEn7nM6aaAHsjNb5FvaQSU6HAFvL5345
PfqSB2zbuRskigtHo0igrSTPdC1z4R5fWIUBxt+l1n18TzyK8dgplRcmgaZtSfH18aLAvcrFM+h4
//F6ev+lnblcC2p3r8Nd3+uvl/fzo/KFGp7WqAdEr8Wq3zIK54CYbRItzEdLTIMpQZsNEmPMzwEj
EO2ZQ5Fnlj0g7wqKGujR7lqaJwPTVKsBc73LSTrefTeCDLd0EVbNzB3WECOqz0iq4XTdlRpSbt1d
EaU/JdKsV+K7oPSzS7N74UG6vo9hg4uXKvUwvl39Sn9iD8lo6epmpuT01+vh9dfN6/nj/fR8NCTF
b3w/ro1O8nVHniT2+iV8BxpOAGZVJXXQAJR4GAnmEFjV5m/5BnAZtm+5a0ANkwmGdcy0rbXcMfwf
AQC1w/OJAAA=

--Boundary-00=_O8rYBEPMK56psiP--
