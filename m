Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131622AbQLFNVT>; Wed, 6 Dec 2000 08:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131637AbQLFNVJ>; Wed, 6 Dec 2000 08:21:09 -0500
Received: from ns.caldera.de ([212.34.180.1]:62993 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S131622AbQLFNVA>;
	Wed, 6 Dec 2000 08:21:00 -0500
Date: Wed, 6 Dec 2000 13:50:19 +0100
From: Olaf Kirch <okir@caldera.de>
To: linux-kernel@vger.kernel.org
Cc: security-audit@ferret.lmh.ox.ac.uk
Subject: Traceroute without s bit
Message-ID: <20001206135019.L9533@monad.caldera.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

I wrote a small traceroute last night that works mostly like the
LBL one, except it doesn't need an s bit anymore :)

Since the source code is small, I'm attaching it to this mail.
Note that it requires a 2.4 linux kernel and possibly a recent 
glibc (not sure of that).

Most of the features it uses are standard BSD stack ones, except
for the use of IP-level control messages to obtain the ICMP error
codes and the error's time stamp.

There are three things that puzzle me, however:

 1.	When I want to include IP options into an outgoing packet,
	I'm expected to include a struct ip_options in the IP_RETOPTS
	control message. However, this struct is included in
	#ifdef __KERNEL__/#endif in 2.4.0-t10 (on which I'm compiling
	right now). Normally this doesn't deter me, but in this case
	some of the fields look sort of fishy to me.

	My question is, do we really want to allow users to hand
	an arbitrary, unchecked struct ip_options to the kernel?
	Wouldn't raw options be a better choice?

 2.	There's another issue with ip_cmsg_send in ip_sockglue.c;
	it allows any user to specify PKTINFO data in a control
	messages. As far as I can tell, by looking at udp.c,
	this lets any user set arbitrary IP source addresses
	on outgoing UDP packets. Yikes.

 3.	There seems to be a bug somewhere in the handling of poll().
	If you observe the traceroute process with strace, you'll
	notice that it starts spinning madly after receiving the
	first bunch of packets (those with ttl 1).

	13:43:02 poll([{fd=4, events=POLLERR}], 1, 5) = 0
	13:43:02 poll([{fd=4, events=POLLERR}], 1, 5) = 0
	13:43:02 poll([{fd=4, events=POLLERR}], 1, 5) = 0
	13:43:02 poll([{fd=4, events=POLLERR}], 1, 5) = 0
	...

	I.e. the poll call returns as if it had timed out, but it
	hasn't.

Any input from network kernel hackers would be greatly appreciated!

Cheers,
Olaf
-- 
Olaf Kirch         |  --- o --- Nous sommes du soleil we love when we play
okir@monad.swb.de  |    / | \   sol.dhoop.naytheet.ah kin.ir.samse.qurax
okir@caldera.de    +-------------------- Why Not?! -----------------------
         UNIX, n.: Spanish manufacturer of fire extinguishers.            

--PNTmBPCT7hxwcZjr
Content-Type: application/x-gunzip
Content-Disposition: attachment; filename="traceroute.tar.gz"
Content-Transfer-Encoding: base64

