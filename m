Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932272AbWDYSUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbWDYSUJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 14:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbWDYSUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 14:20:08 -0400
Received: from mga02.intel.com ([134.134.136.20]:19349 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S932272AbWDYSUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 14:20:05 -0400
X-IronPort-AV: i="4.04,154,1144047600"; 
   d="scan'208"; a="27603079:sNHT60903927"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C66894.DC799CFE"
Subject: RE: Problems with EDAC coexisting with BIOS
Date: Tue, 25 Apr 2006 11:19:58 -0700
Message-ID: <5389061B65D50446B1783B97DFDB392DA53ECC@orsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: Problems with EDAC coexisting with BIOS
Thread-Index: AcZnxgd91Avag54oRL6D8phpeS2MzAAA4liwADJuUGA=
From: "Gross, Mark" <mark.gross@intel.com>
To: "Gross, Mark" <mark.gross@intel.com>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <bluesmoke-devel@lists.sourceforge.net>,
       "LKML" <linux-kernel@vger.kernel.org>,
       "Carbonari, Steven" <steven.carbonari@intel.com>,
       "Ong, Soo Keong" <soo.keong.ong@intel.com>,
       "Wang, Zhenyu Z" <zhenyu.z.wang@intel.com>
X-OriginalArrivalTime: 25 Apr 2006 18:19:59.0579 (UTC) FILETIME=[DCD14AB0:01C66894]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C66894.DC799CFE
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable



>-----Original Message-----
>From: Gross, Mark
>Sent: Monday, April 24, 2006 11:14 AM
>To: 'Alan Cox'
>Cc: bluesmoke-devel@lists.sourceforge.net; LKML; Carbonari, Steven;
Ong,
>Soo Keong; Wang, Zhenyu Z
>Subject: RE: Problems with EDAC coexisting with BIOS
>
>
>
>>-----Original Message-----
>>From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
>>Sent: Monday, April 24, 2006 10:50 AM
>>To: Gross, Mark
>>Cc: bluesmoke-devel@lists.sourceforge.net; LKML; Carbonari, Steven;
Ong,
>>Soo Keong; Wang, Zhenyu Z
>>Subject: RE: Problems with EDAC coexisting with BIOS
>>
>>On Llu, 2006-04-24 at 08:57 -0700, Gross, Mark wrote:
>>> I think what I'm saying is pretty clear and I don't think it is
related
>>> to whatever workarounds where done earlier.
>>
>>Ok. I was concerned as I seem to remember an earlier errata fix
enabled
>>the memory controller temporarily to do a workaround on one bridge. We
>>hit this because it unconditionally disabled it afterwards and Intel
>>sent fixes for RHEL4. I don't believe the workaround in question is in
>>the current tree as it was fixed elsewhere.
>>
>>Just worried that if that is the case an SMI the wrong moment might
fail
>>to apply the workaround.
>>
>>
>>> >Why did Intel bother implementing this functionality and then
screwing
>>> >it up so that OS vendors can't use it ? It seems so bogus.
>>> >
>>>
>>> It was just a screw up not to have identified this issue sooner.
>>
>>Ok. So the intention was that the OS should also be able to access
this
>>material.
>>
>
>The E752x Si is made to allow access to the device / Function.
However;
>when it's integrated onto a MoBo with BIOS there can be implementations
>where we get into this coordination issue.
>
>>> >At the very least we should print a warning advising the user that
the
>>> >BIOS is incompatible and to ask the BIOS vendor for an update so
that
>>> >they can enable error detection and management support.
>>>
>>> I would place the warning in the probe or init code.
>>
>>Agreed, and then bale out. Customer pressure should do the rest if the
>>BIOS needs updating, or ACPI or similar need to grow a 'shared' API
for
>>this so the BIOS and OS can co-operate.
>>
>
>Yes and yes.
>
>I'm having trouble getting the dev0:fun1 hidden by bios test into the
>e752x_init code.  It seems to be a shame having to fail the probe1 and
>leave the driver loaded in memory.  Are there any recommendations on a
good
>way to do this?
>


Patch to work around this problem is attached.

Signed-off-by: Mark Gross

--mgross

------_=_NextPart_001_01C66894.DC799CFE
Content-Type: application/octet-stream;
	name="edac.patch"
Content-Transfer-Encoding: base64
Content-Description: edac.patch
Content-Disposition: attachment;
	filename="edac.patch"

PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PQ0KUkNTIGZpbGU6IC9vcHQvQ1ZTL2xpbnV4L2RyaXZlcnMvZWRhYy9lNzUyeF9l
ZGFjLmMsdg0KcmV0cmlldmluZyByZXZpc2lvbiAxLjEuMS4xDQpkaWZmIC11IC1yMS4xLjEuMSBl
NzUyeF9lZGFjLmMNCi0tLSBkcml2ZXJzL2VkYWMvZTc1MnhfZWRhYy5jCTIxIEFwciAyMDA2IDAy
OjU4OjMyIC0wMDAwCTEuMS4xLjENCisrKyBkcml2ZXJzL2VkYWMvZTc1MnhfZWRhYy5jCTI1IEFw
ciAyMDA2IDEzOjI2OjMzIC0wMDAwDQpAQCAtNzU1LDEwICs3NTUsMTYgQEANCiAJZGVidWdmMCgi
TUM6ICIgX19GSUxFX18gIjogJXMoKTogbWNpXG4iLCBfX2Z1bmNfXyk7DQogCWRlYnVnZjAoIlN0
YXJ0aW5nIFByb2JlMVxuIik7DQogDQotCS8qIGVuYWJsZSBkZXZpY2UgMCBmdW5jdGlvbiAxICov
DQorCS8qIGNoZWNrIHRvIHNlZSBpZiBkZXZpY2UgMCBmdW5jdGlvbiAxIGlzIGVuYmFsZWQgaWYg
aXQgaXNuJ3Qgd2UgYXNzdW1lDQorCSAqIHRoZSBCSU9TIGhhcyByZXNlcnZlZCBpdCBmb3IgYSBy
ZWFzb24gYW5kIGlzIGV4cGVjdGluZyBleGNsdXNpdmUNCisJICogYWNjZXNzLCB3ZSB0YWtlIGNh
cmUgdG8gbm90IHZpb2xhdGUgdGhhdCBhc3N1bXB0aW9uIGFuZCBmYWlsIHRoZQ0KKwkgKiBwcm9i
ZS4gKi8NCiAJcGNpX3JlYWRfY29uZmlnX2J5dGUocGRldiwgRTc1MlhfREVWUFJFUzEsICZzdGF0
OCk7DQotCXN0YXQ4IHw9ICgxIDw8IDUpOw0KLQlwY2lfd3JpdGVfY29uZmlnX2J5dGUocGRldiwg
RTc1MlhfREVWUFJFUzEsIHN0YXQ4KTsNCisJaWYgKCEoc3RhdDggJiAoMSA8PCA1KSkpIHsNCisJ
CXByaW50ayhLRVJOX1dBUk5JTkcgImNvbnRhY3QgeW91ciBiaW9zIHZlbmRvciB0byBzZWUgaWYg
dGhlICIgDQorCQkiRTc1MnggZXJyb3IgcmVnaXN0ZXJzIGNhbiBiZSBzYWZlbHkgdW4taGlkZGVu
XG4iKTsNCisJCWdvdG8gZmFpbDsNCisJfQ0KIA0KIAkvKiBuZWVkIHRvIGZpbmQgb3V0IHRoZSBu
dW1iZXIgb2YgY2hhbm5lbHMgKi8NCiAJcGNpX3JlYWRfY29uZmlnX2R3b3JkKHBkZXYsIEU3NTJY
X0RSQywgJmRyYyk7DQo=

------_=_NextPart_001_01C66894.DC799CFE--
