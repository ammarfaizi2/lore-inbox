Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030197AbWGMQf5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030197AbWGMQf5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 12:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030204AbWGMQf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 12:35:57 -0400
Received: from nz-out-0102.google.com ([64.233.162.194]:626 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030197AbWGMQf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 12:35:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=Q5chkodqU2GHIT5le+ZK96FL25PDZXtPBqF2NncGOuTD99/vEurqIoTbGQbHHm/2tCpdsx5mw6tyumcr2ME6C2KkFZGHoihG1km0yMYABSE8qwHtebjTU1FTBwuGeurcOS9Uq45c5N9qvp2agJDNWD5Gt7YIQ582S4JvHDhu+SA=
Message-ID: <b0943d9e0607130935l2d8b2ff1qf1abec1af876f155@mail.gmail.com>
Date: Thu, 13 Jul 2006 17:35:55 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: [PATCH 00/10] Kernel memory leak detector 0.8
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <6bffcb0e0607121555n20a9df53q8589109024629f7a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_2525_28127018.1152808555540"
References: <20060710220901.5191.66488.stgit@localhost.localdomain>
	 <6bffcb0e0607110802w4f423854rb340227331084596@mail.gmail.com>
	 <b0943d9e0607110844m6278da6crdc03bccce420da1d@mail.gmail.com>
	 <6bffcb0e0607110902u4e24a4f2jc6acf2eb4c3bae93@mail.gmail.com>
	 <b0943d9e0607110931n4ce1c569x83aa134e2889926c@mail.gmail.com>
	 <6bffcb0e0607111000q228673a9kcbc6c91f76331885@mail.gmail.com>
	 <b0943d9e0607111454l1f9919eahbb3b683492a651e@mail.gmail.com>
	 <6bffcb0e0607120435x31eceab7r3fdb055a7bee6da2@mail.gmail.com>
	 <b0943d9e0607120917pa0c191aw5814a19b9e6f31fd@mail.gmail.com>
	 <6bffcb0e0607121555n20a9df53q8589109024629f7a@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_2525_28127018.1152808555540
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 12/07/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> I have tried
> #define SCAN_BLOCK_SIZE         2048
> and
> #define SCAN_BLOCK_SIZE         1024
> Unfortunately it doesn't change anything.

I realised that this only reduces the time running with interrupts
disabled but won't solve the soft lockup.

> Please try something like this
> on tty1
> isic -s rand -d your ip (http://www.packetfactory.net/Projects/ISIC/)
> on tty2
> kml_collector (http://www.stardust.webpages.pl/files/o_bugs/kml/ml/kml_collector.sh)
>
> (I have tried to read random files from /sys on vanilla kernel, but I
> can't reproduce that lockup)

Couldn't get it on my (embedded) platform but I think that's because
there are only a few reports in the memleak file. You have thousands
of reports and I think reading the memleak file is causing the soft
lockup.

Until we identify the leak (or false positive), you can use the
attached patch to supress the reports for context_struct_to_string.
Hopefully, this should eliminate the soft lockup as well.

-- 
Catalin

------=_Part_2525_28127018.1152808555540
Content-Type: text/x-patch; name=context_struct_to_string-not-leak.patch; 
	charset=ISO-8859-1
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eplcera7
Content-Disposition: attachment; filename="context_struct_to_string-not-leak.patch"

SWdub3JlIHRoZSAocmVhbCkgbGVhayByZXBvcnQgaW4gY29udGV4dF9zdHJ1Y3RfdG9fc3RyaW5n
CgpGcm9tOiBDYXRhbGluIE1hcmluYXMgPGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tPgoKVGhpcyBt
aWdodCBiZSBhIHJlYWwgbGVhayBidXQsIGJlY2F1c2Ugb2YgdGhlIGFtb3VudCBvZiBpbmZvcm1h
dGlvbgprbWVtbGVhayByZXBvcnRzLCB3ZSBpZ25vcmUgaXQgZm9yIG5vdyB0byBhbGxvdyB0ZXN0
aW5nIG9mIG90aGVyIHBhcnRzIG9mCmttZW1sZWFrLgoKU2lnbmVkLW9mZi1ieTogQ2F0YWxpbiBN
YXJpbmFzIDxjYXRhbGluLm1hcmluYXNAYXJtLmNvbT4KLS0tCgogc2VjdXJpdHkvc2VsaW51eC9z
cy9zZXJ2aWNlcy5jIHwgICAgMyArKysKIDEgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCsp
LCAwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NlY3VyaXR5L3NlbGludXgvc3Mvc2Vydmlj
ZXMuYyBiL3NlY3VyaXR5L3NlbGludXgvc3Mvc2VydmljZXMuYwppbmRleCBkMmU4MGU2Li5mOGNm
MDk4IDEwMDY0NAotLS0gYS9zZWN1cml0eS9zZWxpbnV4L3NzL3NlcnZpY2VzLmMKKysrIGIvc2Vj
dXJpdHkvc2VsaW51eC9zcy9zZXJ2aWNlcy5jCkBAIC01NDgsNiArNTQ4LDkgQEAgc3RhdGljIGlu
dCBjb250ZXh0X3N0cnVjdF90b19zdHJpbmcoc3RydQogCiAJLyogQWxsb2NhdGUgc3BhY2UgZm9y
IHRoZSBjb250ZXh0OyBjYWxsZXIgbXVzdCBmcmVlIHRoaXMgc3BhY2UuICovCiAJc2NvbnRleHRw
ID0ga21hbGxvYygqc2NvbnRleHRfbGVuLCBHRlBfQVRPTUlDKTsKKwkvKiBUaGlzIG1pZ2h0IGJl
IGEgcmVhbCBsZWFrIGJ1dCB3ZSBpZ25vcmUgaXQgZm9yIG5vdyB0byBhbGxvdworCSAqIHRlc3Rp
bmcgb3RoZXIgcGFydHMgb2Yga21lbWxlYWsgKi8KKwltZW1sZWFrX25vdF9sZWFrKHNjb250ZXh0
cCk7CiAJaWYgKCFzY29udGV4dHApIHsKIAkJcmV0dXJuIC1FTk9NRU07CiAJfQo=
------=_Part_2525_28127018.1152808555540--
