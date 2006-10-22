Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964836AbWJVI2G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964836AbWJVI2G (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 04:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964837AbWJVI2G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 04:28:06 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:63184 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964836AbWJVI2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 04:28:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:references:x-google-sender-auth;
        b=Fo1ZLGy+Q07MfZmiCd1G4x4xNKe4wKUnVXyvO9FvpQ9Mc+aWRV3N/jYrcodwwi2PvPyM9tmu98f7as9Z22SUFIHPcLNSBLa5pAsz92D9FZtT3CvRXCaH3Degdo56+y2WDKTGmxDGE0mb7Bl65uYsbzCgPHNBhR7QDo76W59sJ/k=
Message-ID: <86802c440610220128v2e103912sbfba193484fb6304@mail.gmail.com>
Date: Sun, 22 Oct 2006 01:28:03 -0700
From: "Yinghai Lu" <yinghai.lu@amd.com>
To: "Muli Ben-Yehuda" <muli@il.ibm.com>
Subject: Re: [PATCH] x86-64: typo in __assign_irq_vector when updating pos for vector and offset
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Andi Kleen" <ak@suse.de>
In-Reply-To: <20061022035109.GM5211@rhun.haifa.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_147882_25269164.1161505683178"
References: <200610212100.k9LL0GtC018787@hera.kernel.org>
	 <20061022035109.GM5211@rhun.haifa.ibm.com>
X-Google-Sender-Auth: 0f4e62ac77efa9c6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_147882_25269164.1161505683178
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 10/21/06, Muli Ben-Yehuda <muli@il.ibm.com> wrote:
> >
> > typo with cpu instead of new_cpu
>
> This patch breaks my x366 machine:
>
> aic94xx: device 0000:01:02.0: SAS addr 5005076a0112df00, PCBA SN , 8 phys, 8 enabled phys, flash present, BIOS build 1323
> aic94xx: couldn't get irq 25 for 0000:01:02.0
> ACPI: PCI interrupt for device 0000:01:02.0 disabled
> aic94xx: probe of 0000:01:02.0 failed with error -38
>
> Reverting it allows it to boot again. Since the patch is "obviously
> correct", it must be uncovering some other problem with the genirq
> code.
>


can you try attached patch? it use cpu_online_map instead of 0xff.

YH

------=_Part_147882_25269164.1161505683178
Content-Type: text/x-patch; name=vector_allocation_domain.diff; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_etl6ftub
Content-Disposition: attachment; filename="vector_allocation_domain.diff"

ZGlmZiAtLWdpdCBhL2FyY2gveDg2XzY0L2tlcm5lbC9nZW5hcGljX2ZsYXQuYyBiL2FyY2gveDg2
XzY0L2tlcm5lbC9nZW5hcGljX2ZsYXQuYwppbmRleCA3YzAxZGI4Li40OTBkZjY5IDEwMDY0NAot
LS0gYS9hcmNoL3g4Nl82NC9rZXJuZWwvZ2VuYXBpY19mbGF0LmMKKysrIGIvYXJjaC94ODZfNjQv
a2VybmVsL2dlbmFwaWNfZmxhdC5jCkBAIC0zMiw4ICszMiw3IEBAIHN0YXRpYyBjcHVtYXNrX3Qg
ZmxhdF92ZWN0b3JfYWxsb2NhdGlvbl8KIAkgKiBkZWxpdmVyIGludGVycnVwdHMgdG8gdGhlIHdy
b25nIGh5cGVydGhyZWFkIHdoZW4gb25seSBvbmUKIAkgKiBoeXBlcnRocmVhZCB3YXMgc3BlY2lm
aWVkIGluIHRoZSBpbnRlcnJ1cHQgZGVzaXRpbmF0aW9uLgogCSAqLwotCWNwdW1hc2tfdCBkb21h
aW4gPSB7IHsgWzBdID0gQVBJQ19BTExfQ1BVUywgfSB9OwotCXJldHVybiBkb21haW47CisJcmV0
dXJuIGNwdV9vbmxpbmVfbWFwOwogfQogCiAvKgo=
------=_Part_147882_25269164.1161505683178--
