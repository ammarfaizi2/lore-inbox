Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266539AbUIUXcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266539AbUIUXcS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 19:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267314AbUIUXcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 19:32:18 -0400
Received: from pop.gmx.de ([213.165.64.20]:39092 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266539AbUIUXb5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 19:31:57 -0400
X-Authenticated: #1725425
Date: Wed, 22 Sep 2004 01:35:16 +0200
From: Marc Ballarin <Ballarin.Marc@gmx.de>
To: "David S. Miller" <davem@davemloft.net>
Cc: rusty@rustcorp.com.au, torvalds@osdl.org,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Warn people that ipchains and ipfwadm are going away.
Message-Id: <20040922013516.753044db.Ballarin.Marc@gmx.de>
In-Reply-To: <20040921153600.2e732ea6.davem@davemloft.net>
References: <1095721742.5886.128.camel@bach>
	<20040921143613.2dc78e2f.Ballarin.Marc@gmx.de>
	<1095803902.1942.211.camel@bach>
	<20040922003646.3a84f4c5.Ballarin.Marc@gmx.de>
	<20040921153600.2e732ea6.davem@davemloft.net>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Wed__22_Sep_2004_01_35_16_+0200_fil8Jbh+_6drhF_K"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Wed__22_Sep_2004_01_35_16_+0200_fil8Jbh+_6drhF_K
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Sep 2004 15:36:00 -0700
"David S. Miller" <davem@davemloft.net> wrote:

> You can't have ipchains and iptables loaded at the same time.
> You must first manually unload iptables, then you can
> successfully load the ipchains module.

Yes, I know, something seems strange here.

Just to be sure, I disabled iptables completely and rebooted:
(Complete config.gz is attached.)

# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
# CONFIG_NETLINK_DEV is not set
CONFIG_UNIX=y
CONFIG_NET_KEY=m
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
CONFIG_SYN_COOKIES=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_IPCOMP=m
CONFIG_INET_TUNNEL=m

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
# CONFIG_IPV6 is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
# CONFIG_IP_NF_CT_ACCT is not set
# CONFIG_IP_NF_CT_PROTO_SCTP is not set
# CONFIG_IP_NF_FTP is not set
# CONFIG_IP_NF_IRC is not set
# CONFIG_IP_NF_TFTP is not set
# CONFIG_IP_NF_AMANDA is not set
CONFIG_IP_NF_QUEUE=m
# CONFIG_IP_NF_IPTABLES is not set
CONFIG_IP_NF_NAT_NEEDED=y
# CONFIG_IP_NF_ARPTABLES is not set
CONFIG_IP_NF_COMPAT_IPCHAINS=m
CONFIG_IP_NF_COMPAT_IPFWADM=m
CONFIG_XFRM=y
# CONFIG_XFRM_USER is not set

This gives me the same error upon modprobe ipchains.

If I disable CONFIG_IP_NF_CONNTRACK, I get unresolved symbols:
ipchains: Unknown symbol ip_ct_log_invalid

(Is that combination supposed to work?)

lsmod (ALSA snipped):

vfat                   10432  0
stir4200               10052  0
irda                  110972  1 stir4200
crc_ccitt               1664  1 irda
fat                    36320  1 vfat
parport_pc             29440  1
lp                      7976  0
parport                32072  2 parport_pc,lp
floppy                 50576  0
radeon                120676  2
nvidia_agp              5404  1
agpgart                26024  2 nvidia_agp
8139too                19200  0
mii                     3712  1 8139too
crc32                   3840  2 stir4200,8139too
evdev                   6848  0

Regards

--Multipart=_Wed__22_Sep_2004_01_35_16_+0200_fil8Jbh+_6drhF_K
Content-Type: application/x-gzip;
 name="config.gz"
Content-Disposition: attachment;
 filename="config.gz"
Content-Transfer-Encoding: base64

H4sIABu3UEECA4RcXXfbKrO+379C690Xp12rbfwV19lr9QIjZHMsJCqQP/aNlpuorU8dO6/j7N38
+zNIlgUSKBdNo5kBBhhmHmDIn3/86aGX8/Fxe97db/f7V+9HfshP23P+4D1uf+Xe/fHwfffjL+/h
ePifs5c/7M5QItwdXn57v/LTId97/+Sn593x8Jc3+DT+dPfxdD8AiRWUF/mTNxh4vf5f/bu/bm+9
Qa83+uPPP3AcBXSWrSfjL6/VB2Np/ZFSv6/xZiQiCcUZFSjzGQIGVPKnh48POah4fjntzq/ePv8H
VDk+nUGT57oRsuZQlpFIorCuEYcERRmOGachqcnTJF6QKIujTDBeNTMrhmPvPefnl6e64jDGKFyS
RNA4+vIf6PT3/1QssUK8rlRsxJJyXBN4LOg6Y19TkuptCz/jSYyJEBnCWLo52XJo1I6l6hmMR0lB
qU+lt3v2DsezUrpWGKpKg0zMaSC/9EcVfR5LHqazukq6KH9pUwo19LYImxLfJ76luQUKQ7FhQhev
aDArMkEZR0JYSgapJOu6ccLjUJs6Ggs8J34WxTFvU5Fo03yC/JBGpM3BwVddPYyzmEvK6N8kC+Ik
E/CLRT8xZ4Tp5SSNNiVVly6MJzxuH7bf9mCnx4cX+O/55enpeDrXZsRiPw2JpnVJyNIojJHfIoNa
uM2MpyIOiSRKiqPEUA5IFyu1jfUC2JWh89PxPn9+Pp688+tT7m0PD973XC2v/NlYtBk3bEBRSIgi
vXaDuYw3aEYSJz9KGfrq5IqUMdOeDfaUzmCtutumYiWc3ItjQQmeO2WI+Nzr9axsNpyM7YyRi3Hb
wZACO3mMre28satCDi6PpozSN9jdfNbJHdm5i7HF0tjis2GWi4m9ME5SERM7b0UjPAdfOu5kDzq5
Q9/R7iaha+dwLCnCw2zwliVZ+q24mPE1nmsOVRHXyPdNStjPMALHdHHR44qXrARhmaoBimQonMUJ
lXNmFl7xbBUnC5HFC5NBo2XIG21PzRBVLOqYI79VeBbH0CKnuFmnJGGWCpLgmG9MHlAzDoEig57g
BSzfNnvoR/GqJs85keBEGUkaNMLSEIFbS6ThcVwLnieEMC4dk5ByS0eASOM2uQjutn7HFiKsW5PA
MGkRIF5FASpBiGE5isdHck4ShkJrt2QM9jBFVh6dLOwGSzGE6tgnjsFgIvnyaJgoB9AFpCISBLvT
47/bU+75p50CdxqcKmz22kwUz+msGfiqGSw5o5le4EIcj2buEk15Lh3uAMn5xUQgutlcjkwSA60E
1CKVkNklZpZR8PhvfgJYedj+yB/zw7mClN47hDn94CHO3tfjwTXrFnEgVyiB5ZsKcJDGQHGW+VQs
WvhA1Qk1P/yzPdwDYMYF1n4B9A1NFhG4VIcezvnp+/Y+f++JJoJQVdRKqK9sGseyQVIrNoEFIvVF
VnBESAi30Qq0lwUGgiu4yB6nyqaRhCY2lnEu2amUgJfN1gLUpFzgbtzU9bJM2hrBkLt16lpAhYBP
punMrbJoaEFwU9141RpWjpuzAlBdkoY3BLuoHF9pD5xp5lBOPrva4ntvCtBVM4G6G7yNPWFJe8Ep
/+9Lfrh/9Z5hc7c7/NALgUAWJORrq+T05bk2e+jIB49jhin64BHYg33wGIYf8Ju+EIru1vaOKcSO
Qlurpy7YjJWfHSI+TQi2efSSjSIt+CiSatGklDWYtKrhpsZMUKcuIZkhvCks06FOhJgO5GF8DOcD
3w7kYacL/HtgAs/SPxUzcYO3pwc1Tc9tWyglrEoqhurClFzdHabe/Hh+2r/8sNnVZXOo+tfShPzO
71/Oxe7m+079OJ5gN64FiymNAgZRPAz0gbhQUZza5vXCZbQIqkU7fv7P7l6PRfW2fHd/IXvxdeNf
D6BEkY/COLIFQXCFSwCxWUATVjjtaUpDDY8Fq0ztsUhSxUSWPx5Pr57M738ejvvjj9eLXrBCmPTf
6w3Dd3vatqftfp/vPTXC7W0gRCAeJ7KOyReC2mtZaIAowz4w6jm/sACRURNGtMsGNIgNy69ZIlWn
JbF9EVzEYuWEO1roDyajq3UpsyrC2H77aul1xA1FIt52xdXW9Hy8P+6N+YUFBSXsuka86XtKx7Y/
3v/yHsqJ0ww1XEDDyyzw9TGtqGvfNR7UtyMTVRLzr5mPOtmYCtEloxr3Eb4b9zpFUjv+qtihOiix
dEvRM0REZ92F0IJsBGzLph2NRFPr0In1pKNQOrWVSZB90xlO26sKAPUN/OP0hgXsJgnDto3BHGlH
aZc2SuLFRPPtcw5Vgoc53r+oMFugr5vdQ/7p/Pus3Jr3M98/3ewO348ewDI16w/K6xjWqFWdCdCp
c1jnfkat2FyrReFFLZqUhAzgrqTqUMfeK+xbyTBEpPYjGiMIYw4buEdrPwR2xEPVR4lAGxpjafM2
lUBAQwJC1VirPt//3D2BZDVRN99efnzf/dZXoyp82U8bceOiGGb+eNS9IqCGhmewCOj4rPyGfbeK
BDT52h7EOAimMUosw9uhqjpNHA/6nbomf/cb50sWU2CoCbAa3OJc0LfPxKV0hlJp+P0LK47CTXNv
0mgElafurcYRwePBet3ZPxTS/u162FU78z+P1uv2yMK+jq650wa625UJDULSLYM3kwEe3w27hcTt
7aD3psiwWwR2scM3NFYi43GniMD9Qa+7IQ5j1ikQicnnUf+2uxIfD3ows1kc+h0zdxWLyMoI5BW9
MMvuHi1XC9HRhKCUoZnFeQkKg94f2qxDhPiuR94YSpmwwV3XultSBNaxLgzT8HwoYU6vqE4YBZHi
zfVsWYh0OXUv4ObirSNJKygWbrvEOO1wqJjakQV8adv8uvilXHkT8O5h9/zrg3fePuUfPOx/TGL9
COQ66gYCwPOkpNqP7it2LITsmv3EiiqSDLC7H9tQ6LXdWQXcxfEx18cEAHv+6ccn6Ij3fy+/8m/H
3++v3X182Z93T7CXCdPI3EuogSpjL7Ac+zUQgd/VtkMKt0gYz2Y0mtmnTZ62h+dCFXQ+n3bfXs55
Ww+hTjykTDoaCXBbom5lf/z3Y3lf+nDdVLVGebjKwPjXgMeo724IpO7WjhBQCKjbkwAJhx0UIghD
YO1gz1H/drB+Q2A06BBAuLsXiOLPnb24CDT9YVvorqsWn8uMDmK3AI0GzssmMkOqE8rXAuTolikP
K2x3l4X9ADw1ztMrovLGrkKKrWJL7YnrYtHSRgW/Att4YmOJ9chKpqGdLGxkcNB2siSiaNbs4DQV
sPQo7pgeth727/odM+xLPBxMem4B4kL+Vy4MYocBBKlMAYL6MUO0w83MfDnv4F7yJSKc3A67tG0I
Zox16QaRrctyKepbcWwZY3hzrihjrSmif1OeEc77446GlAzM5CrDMnGLFV3Co964YzrEhoHMBJb1
oKvXHa1wJLp05YIORj3qFvhaWGQG/vFNGSr42/XgN0X6DfM1RdCggXeu9H6XX1MCg7cEhr3eGwKD
QafAeNh/S6CrhnK2R13z5ePh3e3vbn6vI5BJGF03N+2PsuEo6BAIZYKEjLvMWvBhRx/tp2fx/uEC
26p4771TAqrIh0IUQKZxgolVfo3tCKA8ClUo6aOJML13RYRVZ33hUoeHzLJlZn7tDBhEKxoRlBgk
VVmvRem3KT3diVyI9r3NhTl2MQt0x5HpWJuncdr1jc8ynGy4dmYLFBEhLuaxSWQ0SWIDyQLxb5LE
rZENXlQinacusVsA/lo4SEXjvrM8XCGEeP3h3ch7F+xO+Qr+vbcch4GUErqi45dvz6/P5/zRdoJe
CQPcTqaxIC3zakvGKVihdR9TSZS5X9Xla8z0K5NKpuaC/y3Udd0FNEtyTMNNpKGUWrM5pnrPqzPl
jsqWsALiS5kmT0z5QJ9Sg5Hx+UaoXMXOgZBzR93+0sFI0IrGFjpm3EJFzJe86q7CnW6baqDSghXl
53+Pp1+7w4+2GUVEVlOiibWyLznCi0JSOzVXFEAayB7OoGJwB8Vqs4xdGlHtnAhk1dm01vNSreqL
l2sag081tts8Q/4SRZiAR4hT6UhNAzHX9YJqmHLaxZwlxFUrKxq130Yn3HbeIjYqWTVeUON+UTWE
5mbvMyJ4g0K5ynNtEGUaRSS82gb/y1vuTueX7d4T+UndpxmZCIal8GwpHF1b2hK/oLmAhmXegT5I
JdERspRGYFjfd/uzRZlalShQviICj4IXxmosWbJImHVNRCkB2xQZQ/iUvEMu6OTSBHdwZXdhxNQ1
pc1RFOwyTbjVNcolmoZEOMtFSMIog8v2G7avmkzeKq1MBhW2M4eNiLb9arCDFfKZlkkUmMmn6rtI
E7OcQ8CgmOku7/Rc7fcNm3POD5L207hpQv2ZfZUtQxRlk96gb8869QkG87TfQYV44JjKtUM7FNoz
tNYDO0wJEZ86/YpPIRLbVSPwv0PrFXS3w9GpiuerLIA9FVBkEoet2fp6FAra3RxP3vft7uT99yV/
yRvZJKqaIq3a2QgORdbyfXoM8c7589lSLV9I15EHsFV+uLNNxcwu3QodAzBHLEG+ufWt5jXx0dVL
nmCZPmk30VcZsCdthSQqCmmfsFiY/u2jEulfb8VUva3QWciV6aAhBLAsFHrGZsENFN1McSvoDpd6
+H7anvKHjwVcv0CBBzOpQtCkzblWLeUmA4lqPPzj4cfeiib8OJqFxLoP6W6hzGGomyhK5KcdxKWH
N1prHs2VeLqjtVRMq+mtwiydMaQSWwOq7UYigU3CikbTOPJN4iXHzCQKhtX8N8qjkJqEZSiaFNqo
aSr137NwgBE3KALHxncSmGZ3JWUwi9qOTGbTiJhVKULGlNKhkS1YscqAaeHOqX+Fm9P9S34+Hs8/
neOvCmAKs2A0XpKK7rw2yCiRLVGgZfORTTSbYmHeHZqsTK5xYkvlKuWmmA16w3WzwWlgUXgJ/zR7
IRLAK8U6VvNTxsxbdjCgxiVA7cm/pmAif1uTbAC36dUUPnfavEAuUyMSfMjPWq6LBjKb8a1M5zr/
VM+5YCff73ng6KFW9m13fm+AfrVpIYkBsxmlukpzxPmGEUcus0ijGWFOb11e62RDMFRHcIwc94la
aVh1b4kAXETtKCdf9rsnCHCPu/2rd7iEJPeeqcTRIXXhkv5nx4mXSjawH0vOed9RpkDyAtnxtZls
ytX0Dgeaw2H+pN/vq7nTZ+pCJgAVuf2MEvmIS4JVJl0C7sixZ8FD15004gnFsR2UTEcj29uvIo+h
oSgWk7vfjqGcOW7BCAE3ZT+QJkDWq1ff7jEIwJQjO7gDiC0Io475GiyaWZNX5gS259iWn6IYMo51
7S4k57VBxQfPQDK5osIF8yrBSX9w5xRQUTRL1llCBLFdzAoq7hqjxyl2GS2sdt+5YmXjzZgW+pK5
eq732CIVFxS1oSv6koQxpnLT9Io8VucMnU4OlG44OIRJRLGxRgpKFjOqXqjM4iizPSHww8GiVlfZ
U8vA2hZ2hReT4WTQM10oA9xnN50NCQGnB9Q2dMmkP76r9Sg+i2a1C//F3SSkGlotOjWsorY5PPX4
1PhyPbPvTsSAtk+Q5PFXfvASdTRkiUOyvStUh5b7/PnZU7bx7nA8fPy5fTxtH3bHRhgq8HoFoONv
z8d9fs7r4vfb08NzfTT9dMo/wn7vU7+vVSNkQjXgg0wUv0JLUhJMxcpqvqns9xu1vI2WNEuiiYbH
1KsFom2iebhu0STz23KYtmiw3yWhKVKRLseau+dHbyZvfABgMCalwu+2N99ufrxX6d5F6vg3R+p4
QgW7HTmizApCQEjENVNktT14u+plijG1K8dz0MD37WY9p9y6OniozxHn5kd5vqfOC7XoB+QmNlU0
JDYRNksrSgGHDapKioRdgEmcCt88RQNirF9tG3qqr+KMJFE30doFSMEQTCFZk6YSOovfxo1TMued
HuAs935epaHElh0YFX4E83458jeTqf32lYIEm3/6eTy82p4G8Hkjs/6yy3x6OTuzj2jE0+vBcfqc
n/bqwsiwIV0ShiVVtw5L/dRTp2dcoHTt5AqcEBJl6y/93mDULbP58nk8MUX+N96oph9NqhQuYt3c
YNTr4G++AGAy+WRZVlpPx4Vs38irIaY3cXtPNUOMmO8IRAwx2EKvKBB/bm8netNXTmjzA1cuYWm/
t+hbSy7hhyP18ioTsEmv3y2CxWjc/21DIeqRgraC1GdGJ73RoEmEn5d+1yunYGA5GeDPfQduKUQ4
ShZTv0sAUy4Gjvlx3lQVM7sgm0Y6cUUBbw6tGn81oeIAnHIpdJUJF2+KrOWbIhFZSeuTSm3x6H+b
oHjzK7QtR0kqX6MYN7QFHWqJHceYpYDKVZiyDgGO+/0eR36HyFKs12uEnJ2A5S0kxVroqCgZihBo
UPemZgx9G9WnFiqOpwmy0GeBDhZrsoFGDHLGrJyUhiFh+l3zlVe89kTYxhLUJysalS+bmkwAIQb8
rStsZfI2JVYogTVhq1Tl74YGuKqV4QCw42TqYk1RGNp4kkYzklg1hS2Q77tOeq9S/vSuW0A5IRxH
3UIyTabxLEGB3dfVYSR1vFi/RIc4xfMyOLiXHNVfmZc0jgVfJM1YlJZB9gIH8c/taXuvLtFar56W
GghZyuyCGbQn+CuNZrg+FKrn7OX7usSSgHw5sW26vkvRyeC213TIF3LxUNbh8CuRKMnUIZ74MrJX
QdaSRI2/SVNeMsB2QkkApdDP/hLvUhWOEw3eqXvnu0nG5cZ4DV29CQWy9YlhsQz1roY8s0CzK6Q0
kIVKRknqG1pGzRsxBlsDGP/Qcre22p7vfz4cf3gK6TdwucRzP7Y+vl/BpiryYyMrL1o2XmNVW0vz
DzL40nHJlQzvxiPH0RBAe9cxn4ijDW/nHQVlBjrsUb3v++PT02uRkm4eMBuJMurZk+1Z90zf9824
OpFvEGSToKcsXQjjkUkq/iiGhZQxPDfJ0ZL6evKqohlJrgWh+HMeJm3ZLEWCgIIH1Xyrn+g5SgnL
/r+xa2lSHEfCf4WYy+4cZgrb2JjDHuQH4MGvtmyg+uKgq9hqYquKCqBipv/9ZsrGSJZk6tAVzZep
p1NSSspMlcF8K5DrwjDdHkKCfiagTxnjPmL1kZlhi0iyICLQtIsLwwIba7WskA0kwAtOlXTmohkJ
Cw8CUojOWpqTVIWVSXe+ki5YcJLW976zkPEVOxaTn3ZNv/aXMOWxcdolIq8vx9Ph8vPtLKRjkVq8
qBTTI5j7c27W7kDCZ7qEscticIhe3kKiyLAtu58TgI6lALd9MAmmtiNheCQs7EQAhl3/qlS6WyAV
FG9DzEYUHYZQIgIpUyhMEZS8oDmwjqPFsk+KIt6QnEFFRsla8BhCuMEEo3P0rof1xusxolvRzJZA
xxpL2MzZipgwPFsg5w+CGJZlQZb1PgZ8/LaPmAB0H5/u38/H0xmW8cOHWgpomFJe7Wp+U/TZg12v
oSPYGoKlSsGumGQ8oIajKmGOZgCKKi1i23BpIhOi0p3KaJxMbSWq5nVVqDtWopYSVZY2U+SQkK3h
GDOZQBPqT6aJok9AEhzXITJh41pT1wiUhHjq2iVVkhxzupx31+R4bMtmDbWcXNOxSxFF/8N85NrT
iYYwUzQHpl7XZgugMFEwywOmO6nV3Y4FJ7w7LJ4mpAtXzlK8e2usEnavr7vzv84j44+/DzCCfnyK
GpAhmzMfzk+q82nYgYLoJ2rz57f982Gn0KnRYrTm1of14Xl/HM2PpyZk5tXQooHJ8+7jIqjITXqv
dCfCmUwD54m6R9pEm2++xnW+YfDv0DezmcZnsk2fR2SATAmxzYlzn0W988L7q6K2xtZQFWiJB/9D
vfA9KzRnz10VpoY1GeBItt4ANcj9Aeoy3EZVUmdFlKX32RZhEqXRUI9vXXeAnK3hgyoHQYFXJrx4
cVpWgKdfoO+VGi0M6QUzqLzLYA5wkO9lqAmr2DBA68twdZdBe4naMMFUHEnGWxJPCIIzxEHnhjNP
orscxVCLYa9XEGj0EEtR0aF+Lx/zZaYRnYbjexaXhejh3Ux7h5fDBTa1zcTinY6756cdM6a7xqm5
TTLB2uO2CGvvutltHQLY4rF/Hs1Px/fL/v15lLDYpWIGeM6SgiINSgDv7AAEWq7H5mzWA3PXnW5V
2C0CDwaL+M9vD5/n08Pr4cfDzyYq0cN/22B0D+en+m13eP/z7ek3PhsS5xQ2ObE3FbNv8UTC8bYM
/k4d37ENkeZvzYkhbHsAXBRVGsD/zZk9ntSTmTFIHvfISWkZpgitQ2o0V749cDuzRLAM0KluslWj
X++6y/MOU/zz54/Du9B56bZ0mtvq3sdn8+TEGf3YnTEQGYxBebFivbmeGqITzg3t6qe6Mr9xZTQQ
xdGrgkXYk6oGq3lDKw4mayWc43GH3LaKesq5kfVtieZnTXq1xUnHFIhDvT96Xvf/+MePKBr92zN9
83dN/yGtpqtHNLGRawqKwNTVpSzd7ZY3kuiWt4mjgev1uk9hf71q3sfZctwHFXxe6UuVuNlvLk67
j5+HJ+Vd89xTWn+w6sKG0y9vcb7f8X5/9Hw4f2AYqeagR9Zy1wuiOrBMAjJw6MYs87hkbciAz/dn
Tn3GO7QuQt81OF8TAp2xjsjp6efhsn/CYMlcupRX69OgO27goNxPRGC5CXh7TIQKskki/o4BQRp+
q8LUF88XW0LTKtU5KtAzSjFoJndTBmASbUH7ApJUOxnsSmYkIRvYFlzbKNSp9R9rjkTVaz6yqQ2X
r5HeJGWbVTyvYMqtReNQ1sw8tuo48vpVkbpGrCjMWJHGRoEVV+ZkraW2Z8eV4dj2WNP9TYW7kx5K
VFsPZCSBAbsAbVk+nZiWMUw2h8mOpoqwEjmu2+84XLR0Pr54xVxRPyaU6hzsGxZ0/guTcIgFNDot
mR2oa08QBQ7QQzwtFwZmmpnbe318ZbvT14zN2mp6k3pub/x4htNHyCaUxjGwQcm5tlhs5bzI0lL/
lZPItTSBia5jhBK9lNAFiclWP1oo9Xsn7F1MSeVgJf5sWmNUYr/fWBJH9sQ2NF3YBoJ6kzFmOJNI
uVWua+ibjWRzmDzQabCxsSzT1VQVV+xtvz5oyDAwdFC8XF3bFXYWCK+yYmGYhv7bwYxOCr1opIlp
O1pqkYQDkwdQZ84w1danXgYDMl1iTMUBiX5M5rr9YCNGdKKOptYOh9yPpHktpYY11aVpqIZiMpxZ
rn7+nDnS/NnuQi1t5fUWMWxi80NjOvC9Gd2caKrELqLc7VgcQ1dUGkA0SyN/HXlKD8FmnSSuuZUE
fb01TdkgBr4KYUq3ZqVDZRpfLcm0jUOOim7NR9mn6GP/3iphVDJqa4yfcvQplBJifSQVEp07ONWx
0fJVOgmeGe5fX3fv++PnmeUlOXA1idERZM5pSWx3QdJgEwXlUirrMSVJ5MPYTbNC1fXMNUaOLo5w
Vi6UbVwezxdUoS+n4+srqM2Byg8qXKKlqc+pqx1K8zhC14OsXyCjFllW1ssKt0Sa6mbXrIUuqG5o
V9PWYsp/3Z3PanctJiRX1QmT3LyMyvJx9LR7Hx3fX3+NfuxHn7ht/fuA/keHM8YofuaYlRaQWEBf
9+PL5hV1BG7X+/zHKbOiuXwS8m3hWh9AgecqNsBYquNeC7mRksyJJ/bslTgvwtDPEjUxooEJu34l
LcAtiZKyzGHZHO/VRBoExXimp9m2mvZXlTQRMzhJWH6+wafsgt7fIi0vo+B3USQAEfMF4Gpl2tkW
w9w6F3/nfDK0NsPDSoGrXOJZXULQn0IgtIUIVqlMQKK8DFeiOGyILxpUILjySuJphYDFkkc3RM3H
T5i1UD/PkGlqmiTbnPRGNihPdYG2YyE/mqK33Ytoq8+XG/gufwnYDBe/yKRGL3P4y+IMcnkrL03E
yY94yKjrF5hINbcXLDH1Ck3rIy+BlGIVV7i+kY0votnaNozeeA6FAz0GpTPfGJv9cb923DHf4KtL
8w4Pb44nqbk+KX1tc1awH9BE+GIyAp9b9+IB0osydg17rKXDP5UHIFa7cQ6WowI2yejUHCuTtSZf
sM5AwotwOiNOcVJ88puECEuqpgphEjmmtl1ANR0ttYwWsZZIqrCgG6IMd8q6NMrsvvjH4SIr2dMP
ItxfR+Mw6I9X/5E9ZaH/wkuMXlBCd60zfYNCqv6Ii93zy/6iMtrHZAvSP9xsH31B92q2LArv55Vm
zSswLVBvMb6kDDeP2xE/lkk09Ksi4r2PgWJh5m89QJG5pc/cUmf+lxiSHH5q3/mA9InHfO1vyYsw
gt6f094DKB3MDIjUFzVXFhZYNUrnmfLVmS77fmt5Et9iuQCu3WpDVcajbrAy562UgHtRKAV+DbHI
En3Kb1WmCYqIQW316RrqpEdupJlFM3sI1gETW0lqQV2dOc5YkK2/sjji/Za/AxMv2M1vIUkVzKXf
adz5PwUZfZiT8gH2q8paAE1InlBIISDrPgv+DsI5qeKSHZTkqEy69lhFjzK0RaPQpt8O56Pr2rM/
jO5yJy2vbbkZcyKkGwKMWGy6qPjn/efzkb3rITXrFi+YB1bsEpF/l1IcOKAv6aQRSHmpGgk3gjy8
yyTn67CsYE6LPQVUsz68jS6S3GIdi2uO2FrOC3pARud62nKQlMeVluyF+qSenjSQymfNVtsSbHXf
ZZlLMvQt3U70peBTp+qsqv7IamavDXzTsBdIrFmIaF/q0l4O+HsthP9miNqyA0nNQ0DKKC9ADoSc
AznrYCDvoC6V7txx5q+4jNlPyIZfvdC0kW8WrdIiF45H4SdIf72gtF4VnjpoEMdD81WiirZPE6/3
LRGB2ew6n6iCaUdiCvyNwQA04a0ZmQ1hTV7NoiN0rJ9rRTbDEDe6YUdVy0K+O10OLJZU+etjL8Sh
K8oIX4nrIr+JT4hlRXrjUZaY0fkdDpJEC3KPpyRFdIcnIb6aQ1hFOg7xnWB8yCEmXiis6s3STStv
KFuaxVA32rxKxmV+Ux0hE2Zs0JWhkvggUadGgv70gy7u9UrFzF7uMMHgucMRzjUFNTPQ7gK7jlG8
e3/53L3s5bf2msX/9uM6dpQrMJCvS3g9sYTXTwXa1JqqJxaBaWqrJi6eBdQEbRmu5kC+x2R/hekL
tXU1Txb1mIyvMH2l4o71FabJV5i+0gUaM8ke0+w+08z6Qk4ze/yVnL7QT7PJF+rkTvX9BCoySnnt
3pNFwxwQRiAamgwI9aNIHGLXMo1+fleCebe61l2O+02273I4dzmmdzlmdzmM+40xJpre7Rjsfl+u
ssitC23OjFxpcq3Kucu9IQ5atBgylosukc0xWoN8UbHCqCOvo5+7p//1wv81lt4rjDmlPryZg2Yb
gmLBDuNV0X5IET+2hid8qycrUGR85dszuATOI7wGS/K6eymSfz03z3Hj1ZkL7Z8+T4fLL/kOiNu2
cL6KDYZxGtDFS+nu2LL4JCcedFnZRH6V88D7F3ygUeOl3nLREHq9ko1G/dOvj8vxpTHSkmvPwltz
fvbN73oJGooEphXvqduCSTBRYLaE0SUxVKDJ+yfdYJs3qGzhzTIq4jzL5EoEfPSUFvNYDB26lAjw
RZQ4xhEI01LCSUhr23Wk7sCYw3I7EZVbVIZEzrfw5a5bLcl3/iS/a2AvYMm1pyN/SdD9MPLlmhS+
ZQrbjK4yijPF+PDjtDv9Gp2On5fD+14QEb/2/agUesbng4/FkdcVdj1pAQzPxcRaM1RqC3utPAKF
twjFV41zlMH/A8wERdm9hAAA

--Multipart=_Wed__22_Sep_2004_01_35_16_+0200_fil8Jbh+_6drhF_K--
