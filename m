Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129178AbRBIDAS>; Thu, 8 Feb 2001 22:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129375AbRBIDAJ>; Thu, 8 Feb 2001 22:00:09 -0500
Received: from d170.as5200.mesatop.com ([208.164.122.170]:26760 "HELO
	localhost.localdomain") by vger.kernel.org with SMTP
	id <S129178AbRBIC77>; Thu, 8 Feb 2001 21:59:59 -0500
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
Date: Thu, 8 Feb 2001 20:02:42 -0700
X-Mailer: KMail [version 1.1.99]
Content-Type: Multipart/Mixed;
  charset="";
  boundary="------------Boundary-00=_I4ZGTOM2X9U6R2GS6SSB"
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
To: Jochen Striepe <jochen@tolot.escape.de>
In-Reply-To: <01020813571906.04066@localhost.localdomain> <20010208223133.D21223@tolot.escape.de>
In-Reply-To: <20010208223133.D21223@tolot.escape.de>
Subject: Re: [PATCH] modify ver_linux to check e2fsprogs and more.
MIME-Version: 1.0
Message-Id: <01020820024207.04066@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_I4ZGTOM2X9U6R2GS6SSB
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

On Thursday 08 February 2001 14:31, Jochen Striepe wrote:
> >         Hi,
>
> On 08 Feb 2001, Steven Cole <elenstev@mesatop.com> wrote:
> > I have modified the scripts/ver_linux script to provide the following:
>
> [...]
>
> > hostname -V 2>&1 | awk 'NR==1{print "Net-tools             ", $NF}'
>
> *Please* consider modifying this. There might be a problem:
>
>
> tolot:/root # hostname -V
> tolot:/root # hostname
> -V
> tolot:/root # hostname --version
> hostname (GNU sh-utils) 2.0.11
> Written by Jim Meyering.

Hmm, I guess the newer verion of hostname broke the old behaviour:
[root@localhost scripts]# hostname -V       
net-tools 1.57
hostname 1.99 (2000-02-13)

But, there is an easy solution:
[root@localhost scripts]# ifconfig --version
net-tools 1.57
ifconfig 1.40 (2000-05-21)

I replaced the old code for Net-tools with this:

ifconfig --version 2>&1 | grep tools | awk \
'NR==1{print "Net-tools             ", $NF}'

That should work.  I hope.  Try it please.

A new patch, still against 2.4.1-ac6 is attached.
It should work with 2.4.1-ac5,6,7.

Steven

--------------Boundary-00=_I4ZGTOM2X9U6R2GS6SSB
Content-Type: text/english;
  name="patch2-ver_linux"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="patch2-ver_linux"

LS0tIGxpbnV4L3NjcmlwdHMvdmVyX2xpbnV4Lm9yaWcJVGh1IEZlYiAgOCAwNjozMzo1MiAyMDAx
CisrKyBsaW51eC9zY3JpcHRzL3Zlcl9saW51eAlUaHUgRmViICA4IDE5OjQ3OjUwIDIwMDEKQEAg
LTUsMzIgKzUsNjQgQEAKICMgZGlmZmVyIG9uIHlvdXIgc3lzdGVtLgogIwogUEFUSD0vc2Jpbjov
dXNyL3NiaW46L2JpbjovdXNyL2JpbjokUEFUSAotZWNobyAnLS0gVmVyc2lvbnMgaW5zdGFsbGVk
OiAoaWYgc29tZSBmaWVsZHMgYXJlIGVtcHR5IG9yIGxvb2snCi1lY2hvICctLSB1bnVzdWFsIHRo
ZW4gcG9zc2libHkgeW91IGhhdmUgdmVyeSBvbGQgdmVyc2lvbnMpJworZWNobyAnSWYgc29tZSBm
aWVsZHMgYXJlIGVtcHR5IG9yIGxvb2sgdW51c3VhbCB5b3UgbWF5IGhhdmUgYW4gb2xkIHZlcnNp
b24uJworZWNobyAnQ29tcGFyZSB0byB0aGUgY3VycmVudCBtaW5pbWFsIHJlcXVpcmVtZW50cyBp
biBEb2N1bWVudGF0aW9uL0NoYW5nZXMuJworZWNobyAnICcKKwogdW5hbWUgLWEKLWluc21vZCAt
ViAgMj4mMSB8IGF3ayAnTlI9PTEge3ByaW50ICJLZXJuZWwgbW9kdWxlcyAgICAgICAgIiwkTkZ9
JworZWNobyAnICcKKwogZWNobyAiR251IEMgICAgICAgICAgICAgICAgICIgYGdjYyAtLXZlcnNp
b25gCisKIG1ha2UgLS12ZXJzaW9uIDI+JjEgfCBhd2sgLUYsICd7cHJpbnQgJDF9JyB8IGF3ayBc
Ci0gICAgICAnL0dOVSBNYWtlL3twcmludCAiR251IE1ha2UgICAgICAgICAgICAgICIsJE5GfScK
KyAgICAgICcvR05VIE1ha2Uve3ByaW50ICJHbnUgbWFrZSAgICAgICAgICAgICAgIiwkTkZ9Jwor
CiBsZCAtdiAyPiYxIHwgYXdrIC1GXCkgJ3twcmludCAkMX0nIHwgYXdrIFwKLSAgICAgICcvQkZE
L3twcmludCAiQmludXRpbHMgICAgICAgICAgICAgICIsJE5GfScKLWxzIC1sIGBsZGQgL2Jpbi9z
aCB8IGF3ayAnL2xpYmMve3ByaW50ICQzfSdgIHwgc2VkIC1lICdzL1wuc28kLy8nIFwKLSAgfCBh
d2sgLUYnWy4tXScgICAne3ByaW50ICJMaW51eCBDIExpYnJhcnkgICAgICAgICIgJChORi0yKSIu
IiQoTkYtMSkiLiIkTkZ9JwotZWNobyAtbiAiRHluYW1pYyBsaW5rZXIgICAgICAgICAiCi1sZGQg
LXYgPiAvZGV2L251bGwgMj4mMSAmJiBsZGQgLXYgfHwgbGRkIC0tdmVyc2lvbiB8aGVhZCAtMQor
ICAgICAgJy9CRkQve3ByaW50ICJiaW51dGlscyAgICAgICAgICAgICAgIiwkTkZ9JworCittb3Vu
dCAtLXZlcnNpb24gfCBhd2sgLUZcLSAne3ByaW50ICJ1dGlsLWxpbnV4ICAgICAgICAgICAgIiwg
JE5GfScKKworaW5zbW9kIC1WICAyPiYxIHwgYXdrICdOUj09MSB7cHJpbnQgIm1vZHV0aWxzICAg
ICAgICAgICAgICAiLCRORn0nCisKK3R1bmUyZnMgMj4mMSB8IGdyZXAgdHVuZTJmcyB8IHNlZCAn
cy8sLy8nIHwgIGF3ayBcCisnTlI9PTEge3ByaW50ICJlMmZzcHJvZ3MgICAgICAgICAgICAgIiwg
JDJ9JworCityZWlzZXJmc2NrIDI+JjEgfCBncmVwIHJlaXNlcmZzcHJvZ3MgfCBhd2sgXAorJ05S
PT0xe3ByaW50ICJyZWlzZXJmc3Byb2dzICAgICAgICAgIiwgJE5GfScKKworY2FyZG1nciAtViAy
PiYxfCBncmVwIHZlcnNpb24gfCBhd2sgXAorJ05SPT0xe3ByaW50ICJwY21jaWEtY3MgICAgICAg
ICAgICAgIiwgJDN9JworCitwcHBkIC0tdmVyc2lvbiAyPiYxfCBncmVwIHZlcnNpb24gfCBhd2sg
XAorJ05SPT0xe3ByaW50ICJQUFAgICAgICAgICAgICAgICAgICAgIiwgJDN9JworCitpc2RuY3Ry
bCAyPiYxIHwgZ3JlcCB2ZXJzaW9uIHwgYXdrIFwKKydOUj09MXtwcmludCAiaXNkbjRrLXV0aWxz
ICAgICAgICAgICIsICRORn0nCisKK2xzIC1sIGBsZGQgL2Jpbi9zaCB8IGF3ayAnL2xpYmMve3By
aW50ICQzfSdgIHwgc2VkIFwKKy1lICdzL1wuc28kLy8nIHwgYXdrIC1GJ1suLV0nICAgJ3twcmlu
dCAiTGludXggQyBMaWJyYXJ5ICAgICAgICAiIFwKKyQoTkYtMikiLiIkKE5GLTEpIi4iJE5GfScK
KworbGRkIC12ID4gL2Rldi9udWxsIDI+JjEgJiYgbGRkIC12IHx8IGxkZCAtLXZlcnNpb24gfGhl
YWQgLTEgfCBhd2sgXAorJ05SPT0xe3ByaW50ICJEeW5hbWljIGxpbmtlciAobGRkKSAgIiwgJE5G
fScKKwogbHMgLWwgL3Vzci9saWIvbGlie2csc3RkY30rKy5zbyAgMj4vZGV2L251bGwgfCBhd2sg
LUYuIFwKICAgICAgICAne3ByaW50ICJMaW51eCBDKysgTGlicmFyeSAgICAgICIgJDQiLiIkNSIu
IiQ2fScKKwogcHMgLS12ZXJzaW9uIDI+JjEgfCBhd2sgJ05SPT0xe3ByaW50ICJQcm9jcHMgICAg
ICAgICAgICAgICAgIiwgJE5GfScKLW1vdW50IC0tdmVyc2lvbiB8IGF3ayAtRlwtICd7cHJpbnQg
Ik1vdW50ICAgICAgICAgICAgICAgICAiLCAkTkZ9JwotaG9zdG5hbWUgLVYgMj4mMSB8IGF3ayAn
TlI9PTF7cHJpbnQgIk5ldC10b29scyAgICAgICAgICAgICAiLCAkTkZ9JworCitpZmNvbmZpZyAt
LXZlcnNpb24gMj4mMSB8IGdyZXAgdG9vbHMgfCBhd2sgXAorJ05SPT0xe3ByaW50ICJOZXQtdG9v
bHMgICAgICAgICAgICAgIiwgJE5GfScKKwogIyBLYmQgbmVlZHMgJ2xvYWRrZXlzIC1oJywKIGxv
YWRrZXlzIC1oIDI+JjEgfCBhd2sgXAogJyhOUj09MSAmJiAoJDMgIX4gL29wdGlvbi8pKSB7cHJp
bnQgIktiZCAgICAgICAgICAgICAgICAgICAiLCAkM30nCisKICMgd2hpbGUgY29uc29sZS10b29s
cyBuZWVkcyAnbG9hZGtleXMgLVYnLgogbG9hZGtleXMgLVYgMj4mMSB8IGF3ayBcCiAnKE5SPT0x
ICYmICgkMiB+IC9jb25zb2xlLXRvb2xzLykpIHtwcmludCAiQ29uc29sZS10b29scyAgICAgICAg
ICIsICQzfScKLXJlaXNlcmZzY2sgLS1ib2d1c2FyZyAyPiYxIHwgZ3JlcCByZWlzZXJmc3Byb2dz
IHwgYXdrIFwKLSdOUj09MXtwcmludCAiUmVpc2VyZnNwcm9ncyAgICAgICAgICIsICRORn0nCisK
IGV4cHIgLS12IDI+JjEgfCBhd2sgJ05SPT0xe3ByaW50ICJTaC11dGlscyAgICAgICAgICAgICAg
IiwgJE5GfScKKwogWD1gY2F0IC9wcm9jL21vZHVsZXMgfCBzZWQgLWUgInMvIC4qJC8vImAKIGVj
aG8gIk1vZHVsZXMgTG9hZGVkICAgICAgICAgIiRYCg==

--------------Boundary-00=_I4ZGTOM2X9U6R2GS6SSB--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
