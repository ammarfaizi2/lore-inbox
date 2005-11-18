Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751190AbVKRXcW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbVKRXcW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 18:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbVKRXcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 18:32:21 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:64820 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751190AbVKRXcV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 18:32:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=kzucRpyMiPHVv77MROa93mABCVkH7sroOunyHhSRo7d+Gew+fjY/zGCD0CntfGL+6sVPg+kTmcLjLksArHN9cdAiqxy9FZmkJHPL4j/fVWPO3KFlyEK/w+oW6+oQTZZFkw3v+a63J/Y2HyguRyzQCeNAINwAEwSVpq54tBjxBxA=
Message-ID: <d120d5000511181532g69107c76x56a269425056a700@mail.gmail.com>
Date: Fri, 18 Nov 2005 18:32:20 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Resume from swsusp stopped working with 2.6.14 and 2.6.15-rc1
Cc: Bj?rn Mork <bjorn@mork.no>, linux-kernel@vger.kernel.org
In-Reply-To: <20051118183126.GA20793@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_13181_9812905.1132356740624"
References: <87zmoa0yv5.fsf@obelix.mork.no>
	 <d120d5000511171357g4d7a8d54hcc1c1d1cffa8856e@mail.gmail.com>
	 <20051118114032.GD15825@elf.ucw.cz> <87psoytbtt.fsf@obelix.mork.no>
	 <20051118183126.GA20793@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_13181_9812905.1132356740624
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 11/18/05, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
> > >> Bjorn, does it help if you change TIMEOUT in kernel/power/process.c =
to 30 * HZ?
> > >
> > > Funny, I thought that 6 seconds is way too much. Bjorn, please let us
> > > know if 30 seconds timeout helps.
> >
> > It does.
>
> Ouch, yes, that's clear. It is stopping tasks during *resume*... So I
> guess it gets wrong timing by design. Question is what to do with
> that. Could we make keyboard driver pause the boot until it is done
> resetting hardware? Or we can increase the timeout... would 10 seconds
> be enough?

Well, I think 10 seconds when suspending is a nice and resonable
number. For resume though I think we should wait much longer, maybe
even indefinitely - the only thing that timeout achieves is makes
people fsck because the system can't recover from that state.

In any case the attached should make input more swsusp friendly by
checking freeze condition after processing one event instead of all
pending events.

--
Dmitry

------=_Part_13181_9812905.1132356740624
Content-Type: application/octet-stream; name="input-help-swsusp.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="input-help-swsusp.patch"