H4sIAMYwLjoAA+xb63PbRpLPV+KvGDNrhZQoStTLOcl2VpYomxtZ5JFUki2tigUBQxJrEIDx
kKzdyv9+v+4ZAAOSspOrrO/DhWWZwDx6unv6PcM0th0Zh1kqd97bH+TU8+U3f/Rnt7O7e7S7
+80uPp2Dg8o3fQ729r7ZfbHX2T/YO+h08NzZP9w//Ebs/uGYrPlkSWrHQnwTfvDiz4+TcfI1
EPq6n7Oz/mA8qr0S2zPr7OLy9C0//2z7vtg+n7wZnU9G/evhWVf8paGGNq3L82LczOq/+Rs9
pYUYtUORpZ6ftEPLApTjWtllWY4v7UC4XpLy07FVixdie2pMxzoEsmlZXoCdAQCj06rpRrGd
iO2FODw8rEw9747G573hTpbEO3deYFll53EBuEaUNPGq6WiK7VD85a9F///1jnzdT8mhnWH3
9Px99z+wxpf0/2j/Ra7/L/ZfHJH+wyj8qf9f42ON514i8M8WyYI0y9CnWEY+XhYySEU6t1Px
EMYfEvHgpXP0W7H8mHmxF8xorkwzzxV3Xtq2rF4qolim6aNYZM4cYHxPJiIMxFTaaRbj2QvS
OHQzR7p4BGwpLr0g+yT22gfWBxkH0m8JmUTS8YDSIw+w7zzfA8g0FOFdamNa7+z9QMg4DmMA
mYbxwk69MLDuPVv0BsIJaQ1fLGSS2DOZtAVT+uCBxip2SRp7Tiq8NLGiME71Qi3RE7MMk8Xx
NqxRbyoew0zM7XspkmwGgLRY0hJ32YwYhYl4kcHcDhTH6C11WiKCoUuktbA9wkWAiy9J1P7q
2L4rY7vtyteWVav1fXsqfvRiZ94SR+JcOmIPmvGfN0aG/hs2vPOHrvEF/T866BT+/8VBZx/j
D/YPd//U/6/xaY/fifHw9Kw77F+Pu6Ij6ix9cnEnYxbButW+PhNHVnv0Tlydvu8aPlX8Yxuq
5LF1gLXgpsh2Psg0ESmCSdLVQKZkNcQ8TFKGMfr7VX8w6o2sdmBb7TdD0+DUxU0dQC+Coajf
0nP9HwgOpl6cpJM09et5K1z/wv40mYdRUrZFgpSwLm6t9l1stVNPbH3PC9TRyyOAZ2hMeBCp
t5BYuGz6KIKPmYxhrgBHrAF0g0EzMbNT+WA/8rw6k6ZQryvqfRlQFzhnu0wz4pKzYW8w7vWv
rHbPpJgeYVKf4J/txGFCpnl8NtiBTcuZGbLN9GILSBCTbTHz7mXAmLQFzC9FYN6/pAKMiVEc
pqET+t8lTDPN8TFDNMbjyyYYLH3XsgMX1imVi4iWDwWstuOlwtaGdtx73510fznrds+752Q1
I5g/KaZxuBDShiHVTEHQF8Il0MKRnc4JEj0zasyMPvNhBMcjQQisu/IjcAWRHdsLmULwPIV5
gFcB8w4KbNeNyRiHU+qxXGV/2eJrstm8A4RUIBwgfgf8Qt8PHwD8TrmRBGzJgYArd+S+FM/h
w0iSQ+XqeFMbB7s0z5VTO/PTZlv8ZMePnqLOMiDlEOCU4Hb+mQUO40WOkoe235BUWyV9GjnY
FNdwaIYXg7uDODDs9+NrLINw2PXuPTezfUOnogQ8HQysU9f1mB++CCN2TAKMOLba40G++Egq
cPXzMPguFRexPSM3VWefrZiXSt9n3yzjhXQ9O9VCGSciCFMLiE71LJPoh7lkcXyEHEGEvJSE
LAwBdwbuxxBOja8FfNEHetoasZ4g/a6XGm6NyOdPKVxg5j3QVkBGiUlkp4HpudoMFtGOCWgG
QLkMjpkSU89CkiAW5oFIwix2FG20mYpjuaCicRai2dLksTQozrBIat5jtIZcciKdo2mmtjzR
hMAA9IY5XqJtXYWpuJfxI+39NEOYcycdG89iQQKXs5vDDKRJ9p0PCaniaxFTE+lkMYVDMaIL
bLfJiAUYkZtHg6GEKJq9RbYQQcb2HdLLgyo2ydIhUngnSS5kLv7i3vYzSaq5v2suF1jnIckH
QLAxWtiRobCSN4q1ibQ5UeIC0hBa5qq0MMFFwJ4M+RLm1+cDwUqvdZ6GiDuKrNYgD362xc+0
EHTapVUQ3DEIJis3si00q4CQhjEmQJYAMvQtYo7YFh3mONs4NMC+ss7HklSMRyYqiAVnYjuY
SXqjHVVW2jKxJj601mFM/LujINdnWfVcKJk3feTYGY2Pim1Ad24ntOfOXLproYsGk6gDXTuK
JKIbEm0y+1ivWdlTDnh5S/cP9g9OOMQl25Ql2mhFpPXOnMliCtnbuN50CgYEWibM7SNPCC9b
mBtIwvgxYkM5kvG955DT6SPpJncziBFpgFQ0KkDimrVCvSUWMbhzJBqw4MAYAqOmfS8ac4/1
jPUtYqqgWFIpK9gfxoitCVciJAlBOtaksN/BRpfrQQKKoB6D7yi0jzCRYj2TqAcQBY2zfrax
AxAG2kF6x18YuAkmolEWwqbsxKe0Im2A1xtYJZZZ4Htw8SFlAUsSAfuQqOSCWe4tkEOQ1bW1
V1FZWpAsPHJaGG37VcGGs2Bn6vuUSJH0ljtGMq2Ib4t38IyYXupBQK8Wa8OCKAKmAWJCbd+I
NcV0ymTYoZKPJukyGfYRDION0bEUCYO2noXdqeCbQ37K3pigh4Vo+WEILTOMo8xNOf3TZrzU
dTv5QNZzrXsja469jF0VVxXRhp2Y9j2yyZ61VcpcunASWE+lhw+2CiHYE3LWWoYtdlBxrZZa
W0cbNgmR5PBh6s2yWMUFZBVUpMWvhj/TVCmhYnx0bk2gyL8ztEJyAO5R6vhr1O2K08tRn0Pa
iFjU+L7Z4jc4N3jZlBrU2NPr8bv+0DoLoTJRysrnhIsFffteIItggwyxqw0elM+beRSKXL65
XBJeKzRrfS3xAB+WAlEEWT+BP3+znfAO7kzHIzw3F3suUWBxNBHzJE2VjBGYJRNvFpTgFJ7R
IxCZg5qzJmcyosyxV3Pw9v+zul/+WZ//O3/oGpT/v3gy/987enFY5P/7XAtA5/6LP/P/r/HZ
2bTEpmlZlrwNmyc3lIk2RpyqwW6G5N2QkPhyBssvGAorrR5C2lrU9ISq6eXjzlZUs/VZ3cSc
Hcv61gscP3OleJk8JjspgoqkPX+91JyE7GtX2iOkgaut7LZWWjMvrDbCLMLYpTteNPGcRfRE
Z1Btt+PI3qGearOM42AJfJK6yytmgYfWatsKsnV1zjKvW9bOJntOxWb2Quy44B7BOWIVfKrI
JvA/+3uTtDaZZPt7J9WO71X79yfGkj5t4A5QhiPPeHHrW0wgy//+9Jd3/cGoVts7PDQbB8P+
m+6odmS2vT0dd38+/fuo9l+WlaRx5qgo5N90nJPWalP3xKplAZlwrgenNcrEl9vgn+9pILEB
qNYowKJAZXnclFzPiWXVwBPEl/demCWIn7lOhSG5QwZfahoXL5hQaw3h4T0/0Wzdp8IUYCrw
0W0kYxOsTqGkOwF3hJQnlRGEI6IXpmNCL+u7maQ1/TlC2vXLWHcjOECAj2g8Fps1rIttc3VX
hQWaVnT9WqsxBTfFztyeWL+e0DZAvR1R7kaNEsEbvasYpAcssZbSdAxsCd9WT+sH8poTXV0T
r8Rhy6ppTCaxTCkmROs+t+aZKjXsrgdH8fmE93WS151KElh4O0cQiSR2JpzPvBJHBzAqJ0tU
5mx1gbraZt1f4Sv1UqZ6sroAdekFVL5UGUIKxEOQ/pTosYQjTJoEiKeT0Ed8jeklbkW/GwYp
lVfQ2xtMBu/H1+e90dnkvH81Xh0cV4EsEUgjdMXhxlC/J3Y10EMNpIt+4klNxZo3R4eH+0dP
wNDhKFXEXomDNdvIgLxIx4s3B7tPACqGTBD5KRrzcfeh59ZITCek+g16bZ6sdn5CVtQwrMxm
s8o+GkN2Y5HMGmhYB4L0smGitQYEjYEKEoiWqBiLzXUgWSW/hJYXLKHeEuuxUHCZV2rSOmZk
dOxF+An5CdYG3ZT70EFUwK12PHNaWuo38XLftP69ZEuDE22iHTKJD3N4e9FoONiXmUyxeEPB
oMktUb+YHs+OF8dBdJwePxx/PB7Wm03x7JXY7jTJgtaSBy+Fe2846tVBziC+u/jumKzAZzXg
hEbcxdL+QGjoiVM1sbBJCikkmI063uotyk2AWEt0WgI+qrkWyEwDsVPbb9R19rg941jnkUrC
WUQKL926mo80r1Hoi3j9yvRuTRqQg6ICKNKkx7zylxgAngFP0tNGjqGhr2JLFPCbCiIMZhYj
C+f5RefW1lqCFoogw6j+fqYE5ZZUjFZn7ehIjTZsY74iH8dUliQT8sSiaQkG9tOAMu6PDCC7
n8H7QYFYdj45oPywZ4kJR+uBfTSBlT4rB0Ytj1VQnd29g/WwhmulbPiklBUWfpnjujLC0JR6
d3jGr/D06CfhIujIfl+9Yv0W22JPaVvFQhc7pOoaMLWzdF5XinyjIGx1btk912p635hPvwrp
J7Ky0rNipQ7Ja4mWVbhS8cqEfHtiVdUgH9YSG7lrZtEvBV9NKFUdipdLuKJuyvZ1CuOJaCmG
LeKxbESfZwhW4pmqtAQ0j2veaP9HUG9VTEirhHpSWZ+5i3iyB1vr2XSylpeEKIyk+lpDOSsR
iJeiZDXet7aaBfdvglsa9elgF2qOGRt43p82T1aA9wZFZYUWMAx9PnhEhyFUNjFrjopoA7M8
SsOqBZGgpvChDE2zrl49LXmeiMbzpNki/jG/wBp+uXssy0+ag+UGUr4zCdLQbhQ7SQNytrYM
3jQNl5I7CO1GkatN3Vo0dY14tFYG/uFDKz+5PSlnUQy7qeirOrFFSwSsPZgIRtDMxtX15WUz
B6rMBPVuiUMeuZCLRKYNYMAWh9ANp/Ta5Em84QvaypZQ3GUObRlM5vaXeXsRLYvF1hbPgVgw
yUzl4rYt7+nKCCAN+peX3eHwxOibumqF7decKSknwu95DiReMv7KXxRBEB6aT4zf2BBLAHKO
KhglWyrDlK0hecYWKfYsir2ABSAcmIGQ0KF0JB0xkxOMtJCWN3aUYK+ozkJpjGINGwlaBXrT
jjWHNnIOae9I13yQpUomtAjeSlMBf9os0AZaV9hmP0RHSE6NLjzRKCVDfDWJaoeJlHTgQqc8
4kFSqReTxSYfIXJdXJ2xtOhs+iG2I5FFrIDECZdKzyIMpCZRi3iJ0ctCHDSdT4hQTpAKHZ/e
TMWH0knUdnQlBjhQ1TSvmSp0CnWH7iqAjh8msqHlSzUVSOgoo1iTkzC14CyElUDIJk3unnsu
MSzO9964JxDGqmhvK7v8g0KHIBdW6nVJPfEbQvpsTeqnu4pZL5d8QZWfxbBt7U0LWjj7JkfZ
KfUmt4q5SyX6jnNHgFzk10o2Yi2H2BRAL7kiq1bnUeY1VnGzHVzc4n/jbgu9lrda6E3dZ7nF
PgGGKD836h4LDSlusNBLeXflVp0E3hS3UW71ZstPMAvkm5foqCZVRMWSUV3lJ4lakbOw79za
KuRa+RjDvFTN7prVV7I2AkOIQKhO3X9miTryccKMjlDoOEXLmFucISXq5obFippglJd8SNTh
VxxGkTFyJtOiHkRSaIqDMniqAGXVdF2NBTB3rHRWUyi6MgF8JqvRYYedyxhfKUG0UgkjlZgu
M2i3DDnKgGNEfYZD14CLBDbXWijBLscZbFwbdYY5tWF5VEwJillSpq792NhQ01S2ulUS3FRf
HDq3hN4rjUZaWPmCYWs3F/Aq8XcuCQSYjMmarV/JtumU8PNCiAEn1RJdbZMMZlnIqW2CE3Sx
M5jpKkItyje3QrguKzKZ9EzuCZytcDvP9TW3EcUUDM83TIlK7M0o0OSz3+KE9vMMOzHFjzik
lkWLlG0pJ+owjaLsUX/S7U76w97b3tWEPKmSI5PO+g8/1EmM2DYr7mtBege3Bjekbss6oau9
U56SF8tRSZjhcuZCq0wqF7+OKzSXg+jm/eT6atg9PXt3bOT6BWBa08j7eZIeP7nqjo+f6sDz
j1f9n6/WD+iN+pdIv8+fnj4Y9t/13qzvR2r55NIXvctxd2hMrzL66ll9XapXAfGuP3oCOPV8
njAe8QXcvwB/MOyeYcuuzrqr6L/7DegP+kMGT+LzIL+7l+a9E30XJzUunqjw4rMQh/1x/6x/
uYrP4DfgcwUBvBievl2dffEbZo+GZxenvTVLj1Ymm1l2Zeiz6lAOEooXy5y3RimhiNBIdJJK
qNo9OouBZAdWYx1dAyhjL9WwxoquFhhzD7pkJitWsLSi+ZmEK/3UXj5TCfhIRAXrsY7WY5Xe
5BYUDZTaFImNNmLazXKEZYbqXEiLKfpiM1pEpc/3MlFvsdlFxMZBXfOkBFeciLQTzi4VAJ1J
aRBiUwW2qlax1KdjXqI2TrK7xkZOgPZ6G1HFCW4wO8rAm1/b6T0csJO7AA2NftAUN5YnrMP5
WbED+rxJdyhgjCrXRcy5LfGsWo9r5vmBAQc7Y84xkdASZywBblCCD2Yb3ScVZonnftZ+vrvv
Z2KRqFpJrUMXKTZFhRFb5WtG7zuCRqnx1Z7n3JMH2LVSQLSgo3E69bNkTuEzZaOmrFP1em2Z
nMPPSgSBgNqUfTqxIwZhai3xiqp2jXz5vTot1Ck/gypTflaipi5YNTgRVyfMjcHFpAfn0YJb
Pvtxcv52ePoeE5tFYKCLfVmQX+lzYCdSdY9RgTgWzxd1jrDuc73mZYAGDaDyOuEHDzfpDVpU
EodB/wmZL8QSMwocKfF4ellAo8hBT83XfGohIkYRxW5/ND59P/jfLFdMXiYSG/NFMsfjy9+9
JuYUtKmVipO4L63WH/3+1fqjpdXM84svLvl+fD2ho40+tuR3r21OLrkLH/3LL78cc6QO/g9+
HPeuLvp0LQ1aFCFsdyXfvUQYuEPXh9WlOTYaXsIpU3FhmS9b5PqwAXUxFQKvrA/4buNvMrUX
nv8IBpwqfVhT1NMj9eHAPIVfa+RHtWwJ8hcV/TLv7mCMmGuNJQ0Wm02hcDIRohRL2eLCNRMU
vmtB5rZ7en4+7F1dj7o8aIWvtNySVnLgnOOujWt5cLyeqvwMhKbnz2VID/cXSCf9PWRV5eC6
tCUKlKrTMsZrS69NnaRT0kIlYKrfratl5IbVOBbFYNOAonXuxjV8maEBJ1r6d3Y3dPxxW8YT
jp6y6RipmhfeS6eG/w2Lu4GBpoThVVnc8L6NvwldLay90kmw0e7LoGjmWjuBTGZt/E3Qj74N
XshsVHM6WmHoGpJRam+RthRa0Gal6DkfhKf+nqmi2tLPCvVdG1upkKYymuTV+/wXIFyEo2w8
X4zHq58+LtSt13xyIpIMWVpGl0uowE+1R4z91pvSVZ3J5Mfu8Kp7OZkI+hHmbN5uM6Y6W60c
nyv9y8nXiIN+/XSy2qnO3PVG6DZV0HWo3N2o7i0JrQHLWWy/ph4sfS/JJiqLV+mi9FKo891h
d0w/J8/r7U702Dh7P3o7OT8dnzacRRPbEZU7U6FraTXCmadedq8ayyOfItKcr7Vdq0auBaSn
WjjXhiHGDQBBY6uXAKIn4g+h4o8/Rq++qERfsOJ5N2fplaMOamiuVo6WouW8grE2MldVl5z5
dD5EOqnIN1uVUhqYGf3rhPa3yizpAyFb3UuSEwRC/33dve4uVXHEdmEZaNSmWPDv7/hnHndx
+IEuVAfCgXZSVe9/2rm2nrZhKPzc/orAVJSUPmylPEyFPQ20SYhNY7yBqhRaitRClBa0Sey/
79wc35JVGzdpOt9DpSb2ie3YPrfPuZpfjy9s/m/9AqHgbXpB82AFNxbwdPvXNB2M6biDmane
9JTUk7vtze7MS67F5LXupBj6942p3L2dTifsSYhGDdf4vmM1SlzeX+tUwpqD4qrJeg+nk7/+
yX1omXnheamZZC4ch/JXQxM3zD6EzXt4CJq3se/Y1TgTEkco+vGFM941Q5f5bR62vb7hmpoU
8aKSlkpA7/Dw4Pjjwbd0UmAANq9MqsqmkkEzLyNokdlXoC2xQPbnnNWJpqrIgYeJaWPzHc2p
jpBsFHOFSrPoLIGFIwEV6+vtOW39sO2Pjr98HSaw0or8UhJBVal3ttTRCWdC7c0+3tx571/c
wYuDKjPrhSgsu40iFP4ErERgPh7rbSdgte7tJX2Zflsule6mPO8lg8p5DalqSHsLCRKjsnz0
IPzlENQ3C15nPf/b4f8znfhpqf+ENef/+4PdXYf/T9//GLxT/v+LgPn/pyv+uMZUji4vH8PU
/2duPFy4HK/lxsOlvLyKroE6bmLHu/tUW7hPLucXTxn3PBYwcbq8iNICLSj/Sv4j3gXpzBpm
otCEa3WJM9Hmq2ilrMrV7d08JfFbcJNtS9otupLKF2dvDHtCZyln4M42O8uzTXDyuKVQPaOI
M9bjEnvYwKbqnbtessAUKhimcyS/ExOqc8chPZZJJXskZegK/sD9XC/4iuJb5Z9kgyDrgcpI
gZqRt0Ixz+gl+NRmuFj4qcElqONVqzsrjPYhPzgHf5xHGcrXcck20pkwRlHE+CcaolghE2tp
xolUGWlHLVZEuxmo1Rk1ylgSnrqOGGnoqN/cwp5+PzCHEJA+lTQ8AjoK7eumYf+zxD7YDibn
BEhR2/hxUBV/ejRzJYa8ZiClFNp0wWCR9C2WN+hV/Zahq0L5zCCDLnKLQ4aYCVG4gXpbd7O+
aNVNno7udJkuYKqBO0zdus9H8+vlqpUXvP5G9PWANAdrDMpR3C58Q1Q/LzimN4LVmPIfhzTx
2pv1MyDS/7Onf8a673/t1uj//o7q/5fAM+h/0MHTGwxWnX7/fHQy+lQdBTP/2+hEwa7lac4a
vezrZLbI3TrR8QiRS8mdOo0SqxNbiQ9NNO2etHFmSVA63oR4B4I95w1SHqdo3UuvcWRe+2Ur
FAqFQqFQKBQKhUKhUCgUCoVCoVAoFAqFQqFQKBSK/wq/AUx7fgcAeAAA

--PNTmBPCT7hxwcZjr--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
