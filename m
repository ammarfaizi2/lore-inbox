Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262728AbVBYP5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262728AbVBYP5x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 10:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262727AbVBYP5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 10:57:53 -0500
Received: from alog0188.analogic.com ([208.224.220.203]:23424 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262728AbVBYP5G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 10:57:06 -0500
Date: Fri, 25 Feb 2005 10:53:44 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Payasam Manohar <pmanohar@lantana.cs.iitm.ernet.in>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Invalid module format in Fedora core2
In-Reply-To: <Pine.LNX.4.60.0502252056130.17145@lantana.cs.iitm.ernet.in>
Message-ID: <Pine.LNX.4.61.0502251031170.626@chaos.analogic.com>
References: <Pine.LNX.4.60.0502252056130.17145@lantana.cs.iitm.ernet.in>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1879706418-1967122788-1109346824=:626"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1879706418-1967122788-1109346824=:626
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

On Fri, 25 Feb 2005, Payasam Manohar wrote:

>
> Hai all,
>  I tried to insert a sample module into Fedora core 2 , But it is giving an 
> error message that " no module in the object"
> The same module was inserted successfully into Redhat linux 9.
>
> Is there any changes from RH 9 to Fedora Core 2 with respect to the module 
> writing and insertion.
>

Yes. Fedora Core 2 should have the new module tools. It also has
a new kernel. These new kernels load a module called "module.ko"
instead of "module.o". Inside the new module is some code used
to obfuscate the new module mechanism where 'insmod' and friends
has been moved inside the kernel, further bloating the kernel
and, incidentally, making it necessary for modules to be
"politically correct", i.e., policy moved into the kernel.

Whoever did this disastrous and destructive thing now wants
you to write modules in a certain "politically correct" way,
also. This means that you need to use the kernel source
Makefile.

There are new books that you are supposed to buy which will
tell you how to re-write all your modules to interface with
the new crap.

I attached a typical makefile so you can see how complicated
this new crap is.

In the meantime, you can just take this and link it with your
"module.o" to make a "module.ko".

//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
//
//  This program may be distributed under the GNU Public License
//  version 2, as published by the Free Software Foundation, Inc.,
//  59 Temple Place, Suite 330 Boston, MA, 02111.
//
//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
//
//   This is the junk that needs to be linked with module code so
//   it can be loaded by the new in-kernel module loader. It has no
//   purpose except to make the kernel loader happy.
//
//   This is a totally artificial mechanism used to prevent one
//   from making a module that can work over several different
//   kernel versions.
//
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/vermagic.h>
#include <linux/compiler.h>
#define DEREF(x) (#x)
#define MKSTR(x) DEREF(x)
MODULE_INFO(vermagic, VERMAGIC_STRING);
struct module __attribute__((section(".gnu.linkonce.this_module")))
  __this_module = {
  .name = MKSTR(MODNAME),
  .init = init_module,
  .exit = cleanup_module,
};
#ifdef REQUIRES_OTHER_MODULES
static const char __attribute_used__ __attribute__((section(".modinfo")))
__module_depends[]="depends=other_modules";
#else
static const char __attribute_used__ __attribute__((section(".modinfo")))
__module_depends[]="depends=";
#endif

> Any small help  also welcome.
>
> Thanks in advance.
> Regards,
> Manohar.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
--1879706418-1967122788-1109346824=:626
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=zzz
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.61.0502251053440.626@chaos.analogic.com>
Content-Description: 
Content-Disposition: attachment; filename=zzz

Iw0KIw0KIyAgICBUaGlzIHByb2dyYW0gbWF5IGJlIGRpc3RyaWJ1dGVkIHVu
ZGVyIHRoZSBHTlUgUHVibGljIExpY2Vuc2UNCiMgICAgdmVyc2lvbiAyLCBh
cyBwdWJsaXNoZWQgYnkgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbiwg
SW5jLiwNCiMgICAgNTkgVGVtcGxlIFBsYWNlLCBTdWl0ZSAzMzAgQm9zdG9u
LCBNQSwgMDIxMTEuDQojDQojICAgIFByb2plY3QgTWFrZWZpbGUgZm9yIGtl
cm5lbCB2ZXJzaW9ucyBvdmVyIDYgDQojICAgIENyZWF0ZWQgMDUtT0NULTIw
MDQgICAgUmljaGFyZCBCLiBKb2huc29uDQojDQojICAgIE5vdGUgdGhhdCBt
YWNybyAib2JqIiByZWZlcnMgdG8gdGhpcyBkaXJlY3Rvcnkgd2hlbg0KIyAg
ICBtYWtlIGlzIGV4ZWN1dGluZyBmcm9tIHRoZSBrZXJuZWwgZGlyZWN0b3J5
LiANCiMNCg0KJS5vOiUuUw0KCQlhcyAtbyAkQCAkPA0KDQpWRVJTIDo9ICQo
c2hlbGwgdW5hbWUgLXIpDQpDRElSIDo9ICQoc2hlbGwgcHdkKQ0KTUtOT0Qg
PSAvdXNyL2Jpbi9ta25vZHANCkZOQU0gPSBIZWF2eUxpbmsNCkVYVFJBX0NG
TEFHUyArPSAtREtWRVI2IC1ETUFKT1JfTlI9MTc4IC1ETU9ETkFNRT0iXCIk
KEZOQU0pIlwiDQoNCk9CSlMgPQlkYXRhbGluay5vCW1pbl9zaXplX3Qubwls
aWNlbnNlLm8JcmFtX3Rlc3Qub1wNCglyd2NoZWNrLm8Jc2VlcHJvbS5vCXJ3
cmVnLm8JCXJuZC5vXA0KCXJkdHNjLm8JCWRtYV9idWZmZXIubwlpb2N0bHR4
dC5vDQoNCmFsbDoJCWNoa2hkcnMgDQoJCUAuL2Noa2hkcnMNCgkJQG1ha2Ug
Vj0xIC1DIC91c3Ivc3JjL2xpbnV4LSQoVkVSUykgU1VCRElSUz0kKENESVIp
IG1vZHVsZXMNCgkJc3RyaXAgLXggLVIgLm5vdGUgLVIgLmNvbW1lbnQgJChG
TkFNKS5rbw0KDQpvYmotbQkJOj0gCSQoRk5BTSkubw0KJChGTkFNKS1vYmpz
CTo9CSQoT0JKUykNCiQob2JqKS9taW5fc2l6ZV90Lm86CSQob2JqKS9taW5f
c2l6ZV90LlMJJChvYmopL01ha2VmaWxlDQokKG9iaikvbGljZW5zZS5vOgkk
KG9iaikvbGljZW5zZS5jCSQob2JqKS9NYWtlZmlsZQ0KJChvYmopL3JhbV90
ZXN0Lm86CSQob2JqKS9yYW1fdGVzdC5jCSQob2JqKS9NYWtlZmlsZSANCiQo
b2JqKS9yd2NoZWNrLm86CSQob2JqKS9yd2NoZWNrLlMJJChvYmopL01ha2Vm
aWxlDQokKG9iaikvcndyZWcubzoJCSQob2JqKS9yd3JlZy5TCQkkKG9iaikv
TWFrZWZpbGUNCiQob2JqKS9ybmQubzoJCSQob2JqKS9ybmQuUwkJJChvYmop
L01ha2VmaWxlDQokKG9iaikvcmR0c2MubzoJCSQob2JqKS9yZHRzYy5TCQkk
KG9iaikvTWFrZWZpbGUNCiQob2JqKS9pb2N0bHR4dC5vOgkkKG9iaikvaW9j
dGx0eHQucw0KJChvYmopL2RhdGFsaW5rLm86CSQob2JqKS9kYXRhbGluay5j
CSQob2JqKS9kYXRhbGluay5oXA0KCQkJJChvYmopL2NvbmZpZy5oCQkkKG9i
aikvdHlwZXMuaFwNCgkJCSQob2JqKS9wbHguaAkJJChvYmopL2RsYi5oXA0K
CQkJJChvYmopL3Zlci5oCQkkKG9iaikvTWFrZWZpbGVcDQoJCQkkKFNVQkRJ
UlMpL2Jvb2wuaAkkKFNVQkRJUlMpL2t2ZXIuaA0KJChvYmopL2RtYV9idWZm
ZXIubzoJJChvYmopL2RtYV9idWZmZXIuYwkkKG9iaikvZGF0YWxpbmsuaFwN
CgkJCSQob2JqKS9jb25maWcuaAkJJChvYmopL01ha2VmaWxlXA0KCQkJJChT
VUJESVJTKS9ib29sLmgNCiQob2JqKS9zZWVwcm9tLm86CSQob2JqKS9zZWVw
cm9tLmMJJChvYmopL3BseC5oXA0KCQkJJChvYmopL3R5cGVzLmgJCSQob2Jq
KS9NYWtlZmlsZQ0KDQpjaGtoZHJzOgkuLi90b29scy9jaGtoZHJzLmMNCgln
Y2MgLU8yIC1XYWxsIC1vIGNoa2hkcnMgLi4vdG9vbHMvY2hraGRycy5jDQoN
CiQoU1VCRElSUykvY2hrdHJ1ZToJJChTVUJESVJTKS8uLi90b29scy9jaGt0
cnVlLmMNCglnY2MgLU8yIC1XYWxsIC1vICQoU1VCRElSUykvY2hrdHJ1ZSAk
KFNVQkRJUlMpLy4uL3Rvb2xzL2Noa3RydWUuYw0KDQokKFNVQkRJUlMpL2Jv
b2wuaDoJJChTVUJESVJTKS9jaGt0cnVlDQoJY2QgJChTVUJESVJTKSA7ICQo
U1VCRElSUykvY2hrdHJ1ZQ0KDQokKFNVQkRJUlMpL21raW9jdGx0eHQ6CSQo
U1VCRElSUykvbWtpb2N0bHR4dC5jDQoJZ2NjIC1PMiAtV2FsbCAtbyAkKFNV
QkRJUlMpL21raW9jdGx0eHQgJChTVUJESVJTKS9ta2lvY3RsdHh0LmMNCg0K
JChTVUJESVJTKS9pb2N0bHR4dC5zOgkkKFNVQkRJUlMpL21raW9jdGx0eHQg
JChTVUJESVJTKS9kYXRhbGluay5oDQoJY2QgJChTVUJESVJTKSA7ICQoU1VC
RElSUykvbWtpb2N0bHR4dA0KDQokKFNVQkRJUlMpL2Noa3ZlcjoJJChTVUJE
SVJTKS8uLi90b29scy9jaGt2ZXIuYw0KCWdjYyAtTzIgLVdhbGwgLW8gJChT
VUJESVJTKS9jaGt2ZXIgJChTVUJESVJTKS8uLi90b29scy9jaGt2ZXIuYw0K
DQokKFNVQkRJUlMpL2t2ZXIuaDoJJChTVUJESVJTKS9jaGt2ZXINCgljZCAk
KFNVQkRJUlMpIDsgJChTVUJESVJTKS9jaGt2ZXIgJChWRVJTKQ0KDQoNCmlu
c3RhbGw6CWluc3RhbGwuc2ggJChNS05PRCkNCglAc2ggaW5zdGFsbC5zaCBp
bnN0YWxsDQoNCg0KJChNS05PRCk6CS4uL3Rvb2xzL21rbm9kcC5jDQoJbWFr
ZSAtQyAuLi90b29scw0KDQpjbGVhbjoNCglybSAtcmYgJChPQkpTKSAkKEZO
QU0pLmtvICQoRk5BTSkubW9kLmMgJChGTkFNKSoubyBcLiouY21kIFwNCmNo
a2hkcnMgXC50bXBfdmVyc2lvbnMgY2hrdHJ1ZSBib29sLmgga3Zlci5oICou
cyBta2lvY3RsdHh0IGNoa3Zlcg0KCQlAc2ggaW5zdGFsbC5zaCBjbGVhbg0K
DQo=

--1879706418-1967122788-1109346824=:626--