SW5wdXQ6IG1ha2Ugc2VyaW8gYW5kIGdhbWVwb3J0IG1vcmUgc3dzdXNwIGZyaWVuZGx5Cgprc2Vy
aW9kIGFuZCBrZ2FtZXBvcnRkIHVzZWQgdG8gcHJvY2VzcyBhbGwgcGVuZGluZyBldmVudHMgYmVm
b3JlCmNoZWNraW5nIGZvciBmcmVlemUgY29uZGl0aW9uLiBUaGlzIG1heSBjYXVzZSBzd3N1c3Ag
dG8gdGltZSBvdXQKd2hpbGUgc3RvcHBpbmcgdGFza3Mgd2hlbiByZXN1bWluZy4gU3dpdGNoIHRv
IHByb2Nlc3MgZXZlbnRzIG9uZQpieSBvbmUgdG8gY2hlY2sgZnJlZXplIHN0YXR1cyBtb3JlIG9m
dGVuLgoKU2lnbmVkLW9mZi1ieTogRG1pdHJ5IFRvcm9raG92IDxkdG9yQG1haWwucnU+Ci0tLQoK
IGdhbWVwb3J0L2dhbWVwb3J0LmMgfCAgIDEyICsrKysrKysrKy0tLQogc2VyaW8vc2VyaW8uYyAg
ICAgICB8ICAgMTIgKysrKysrKysrLS0tCiAyIGZpbGVzIGNoYW5nZWQsIDE4IGluc2VydGlvbnMo
KyksIDYgZGVsZXRpb25zKC0pCgpJbmRleDogbGludXgvZHJpdmVycy9pbnB1dC9zZXJpby9zZXJp
by5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT0KLS0tIGxpbnV4Lm9yaWcvZHJpdmVycy9pbnB1dC9zZXJpby9zZXJpby5j
CisrKyBsaW51eC9kcml2ZXJzL2lucHV0L3NlcmlvL3NlcmlvLmMKQEAgLTI2OSwxNCArMjY5LDIw
IEBAIHN0YXRpYyBzdHJ1Y3Qgc2VyaW9fZXZlbnQgKnNlcmlvX2dldF9ldmUKIAlyZXR1cm4gZXZl
bnQ7CiB9CiAKLXN0YXRpYyB2b2lkIHNlcmlvX2hhbmRsZV9ldmVudHModm9pZCkKK3N0YXRpYyB2
b2lkIHNlcmlvX2hhbmRsZV9ldmVudCh2b2lkKQogewogCXN0cnVjdCBzZXJpb19ldmVudCAqZXZl
bnQ7CiAJc3RydWN0IHNlcmlvX2RyaXZlciAqc2VyaW9fZHJ2OwogCiAJZG93bigmc2VyaW9fc2Vt
KTsKIAotCXdoaWxlICgoZXZlbnQgPSBzZXJpb19nZXRfZXZlbnQoKSkpIHsKKwkvKgorCSAqIE5v
dGUgdGhhdCB3ZSBoYW5kbGUgb25seSBvbmUgZXZlbnQgaGVyZSB0byBnaXZlIHN3c3VzcAorCSAq
IGEgY2hhbmNlIHRvIGZyZWV6ZSBrc2VyaW9kIHRocmVhZC4gU2VyaW8gZXZlbnRzIHNob3VsZAor
CSAqIGJlIHByZXR0eSByYXJlIHNvIHdlIGFyZSBub3QgY29uY2VybmVkIGFib3V0IHRha2luZwor
CSAqIHBlcmZvcm1hbmNlIGhpdC4KKwkgKi8KKwlpZiAoKGV2ZW50ID0gc2VyaW9fZ2V0X2V2ZW50
KCkpKSB7CiAKIAkJc3dpdGNoIChldmVudC0+dHlwZSkgewogCQkJY2FzZSBTRVJJT19SRUdJU1RF
Ul9QT1JUOgpAQCAtMzY4LDcgKzM3NCw3IEBAIHN0YXRpYyBzdHJ1Y3Qgc2VyaW8gKnNlcmlvX2dl
dF9wZW5kaW5nX2MKIHN0YXRpYyBpbnQgc2VyaW9fdGhyZWFkKHZvaWQgKm5vdGhpbmcpCiB7CiAJ
ZG8gewotCQlzZXJpb19oYW5kbGVfZXZlbnRzKCk7CisJCXNlcmlvX2hhbmRsZV9ldmVudCgpOwog
CQl3YWl0X2V2ZW50X2ludGVycnVwdGlibGUoc2VyaW9fd2FpdCwKIAkJCWt0aHJlYWRfc2hvdWxk
X3N0b3AoKSB8fCAhbGlzdF9lbXB0eSgmc2VyaW9fZXZlbnRfbGlzdCkpOwogCQl0cnlfdG9fZnJl
ZXplKCk7CkluZGV4OiBsaW51eC9kcml2ZXJzL2lucHV0L2dhbWVwb3J0L2dhbWVwb3J0LmMKPT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PQotLS0gbGludXgub3JpZy9kcml2ZXJzL2lucHV0L2dhbWVwb3J0L2dhbWVwb3J0LmMK
KysrIGxpbnV4L2RyaXZlcnMvaW5wdXQvZ2FtZXBvcnQvZ2FtZXBvcnQuYwpAQCAtMzM5LDE0ICsz
MzksMjAgQEAgc3RhdGljIHN0cnVjdCBnYW1lcG9ydF9ldmVudCAqZ2FtZXBvcnRfZwogCXJldHVy
biBldmVudDsKIH0KIAotc3RhdGljIHZvaWQgZ2FtZXBvcnRfaGFuZGxlX2V2ZW50cyh2b2lkKQor
c3RhdGljIHZvaWQgZ2FtZXBvcnRfaGFuZGxlX2V2ZW50KHZvaWQpCiB7CiAJc3RydWN0IGdhbWVw
b3J0X2V2ZW50ICpldmVudDsKIAlzdHJ1Y3QgZ2FtZXBvcnRfZHJpdmVyICpnYW1lcG9ydF9kcnY7
CiAKIAlkb3duKCZnYW1lcG9ydF9zZW0pOwogCi0Jd2hpbGUgKChldmVudCA9IGdhbWVwb3J0X2dl
dF9ldmVudCgpKSkgeworCS8qCisJICogTm90ZSB0aGF0IHdlIGhhbmRsZSBvbmx5IG9uZSBldmVu
dCBoZXJlIHRvIGdpdmUgc3dzdXNwCisJICogYSBjaGFuY2UgdG8gZnJlZXplIGtnYW1lcG9ydGQg
dGhyZWFkLiBHYW1lcG9ydCBldmVudHMKKwkgKiBzaG91bGQgYmUgcHJldHR5IHJhcmUgc28gd2Ug
YXJlIG5vdCBjb25jZXJuZWQgYWJvdXQKKwkgKiB0YWtpbmcgcGVyZm9ybWFuY2UgaGl0LgorCSAq
LworCWlmICgoZXZlbnQgPSBnYW1lcG9ydF9nZXRfZXZlbnQoKSkpIHsKIAogCQlzd2l0Y2ggKGV2
ZW50LT50eXBlKSB7CiAJCQljYXNlIEdBTUVQT1JUX1JFR0lTVEVSX1BPUlQ6CkBAIC00MzMsNyAr
NDM5LDcgQEAgc3RhdGljIHN0cnVjdCBnYW1lcG9ydCAqZ2FtZXBvcnRfZ2V0X3Blbgogc3RhdGlj
IGludCBnYW1lcG9ydF90aHJlYWQodm9pZCAqbm90aGluZykKIHsKIAlkbyB7Ci0JCWdhbWVwb3J0
X2hhbmRsZV9ldmVudHMoKTsKKwkJZ2FtZXBvcnRfaGFuZGxlX2V2ZW50KCk7CiAJCXdhaXRfZXZl
bnRfaW50ZXJydXB0aWJsZShnYW1lcG9ydF93YWl0LAogCQkJa3RocmVhZF9zaG91bGRfc3RvcCgp
IHx8ICFsaXN0X2VtcHR5KCZnYW1lcG9ydF9ldmVudF9saXN0KSk7CiAJCXRyeV90b19mcmVlemUo
KTsK
------=_Part_13181_9812905.1132356740624--
