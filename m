Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266409AbRGBI0Z>; Mon, 2 Jul 2001 04:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266408AbRGBI0P>; Mon, 2 Jul 2001 04:26:15 -0400
Received: from imladris.infradead.org ([194.205.184.45]:23315 "EHLO
	infradead.org") by vger.kernel.org with ESMTP id <S266410AbRGBI0F>;
	Mon, 2 Jul 2001 04:26:05 -0400
Date: Mon, 2 Jul 2001 09:25:50 +0100 (BST)
From: Riley Williams <rhw@MemAlpha.CX>
X-X-Sender: <rhw@infradead.org>
To: Keith Owens <kaos@ocs.com.au>
cc: Russell King <rmk@arm.linux.org.uk>, Adam J Richter <adam@yggdrasil.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: 2.4.6p6: dep_{bool,tristate} $CONFIG_ARCH_xxx bugs
In-Reply-To: <26219.994058622@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.33.0107020827060.18977-101000@infradead.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-842912328-1947714777-994062350=:18977"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---842912328-1947714777-994062350=:18977
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi Keith.

 >> Q> dep_arch_tristate '  AM79C961A support' CONFIG_ARM_AM79C961A \
 >> Q>	"$CONFIG_ARCH_ACORN" $CONFIG_NET_ETHERNET

 >> That adds only two extra characters, neither conspicuous, and
 >> PASSES my code.

 > It relies on everybody writing new dep_arch_... rules to
 > remember the quotes.  You are just introducing another source of
 > human error.  That is how this mess occurred, no automatic
 > validation of input.

OK then, a simple change to the patch I submitted, and the following
instead...

 Q> dep_arch_tristate '  AM79C961A support' CONFIG_ARM_AM79C961A \
 Q>	ACORN $CONFIG_NET_ETHERNET

The enclosed patch implements this syntax, and CHECKS that the syntax
stated has been supplied, for both `make config` and `make menuconfig`
and I would imagine the same would be easily added to `make xconfig`
and `make checkconfig` as well by those fluent in the relevant
languages.

Note specifically that it requires that the CONFIG_ARCH_ part of the
name of the variable is NOT provided, and as a result requires that
config variables naming the architecture begin with that string.

Best wishes from Riley.

---842912328-1947714777-994062350=:18977
Content-Type: APPLICATION/x-gzip; name="linux-2.4.5-dep-arch.diff.gz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0107020925500.18977@infradead.org>
Content-Description: Patch v2
Content-Disposition: attachment; filename="linux-2.4.5-dep-arch.diff.gz"

H4sICDYvQDsCA2xpbnV4LTIuNC41LWRlcC1hcmNoLmRpZmYAzVdtb9s2EP7s
/IqbaizJYquWnJfaawMXWbqmWFLM3TAU65DSMh0RlUmXlBp7Q/fbd3eUbTmO
0w5bXwxDpkje8fjcw3voZrMJmdLFtBmH++HBfZdYNcnd/ROjR+qqsPLv2otC
ww8ygXYErbgbHXajNsStVmtrb2/vbtvaudHwrMgAYmh1uvg9iMg02ur1oLn/
oHEIe/iMWtDrbcE9/EK8D8+ELoSdQdTpdBpwrpJUyAxOM/WnGMg8hZNUuFwo
3YCHY5n0XGqKPNQyPyb7JpyNJ9a8k5CnEuRU5TCWzokrCTvP5GgEfaO13A23
9u7hF+PC8GYcUwP6KpMzeAq/qSxTYuzgoU2ve2M5FtkkFWEyPSaTJjweDmEo
J5fCJunlwJgMhK705FZhfLkEfo6lzh3kBuMxTpIDAFdMJsbmcgiDGfYrBx66
cAtKGM7FG7RHCOFabuPTSpFhnLbQWukrGAiXhgzi0SGB+KDViI4YxPfeBS4j
rTUWElE46TwY3DFHg2LIFIYgHCiMcCKsGMtcWop1wIFOrNIYZIOsNWPpPG6j
Qie5wtx6lzu78NfWHtDbo6AeBdR2qRrl3JmkBk77/ed9qOOELgT1XgDH38Y8
SPkJqB+N3m/tkXfcfSqziV/dR54Ya6WbGD2kzfNoLqc5jKwZw4JtoR8wiPsQ
KVEi6T889E5YJQaZZODidkTIxfuHjfjwBnTrqbTybaEsAylyjmmkrMvBTBgH
3AXaSD10QG8OgllAjogXBmfba+XQpITNEea0xsL9zkBm5no3hF/Qs5vpXEyh
f/rzr2f90xfkZ8OqHp2Lx+enYEbcnm+xwUtrk3Nu34mskI15QEy4RQqTVCZv
8B3zSKvcSPA6Ej7ZtbeFdGWya7goNmNq0lxst6nNFIA2ttQIfsc002AAjyDQ
ATRN2UHv48o7T5gF8Mf3TDu0rnmWxXCmcSNqSBRqBfj4jlaRmff+WuKgZ9t2
/eT5xZOzHy8f90+eXm6/8o5fBa8D+GbN+VCOlJb+GAd13EpA8bFjOq40oZKo
oE4bDxYzkcs4Z6Sq7F0xwFqU4IlD5ghYdAp7VVBd8HmdM6dAgpO90EyZeZbN
vOVCgLMRDs/m2S77sUaUTtgH8UKQo7EZFkQFPr48X2MNwUJirokjC3OBBeac
1rkoV8gy7nvpTf1x6fBxacd4XHy5ruGxwo2DB4pfN8BURWidWYx8lVX1qORU
PZ4zqt7+//kUrfGp93XwCQgtrkbNDeJ8LnWRcNnz6nwuSMKgFXX3j7oHB15i
N6nz0viGPEdH3aizlOejfUo4Pjtenb20ZixoKBtaXi8LWhfKbc83trPbmHdh
Fa+8pXKKb74wl10OjfSVnzNh4HZQn3EGFazWJ1VolmXSF4JjRa/xYHqt5mqZ
kwsrE3OlsZA71mnSCsIpimICKooOGpEXEvowe5QemUfBq/rZxZPnl1QrOauf
UJs3SvOqOFfk+QMCfYtEe1n9yYihV6SFqOFmygvNHNFQaSwRGQPmwYpbHVbd
OG7gTc/zyn+o4GjpeE8sm1qWBawqvlRQpZM6kVQDnUFUUiTP0g2dMsSdp76R
VsssLEUd/oWs+2oqdDJDuOElByScw6Lt5qzA+VRnNZBHlcskp9uam8hEjZS0
IZzlWEidqa6hXNVzbryvwdKMM17VcdCY+MYNIedwVnRbuc+u28F/EO7e1ybc
sALcKmZQwQyWmPk7JP+FiQ87VTa/wJRRHsUA/4Y0YFDkmL9rL76eShfMdhZi
n3LPCqT1zLvYUaEMKa926C9ydNud3xrc7i2UHvgK9eXoXDoyd9J5232I0Jt4
vHZL+Lwc/pKXhXL04/m7xOoO7kato47XrRj/gT/wV7oa7+OGlgPZ4GNKPljA
apvrTJmilRxVk+SztBkvyt9rmrfM4FoKVzH8mHO+wPPuyQw9g1pjVGt3loWa
k/nl9JJEvoRIE0I3Ye60y+vB/hJmvuFhMChy/LsGeBn8NChDuQ1yf1P6InDf
QclVqG+duIDZ0+kGzEv2/gPW7zK5nBIAAA==
---842912328-1947714777-994062350=:18977--
