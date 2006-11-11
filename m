Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946761AbWKKMd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946761AbWKKMd5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 07:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947190AbWKKMd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 07:33:57 -0500
Received: from aa011msr.fastwebnet.it ([85.18.95.71]:64437 "EHLO
	aa011msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1946761AbWKKMd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 07:33:56 -0500
Date: Sat, 11 Nov 2006 13:29:29 +0100
From: Paolo Ornati <ornati@fastwebnet.it>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Adrian Bunk <bunk@stusta.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [discuss] 2.6.19-rc5: known regressions (v2)
Message-ID: <20061111132929.56c4539e@localhost>
In-Reply-To: <200611111149.27370.rjw@sisk.pl>
References: <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org>
	<200611111008.37986.rjw@sisk.pl>
	<20061111102506.5f98688c@localhost>
	<200611111149.27370.rjw@sisk.pl>
X-Mailer: Sylpheed-Claws 2.4.0 (GTK+ 2.8.19; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_ZwJz/9lapExgk9qFwPzRvaM"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--MP_ZwJz/9lapExgk9qFwPzRvaM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sat, 11 Nov 2006 11:49:26 +0100
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> > > > Subject    : BUG: scheduling while atomic: events/0/0x00000001/4
> > > >              after resume
> > > > References : http://lkml.org/lkml/2006/11/2/209
> > > > Submitter  : Paolo Ornati <ornati@fastwebnet.it>
> > > > Status     : unknown
> > > 
> > > I couldn't find anything in the report that would indicate the problem occured
> > > after a resume.  Was it really the case?
> > 
> > Ahh, I've written that in another email but I trimmed LKML from CC by
> > mistake ;)
> > 
> > 
> > Relevant portion of that mail follows... anyway it seems that "-rc5" is
> > _OK_ since I'm running it by 2 days and it survived 9 suspend/resume
> > cycles.
> 
> Okay, please let us know if it survives the next several cycles.
> 
> OTOH, the problem may be hiding.

Ok, and if it survives againg and again I can do a partial bisection...

so that someone could guess the change that hides/fixes this and I can
revert it on top of "-rc5" to confirm.


> 
> > ------------------------------------------------------------------
> > 
> > I've reproduced it (with rc4-g4b1c46a3), and I think it is
> > suspend/resume related sice the messages start flooding dmesg just
> > after a resume...
> > 
> > I'll see if it is reproducible just doing suspend/resume a couple of
> > times... and if so I'll try with -rc5.
> > 
> > 
> > dmesg (stripped at the end):
> > 
> > [    0.000000] Linux version 2.6.19-rc4-g4b1c46a3 (paolo@tux) (gcc version 4.1.1 (Gentoo 4.1.1)) #17 PREEMPT Wed Nov 1 18:36:28 CET 2006

[CUT]

> > [   25.382084] BUG: scheduling while atomic: events/0/0x00000001/4
> > [   25.382086] 
> > [   25.382087] Call Trace:
> > [   25.382097]  [<ffffffff8049fafb>] __sched_text_start+0x5b/0x4cc
> > [   25.382102]  [<ffffffff802f34b6>] list_add+0xc/0xe
> > [   25.382107]  [<ffffffff80236519>] worker_thread+0x0/0x11b
> > [   25.382110]  [<ffffffff802365ce>] worker_thread+0xb5/0x11b
> > [   25.382115]  [<ffffffff802233e2>] default_wake_function+0x0/0xf
> > [   25.382119]  [<ffffffff80236519>] worker_thread+0x0/0x11b
> > [   25.382124]  [<ffffffff80239269>] kthread+0xce/0x101
> > [   25.382128]  [<ffffffff802234b1>] schedule_tail+0x30/0xa2
> > [   25.382132]  [<ffffffff8020a238>] child_rip+0xa/0x12
> > [   25.382137]  [<ffffffff8023919b>] kthread+0x0/0x101
> > [   25.382140]  [<ffffffff8020a22e>] child_rip+0x0/0x12
> 
> Apparently, the kernel thinks that worker_thread() is running in the atomic
> context, so there may be a problem with preempt_count(), for example.
> 
> Is preemption enabled in your kernel(s)?

YES (see first line of dmesg) - full config attached

-- 
	Paolo Ornati
	Linux 2.6.19-rc5 on x86_64

--MP_ZwJz/9lapExgk9qFwPzRvaM
Content-Type: application/x-gzip; name=CONFIG.gz
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=CONFIG.gz

H4sICDnAVUUCA0NPTkZJRwCUXOlvG7e2/96/YtBe4CXATWxJjiIXLw+gOByJ1Sw0ydGSLwNFniR6
kSVXSxr/9/eQo2UWkvIt0Nbi73A/PBsP54/f/vDQYb95mu+Xi/lq9eJ9y9f5dr7PH72n+Y/cW2zW
X5ff/vQeN+v/2Xv543IPNcLl+vDL+5Fv1/nK+5lvd8vN+k+v/b77vnX/bru4A5Jos/bizU/P63q3
93+2Wn+27rz27W33tz9+w0kc0EE27XWz7t2nl9Pv7l2fystPgC8/PicxyfwIddqXsjDBI5+wTKSM
JbxUU0iER5IjTAwYiRAbJhygkBBGuLhgUZRefvAJkGYDEhNOcSYYjVV/F/yEDCeEDoayCWAU0j5H
EsZNQjSrTCzDEZvi4eBSSBAPZxnjNJaGTqhAavYGIIHpXIoRx8MsQrNsiMYkYzgLfFxDWcLSEEYl
sjjxSVap7ke0RJ36VOo6JQISnBafCvnp95vV8svN0+bxsMp3N/9KYxSRjJOQIEFu3hec8/tvsON/
eHjzmAND7Q/b5f7FW+U/gXE2z3vgm92FI8gUNoRGJJYovHTa58mIxFkSZyJi1e3PRoTHpERLYxgz
iccwbjXGCBiq0y5GMNB8vfJ2+f7wfOkTmkHhGPiAJvGn3383FcNSyKTEQpPymomZGFOmVhkmeRwE
LHwsvOXOW2/2qr8TLUsEnWbRQ0pSUpqf8GHjE0yEyBDG0o5k4065H4nECHhdVro6o6kUtVGcIb21
RoSOij+MIFd8bJiWWnSOokBkIkk5JqVlxDhLmIR9+EyyIOGZgD8qa4dlWJ4SifrE94lv6CWlfqtb
pi1q6/+hMDTUGEGxmEWlE34qyeD/5abO5WQKM8kYEqbtGyaShWnp0NaPa78MkjDIMAiaEgzHIgvS
sMSvQSrJtFSHJWVUDCMSlX6GqH/5NY4yMoajAp2ksawIMi6zSDVMRIVdaDwrmjTMTY9NRGpdbktL
HCb9MrE+SOFm/jj/soLjrA++tzs8P2+2+8uRihI/DUlZsOqCLAURivzykI4AcAY+wUbOA7rjWRQ2
XLUjOD4fWTNHACH0r6fRX20WP7zV/CXfXobePwr5c8th3zyifjgCaTgGAZxpTWMkCkXQWD2aeGLx
PVcrty2JPpoIPCQ+COWEVWTJsRyZJ36CfYL8kMbEdDqPJDh4KDcMohylobQ1fIIdDZ9ILA2rmThq
HYf16ffF17+POoJtN4t8t9tsvf3Lc+7N14/e11ypjHxXtRqq4laVjEE1GDqLRr0KuzGBjbM962yW
GlpRHYQtUOgw4Kw/A935qXtnBMWQBvJTt4xRdTa1qrXXlwJXzYNBksCWM1qZZ0Qx6AJoyTLESPCa
kcFAZlaLgF2PzZaHr3RdrTySnFeEbXV9z+WMExIxtdsxcRKMkxDEFOImBXKkKQvWolJ/FNbMF8EQ
B8MMTDMSo35IanAApo0JFGCUgP4EKOEzJS7KRsOpUoTiFFX0gk8F/CXp4AIbJ3kZVZOo2km116MN
putVjv2lQaXgKTY0KFgItg6T2g6CrRafzjzFSaGIRd2m1mtUrM1pLRpKbciIBF0REV4rI5E2HEG7
lPgEDFBtNZ9HDqw0gF0uANOwJzSRYb/KgREm9RMNRfrshDZuBxxFFW0yAo1nPt+YIzHM/NQoJNhw
Jqg6AbDU4Crc/gI3Bf4pbQbBOLHwPxg42t0AM00ChyXcSDX8nLVub21Q+8OtydrQdW5Lm/D5U6sy
Lk4S7hNu0nO9LO4bfBXEfcofhMGP4A/K0uyXjszR51By4aQy2eaffAtW/Hr+LX/K1/umBc+i8oaw
KAvJAOGZWTJEoAzAZLKBYNiBSQkeHicY+M5kE4okkBOknLlUMBKXhJ2qL8F6hh2l8mja6zkgzKj3
Bj3+nK8X4ONi7aQcwOGFiWiVU0ySrvf59ut8kb/1RN2+UU2UzhT8KpxJU5m237OgYojVUf2n2VBX
lAjbsT6SoF5MMrWAUylh7vW+x9Qnib1REAkjYm0zQM0GfZBBNvqjA5Pw2vLIIeFRVdwW04W9tI+N
9iM7KBNQwH1kXY0QDqpyXLMZuNtlO7eYRJ0ZyyDBteGzZELqUwKOlWURr22V6CxMq90pxYLAsuL2
+Yi+aNiPykQJtvnfh3y9ePF2i/lquf5WIEeJxNIs4OShUbN/2J0OrPeGYerl+8X7t6Wzi0tcDT9A
+8HJk9WyKCp+VI45pkRFWfqWjdP1BLVitoUfSiWXzsIHYxBfauQRpugGz7ePMKO3Jfej1KgmrS+A
mvNws39eHb6VDvVFEheaUA2pUZX8yheHvfZ6vi7Vfzbbp/l+59145OmwmtekYJ/GQSSVB1hy/oqy
iJZtPYo67aNepdVzqhGUpNKwLkoZIdkIQVzK9ZDjfP/PZvuj4I4jZUwMcEmKn7sHQtuuMDhEpMwV
+jcwRjkqksa05NZOA17RC+p3lgoL62tUpH04YiHFJjkEowNlPyuHfcojogzc3xCsJiRkNS6TIX+M
YgzeEIelNapOIApoH1SlGNbqstgspNVoKKMucMDNxrEaqR6JWQZwZnY+xSyGzU5GlFi8QtUrGtox
IpgdBFayWTsa1/sj0zgmoZ2oiTeaUFa4cp5jUQ3R1il0S1a4T0i9rk/RoFYkMTsVX+IhUAZ/Ds5M
YRjtmQan/bJ7dPJiTzi4sYcvy8XRxqDsT2+83O4P85Un8u1PsCcqdkb5pAELjC27yMZd6wJ3X7UN
XRcB4JOEj5R5GyE+Mp+zgIayqrzOhU25fYz0bnMlXUBO7l0Tv7QDf4U0dg4gm0rltAjzQKawEYgP
YJ9xiISgwcw24UaF+sydxHGgQ7fX6SMkwdGCY6Ri2a8nj2MVSxq9toKPMXs1rXg9rU06GEiHJGQW
MW6gDkk8kMNXU6vw/WuJI4uVbCTlr17ipgpytqy0jhJmr25+JOWMvZqhHtJEotcSc4LC6LXEAkt2
5fydKCX4Yp+e3K2pmIWohS3cFTiNB6+lBqEbiaZlrKSuXe5cxG0cXI5aeSJHSOqrFpu6Lle2c1Kd
UAfqhYtUKj9JJo2NqNEFTpRy7EBhJfs0sV4KFUTS3QOKUOwjBwFjzvrDTrvjgAVlZpMMsOLW7Kla
SNlRLzT2sWAVysC+GBBHl0eWSsRVGnCGbNK8TEZwfJXGZpuVRyRD61IUFMkEnEfbxJHvc6toKRMq
Q7chaas8V5gAjY6OSpGTv4jzvBzpwmRwnSh9FVVTANRZHbn3KR6ErpXhaOI6A/zIdA0JpBVyNaL0
pnyn/bZm+NUVuIa1BPgvGqlLDA2DGsKvbkQTGx0QaVYgfU59y6EahyjOerft1oPlWgmDGDJfloW4
bVn1qWV0KDSL32n7g7kLxPpGgMD/LcOawHyazqJevoeNUBHDm83W+zpfbr2/D/khr0VjlPOhL7oa
tY8OuLfPd3tDJTANBsQsSYYo4sin5gge5Rb53LccCUKI2q9Wk5vzn8tF7vnb5c/iqvKSRrFcHIu9
pB4BBt0PGiKE9axc5+ib6oDySIdr+ykNK6H7YJKpy1+LKakdjczndGwhEDORDUHa8TEVCTe4JOt1
vtjDPr3zDuvl12X+6B12MKnnOUzwf9/93zGVqfi9Wq5/6DvhS0gNFHkjuK8Jovxps33xZL74vt6s
Nt9ejqu2895E0q+cMvjdjEjNt/PVKl95KhZljGSBsKnZk0VFFcPS0erV/KV5A8/iym0S/LQ4a2y7
2W8Wm9WuUvcY4C5dkz8WsypflBf330FlG1UpZg+ZjQWPMKZCuGhUwz7C991bJ0laS2VoEOBkop2w
JDZlPByJwtqN+7kynzGZhLVb7AZZfCVBQEx77kn0HWPjqBRNLhUWOR+fWl0TpnNs7m7vjaBOcNAU
rdv2XZ1CZ/JUdhT7PImUMML+2LeJ4SyBg5mRqmtXnI/lblFinovU6UcZEubdEwOa0QTfGUFJg0in
1TS6gnHcwL+M3kRBdMPDsHksqE+ay1kUHk9VPt/l0CRIvc3ioK64tO68WT7m7/e/9irs633PV883
y/XXjQdKFSp7j0oSVmZXajoTSLoZfegrOneSiU98KiyuRoEVvqcOiTn4CYixb2J2AGDpro4iCBPG
ZteoBK4G+y8j1SlranN11lfhtcGAF9+Xz0B42rCbL4dvX5e/ahwDtY+3le4zH/ndu9trQ6zFcg0E
5cuQ4ncmhkp3FVcSjUaTIOgntVuHBtFrJqDy5brtlpOGf1Y3we4ZqLvbYhZGfgJUp1355p061j6l
PlbYDaAkDmdWljx1gwjutqdTN01IWx+mHTdN5H+8u9aOpHTKrnOGuxXJaRASNw2e9dq4e+8eMhYf
PrRvr5J03CRDJjtXRqxIul0nyV86cSh2ayncat+6B8Nggd3HSvbaLTdJLHof71of3P34uH0LbJMl
of86wphM3JMbT0bCTUFphAbkCg1sWMu97SLE97fkyn5IHrXvXYd3TBGw2HQ6rR088Dyjq2fecFjp
uG8/5PUDflFLBs8U5HqhzE22KkfUh3MouSl3VtWtJDjBb1Pgv0pwTJ4wj+Q4hCJZ8M3jcvfj395+
/pz/28P+O7Ba3jatVVG1bYa8KDV7Ric4ERaCc6ume8Rz4wNjl7hpK4nNU15eY/Ah8vff3sNsvP8/
/Mi/bH6dL7u9p8Nqv3xe5V6YxhU1qZetsAUAsmyEcmiUnyZFY0vCZDCohWIvKy638/VO9d/sUqjM
jfreV0kCfI2C6v9eIRJIvIYkpH2BLJyz2vzzrniC8Hh2bi+HRjchsVuZdCYZHNCpZnr7QIDqfmrR
XMVcsc1kKGCE3R0gij+6OygIrML0THR/pZX7OycBx5Ew++YRGSAtGkBM2yIaZxpHutiZRiDH1oM+
pBaPTeP9VACLW0wwTeFH007rvuVYLmIz6Qs2T2UKZqKfRIjGdrKBb7kJK04Ccx2TWKW0OXFkSzcs
zockjr0Us+hDB/eAadquAXI7+KCXOGu1e7cuIrBAsRundVeiJqyYqwEfd+4//HLjt9KBGyMmIt8u
5yvlbXpvnrebx7dFGOYUyNHl+a9noNLu4+ptScZcPOaK3FUeNBpiy0QVChaM1fe22mW6ZjS2Y7EZ
A7sqQ2Aa2Cs+CFuiq4ZBa0dUEMd0pncOkIZOsO2sK+xgGpq8Ug2BxdXYkTGVRFhmwfSWhdQBRr4D
5NIiowrY7sto3OHIFLjd+TjjHRc+Y5xY7lc0AQkQt/Kjy8fVtR0uyxn/OHXj03Z8haBjxx2OisZd
DpMmcLmJmiCyHkoNgzJ2E4BhjEkYOgi0I+XYQxVFcKO2E64JlAywmQyaQF1AiJmDR5ohiiru8DgL
nPAx4SpBSTiHCS6gi1lAYHR7rm6oo3kQC3ZwQuN+Eje9pEiZ5u+qbpL3RptxSlOE46h6LdBsITio
99RexKTD2wpS9c7NOLwCUia5C7aozlNlg+2sroq8Vuf+znsTLLf5BP41pt8qOk3WaKCdOGakUNsl
WaNWOU91THH5taGfRtGs4tLCNtnSS8hDCnL8s+VeSaaxNatT9OsMXoShOV7ne1PMG5DaJWMRdB7O
HIsCKHgyzXzk/Xd1YwWMBUJgs/VgKNGX5f5tZWVURF69jy7lR0a04oUPEWOziNheNaXxwHLDglWa
XUytizMmsZ/wrIOTqHk3fVgtn72v86fl6sVb2za40pwE3W1WiEPWMgZC9RVqNfrJ1PJ3zDYtqOte
q9Wq32FccB8xSfRbHx5QSzZv/85smhRxVlvT/sDiyhIChpTNjic2IIDdjM0CMUZSkMi2ae1RPfP9
DPbgNGNTwFwBMqnEj45FYJYm1rYUDkeLZHJChbScvRNhr9W+txIoJZXxqXrxZrm/BwF/b1tDRrHV
T0pjXyUFm5McKOi3Ye1VbONcQsunM1l61kFii23kh+2RdavNgwQroNOzWHpDFCE8NO/nDGyLZBJY
3FPea3XvbWvZMkYuxWhQecAnRjOL7zi674WWftWqjkmYYCpnlru/QRJbArDx1NwheJGdWoDEsFGG
ncJDEgr1utt8E0OnA3MqiWhbGD+acdq6HTR5Rm5+5GuPq5cYBq0hm0kHSvGu8t3OC1HsvVlv1u++
z5+288fl5m1dcDbyRIoG5mtveXrgVultgiwmhe+bWWlImcXMYMwShgkdTyVs/jwoKuNrDWUoJ7FI
wlJmIJQdP6NQbloVgaSw9axhyRGz6RKFqydbHP7QCfGFRSP8GJTWl93Lbp8/VcOIftzcati35++b
9Yvp/REbJgaJQtfPh73V/qExS6tvXFRBFgTqeW9IDFmy6S7frpQhWmGASu0oSQXoq3Gz3ROSMYHS
qfF1R4VMYE5InE0ryQZmmtmnj91evb+/khmQWJ43KAIp3DgZX8NNMZ5izRv5T5WaIzLT972lj4sc
S8ALHvVrD5OPCGiVkSVf5EwTjq6STOVVkphMpMU9uIxGJhM0sXzS5bxH5c94wE/Y+nb1Ex6qELw1
arEiC4KxACmMkGMrYK9VyvjItdtJiocFvzio1BO7xpYO59vHf+bb3KM3iXe6wji/7+a0/H0f9TOj
vdu7ykSLYvivNcG/oMCy18YfLb55QQJ2FqyiSY9qGAz+2iIX5ba01AGKiDFLDH+fb+cLlQ3fyN8a
l5yCscxOQvTy2HxSKruoaFkC1JNGq19VMIT6LESREGh4jnmMpDbCo8eqvfaH2/oaHItPI7Cs4Imq
ksNRAWJmBmKepYjL0qcUyihPY/WU90xiHBqZSvB9TPmeoKcVBZToeddS/qpNHT8cVO/hL2G6AFaP
Le97GZOzyn1ecZeiiw1vJSJazSOOKJiMsR8a8lwn8/3i++Pmm6fe3NbMBYmHfmJ8vDsBfgUnsPLw
81xo/bTDhaL2cYcLMCCJJV8qHnNkWqDiixUXS1ta8oZ5575rduHATw6pyZkNihtnsCa9r6vN8/OL
voI+6euCtythm3qa1amDQfnzAQOmpq8/jncZAhQ2Vq2C2mJZCquFsk4rUX2X66sXhX5gNpIUyFvt
nrkZZWmS6hNmVRoNkLUx23AVZou86XpobMvViCZobInY497HTvdXNrD5pSBcXRnG6gsoFj8rHoCv
gEfFM/+myccio1mP4V9mDq7AHuOw9kWFY/wMG0zAdvlBeRuD5wLSVltv50po9W2zXe6/P+0q9TIU
DpLiAzGlKFxRzHBg1rFnHBnHd1a06nMDxigfLpK+Oh8c7QPe7bjxqQOP/I8fui5YBXusOKh+F2hR
7Qr8T2NX1ts4joT/StAvswvsoC35knexD9Rlc6xrRMpx+sXwdDxpY5I4cBLM9r/fKsqHKLEoP/Rh
fsVDZKlUJOvAU/2RSZ1yVQzH9jxn6mTIJZvL8TMg6N5q43DQF+YLSVOVueWNQYoaHtE4Wj7NxjZ8
MhzY4NlkTcOy8knQLLZOCDxZe0ZXeR7mOc0ZwLW4EEY75d0z7It2B2Bb5OPgx/7NxL8iAtWjFJtQ
OMPhlNB9riTTkZVEnfGlVhJ4Eb1xTzPwWLPxcNbfzsyx0qRsPfGm9ErXjhht82sDCUqIHhIqWkij
nwU3uEcV3LgsxCkE2iWlTJjcd8ItLPj7L+93zq9/70Fg/fGp6zYOvYlID6/7D5Cor09deby4T9V3
sPkTI+7o6lw93wyEbzWvysq6KixMYf/s3EAzvoFm0k8z7O1r5o6M54AniqUno7QwPrG6NrE3L9eF
0/diTXrmI5463mAc22nQMavsIykI19AzyTwZO55I+2jcQQ8Nl55dnCQp8Um8EkzHfQR9XUy9HgJv
0EfQN0ivb5C98zDrG8PM7RNzzsTpE5eoMNo7sn0YLzSpCEbT1LmJqGfcNZk/nNknCD6NE2/C7DTS
cR2nh8RzeyTBvTecepSpXINmdguN20uTTL2xFBa5AzQTd7qITZKnxqKFXSYsQkaY3tWC3PJlUhf/
L7vH/dZw3IIR1za1Vq4VrUaJYyrrBHm6QO5ZsV/tH3cH2JO/YYTUO/YI/2n4aZJo474FW2ThigzA
VVPUMT7UM4uOufhpWHzFiTsdhH3pjTwLHhTEdu8KuxZcMDZ2RxPWSzKjLvnh8YaD4cTWgFQWLxaK
b3nJMvsQps5wZKFI174FDQkn7fMirXmVbvKSMgrRyOZRSt3en6Z87XkdBgfmu6uEb9rO1rWKVQm4
bami1PUIO2KoCUQBS0mU+6kNXuYZVL8PSILfKx4soYVNioZ92Zz49iNpJCfO2h07lkfJV9BUWxBo
jdzPZhOP2EYjnq/GhAhGVESjgQXNZgEoc6bTQETlauINmiEbsPRbMBhamizuu8fmJd4qGqWHullE
RpIRbThQE8HnltMO62eaCF6xnBxcKHyDBr9/2n9sn0+yzj8eto/ft8qb/uyG3RxxuPLp5pmPnN3u
YH7cvv3Yf3/vavkXV/YobMZYjn3Nqx0aDk2xewEI4E/Mk0QPsXgCgrx4gMZZB1BuSn6iH9lAecoC
dP00yyfAfRX5snVM0KiOkdRqOS9aLUueqA4lddKPI+NlWZF9F6lLVnzwo9KlzBuAgBERbRASPOGM
CMiipkpIElzNmTMhwUgwClvMSUg4oTOknDEAz0BucLJ2yVckRh/7qqWH92ZtXtfuoeylEPfZ5Fhq
Cjo6L06/fGgdBrdQcprowyhEOclHWZQD93Ny1MsHQn4ANqROtXG51ZmRQ8GyBHFPsxl9G4FN81K2
woGfA1K8H553d4/79zcM4FDfE3SlDLCp8RpuzgK00cxjDC6CFgk+FTbupHuo8Oemk3u0leze/sUl
S2Hx4xj1vm7/BnhT5lIFMSUs4DKj3o7lG+9/XqPnukRl+jhlm3g6nJIQdYJ5JflcU0bx9ybhWbUG
iZaZmaFB0xECXZIgqaTravcwF1G6SYLwnGDI4Mz3+frYuNbLq+ySeeISfLpOo6RI79jx+4/9x+47
quuNes2Y1vCjHZgdi4og1QtKdp+CqNELRfR7FWWBHsvxBNRsYNpXAZ6DrpRWid5aytew9gB1hkIW
bjC4Ls8EMaxuvVIGhqfF4Z6RcxjO9iOFDxlLeQCjzHKzN2p2WTllQciK1mytotLP0dihzAM9eLeO
Yv4X834Sh2F0IDoH0OnsEdW8FhVofeqGWR8QC2bTDSZ/CAzloLt0pqC9ovoDgPbCCYsuNQxZsBWJ
ni6jK2cyHg/oNtSjGIMwGzYQ6llCx/NmZIMsEcPBwAaPBlacj0eERq9w2uvmCitNKaWJKo+6HjrD
rh0eWuBvcjgkPrmIwy6b8IRANGADZzCh4ZRTSryCxcj1HBs8WdN9g/xwBkunD7c0kOFVyqAHt3Qg
nNnQs8ITGo5T6kIQ0UXILApaTSEKK0gzFA8iZ+q4dpzyiEMcB+atB70E9BCWeTl3XMsYTlu3IU3A
14wymQI4S90xzZhFsF6UJFqm0dC1obOJHR3TtQWeJ6y4T+yq1Ne4qxtqUpZ5rh7FoVHcI0pWa9el
x/aQxrbXVX0VVIYCVLe7RqXEKQ5Wxd0w5ofLycaRohJr96HTbP62ez2pM6JjEKtUIPxkpubxdJRf
NZKyDlG5WQQNRUhD8kXTzEuDojbUXAq17Td+ofXLYBxbJ89JXRkdj3TtAMt9loX3nHLvVjVJ/UQ/
46mTmtDnR3JunMnF4f0Dtxgfx8PzM2wrOhas6oQL5uY0q/rJF5bXuYW4oM9jFFmZ53KzqGCPJO2E
UqJBaicOon66JwrHmaxxTPQTnwZNHHtVxDOJxHOcdr3LdJ3sfIPn7ft71xpRMVRTw1ZHZaVK63XJ
pZDL6N939cFbXuLudveKuSLeVbiJfym/v1/qyB7797/OnP7L+aj+BXaA2+f3w90fu7vX3e5x9/gf
FYOs2eBi9/ymwo+9YHh1DD+GCSi03VCDvDMBdbFlR69RMcli5vfSxWUUBXnaS8dFSLl6at3CRqGX
CP7PZC+VCMNyMLuJbDzuJfutSguxyPu7ZQlITtZLtmRlSlMlHNR506EB8mrTMl0T3Vhzwc0MjuX+
AUrP0R5NYU/UCbpPv3rKjJtEGS9ktKRPwpmNT1gQBYzueelLCzOqr1zKJD22PqtxpHmIGBmJCPF1
YRkgbA02ZZTmljFcSVz6OaMHUWC02Z6miiKJ1DOZOeRl+0S4EqllDAPP8i4qz/fWSl6aPjvjmq4D
sHLAJH35smT3keWTWERzMvET4qUEGT6mBw5/0E0n5byHxMLgmfGplZ32ox4EF8tP5uvwnQXkQzu9
a93jtF0jLk3oigbxUkYpn9BMAyhh0aN4JaxkRV+3sSoqxT1LaNYueT62sEsSzXOJLyBNYfmaJxZt
4BSDAv6dBoTZS02m0ojRbLXASNX0ovPQLtdiGfJNlLDM/jqGoLy0ciPrPMCBt/3V3CL16anAFDkB
6JqYTDynZ1pGQpr1G5Fgqt7dS4NDL+B8+/i0+zC5o2Gbc9aevVpBToOvIlTuACauB7ibNBjW2iCS
QCtENhBmev2lwyJ53D89Ncr465/7172PCpbJ1hj+zjjq413/z5AFd7/e7Y7HA3rH4MHrOQHgcYft
oAz9R8nEPy2B01UjnSvTHUgFuX9BjfLw/S/tzlQGdYaa7k0mKATRKwhuows8xumLsrnJ4RgrBs/7
3evHZU6w6Koh1F4K++OLMlwMuzImCkMi6DY6TPpm08QwCH1DhIgYc6PVvpBaWnfptlIgnoo2a4zk
ZvZ6PlMYU0IAOuw2OextcqRiVpuOhH/TXfbgp0VbLiMOYj0WraautWkIkDoNPAsSIv0ZWXceC5fC
8JyaBNHaY02BZZ52ury8QLnksZZoTRWo5G3N6epkpjnzyaWBRvJ5mVP91dioXtlrQJIIC15OV2cq
tuNXjEaN3NZhNti0ziaTgdbEb3nCI+2W4BuQGUdQhbFWFX9niTjv9MJcfI2Z/JpJc++A1WM9T7yA
GlrJqk2Cvy+ptPMwKnD/NhpOTTjP0blDwLN82b8fPG88+9X50pCmsjOx9Zn7++7z8aAyF3ZGfM1P
2ixY6pnr6zSlD6KO23wNut+sJ9NCfyFVQQ+zLyr4viQ+wZkndFO0LowvliOp3mP9j3kOdF1Ln4pG
mA/65WMxjS2sUJFUJOxHdFWfhiy1AjUt5stgi2xZFDT2e7Ye0Simn6SwyrwY552E+l6INktmsf7K
4O/VUPPnVyUkVyl4REJ1XlP9hPMKh1rHYbfnsKfrsNV3E5FBw80PfbwavamfUPdKAIpHXsr2VNQZ
DRrvYZWVRdA09oKfIgo2c9Cfl6VvPuBo0IhimRKn96lPshkngCwoyDp5yOjXi2SwWWEUaltQ0pTS
Jn++6VrlJeuzLbVjLZqvCaLPZ3nbD1CR7pLt69Pn9mnXzf5cfw2uPy6X0F8+P/70vjSRszjfgDjX
UqY1sSnhRaQTEZb9GpFH7I9bRO4tRDd1d8PAvcktY5o4txDdMnBir9giGt1CdMsUEHEMW0SzfqLZ
8IaWZrcs8Gx4wzzNRjeMyZvS8wT6E6ofG6+/Gce9ZdgOZW2LVEwE3BS8szkSp/2GnQG39yGGvRT9
EzHupZj0Ukx7KWa9FE7/wzijvqkct+dymXNvU5ItK7giWq1k7F2ckV/fP47XxCpd6QqaZswTnjUS
+OZ1mXapsYQy35CBbanyON392H7XE19jGkaVuiNO2FycbX+aCi5a8ijrqsbnN8M0b5u0EnKjXLwb
oVDQEBE1Hz0ZSJVhUBuMoOzniWl7UbuPLDEqX9JUBNAdMt6IBY/lf53plVqCoqLs/FA5qHSPOrxN
w0ybwpIzSyTMJ4dRlFGUFtq+qAZKCQ8tozVx832G1ZGTNWWXKHjW9mRvkdg6Oo3mXkSpjQB72LAE
/jG7/pf5KlJELRNm41BhyqKo6M7JqT6aiqE5ZYzPbhvUMvfJvIg1Bc/i3ALHttZXKfkgCReyZckJ
m7DzfWWDVe+5sv8gBlEHLQQcXkbK9HsRYco2Ub8cZlYJqo2ENw0jorcPKPVFzsNWWGwOam5Fuiad
Fk2yYInJp+Ikv++umYI3lWCGqGti9/3zuP/42bjbb0ZIonw+g6pshaerKx5/vn0cnmp3AVOTdTax
7jHn/o/j9vjz7nj4/Ni/7lpVgk0QcOJuHVCj8SqUD7XYQQn3VZnJD6E4Mcv/ARIRHIMGlAAA

--MP_ZwJz/9lapExgk9qFwPzRvaM--
