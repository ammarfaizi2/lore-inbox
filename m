Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932122AbWBYWZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbWBYWZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 17:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932132AbWBYWZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 17:25:27 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:9933 "EHLO lirs02.phys.au.dk")
	by vger.kernel.org with ESMTP id S932122AbWBYWZ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 17:25:26 -0500
Date: Sat, 25 Feb 2006 23:25:11 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Steven Rostedt <rostedt@goodmis.org>
cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-rt17
In-Reply-To: <Pine.LNX.4.44L0.0602251924270.20024-100000@lifa02.phys.au.dk>
Message-ID: <Pine.LNX.4.44L0.0602252322550.20024-300000@lifa02.phys.au.dk>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="202006529-731287918-1140906311=:20024"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--202006529-731287918-1140906311=:20024
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Sat, 25 Feb 2006, Esben Nielsen wrote:

> On Sat, 25 Feb 2006, Steven Rostedt wrote:
> [...]
> This time around wake_up_process_mutex() wasn't called when it ought to
> be... Now that I think about it there still is a problem with the
> patch I sent: First the priority is set down, then the task is woken up.
> But then it can't continue to de-boost the next task... Let me write a
> test with 4 tasks and 3 locks to demonstrate.
>
Ok, attached is the test and a better patch which solves the problem.

Esben

>
> > > I have attached the patch againt 2.6.17-rt17 (and therefore also
> > > included the previous patch) along with the updated tester and tests.
> > >
> > > Esben
> >
> > I'll take a look at this tomorrow.
> >
> > -- Steve
> >
> > >
> > >
> > > > > That was why I had _reversed_ the lock ordering relative to normal in the
> > > > > original patch: First lock task->pi_lock. Assign lock. Lock
> > > > > lock->wait_lock. Then unlock task->pi_lock. Now it is safe to refer to
> > > > > lock. To avoid deadlocks I used _raw_spin_trylock() when locking the 2.
> > > > > lock.
> > > >
> > > > Stupid me. I messed that one up. Should show up in the next -rt
> > > >
> > > > Thanks
> > > >
> > > > 	tglx
> > > >
> > > >
> > >
> > >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

--202006529-731287918-1140906311=:20024
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="3locks4tasksBoostSignal.tst"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44L0.0602252325110.20024@lifa02.phys.au.dk>
Content-Description: 
Content-Disposition: attachment; filename="3locks4tasksBoostSignal.tst"

dGhyZWFkczogICAgNCAgICAgICAzICAgICAgICAgMiAgICAgICAgICAgICAx
DQogICAgICAgIGxvY2tpbnRyICAxICAgICArICAgICAgICAgKyAgICAgICAg
ICAgICArDQogICAgICAgICAgICArICAgICAgbG9ja2ludHIgMiAgICAgKyAg
ICAgICAgICAgICArDQogICAgICAgICAgICArICAgICAgICsgICAgICAgIGxv
Y2tpbnRyIDMgICAgICAgICArDQogICAgICAgICAgICArICAgICAgbG9ja2lu
dHIgMyAgICAgKyAgICAgICAgICAgICArDQogICAgICAgICAgbG9ja2ludHIg
MiAgICArICAgICAgICAgKyAgICAgICAgICAgICArDQp0ZXN0OiAgICAgIHBy
aW8gNCAgcHJpbyAzICAgIHByaW8gMiAgICAgICBwcmlvIDENCnRlc3Q6ICAg
ICAgIC0gICAgICAgLSAgICAgICAgICsgICAgICAgICAgICAgKw0KICAgICAg
ICAgICAgKyAgICAgICArICAgICAgICAgKyAgICAgICAgICAgbG9ja2ludHIg
MQ0KdGVzdDogICAgICBwcmlvIDEgIHByaW8gMSAgICBwcmlvIDEgICAgICAg
cHJpbyAxDQp0ZXN0OiAgICAgICAtICAgICAgIC0gICAgICAgICArICAgICAg
ICAgICAgIC0NCg0KICAgICAgICAgICAgKyAgICAgICArICAgICAgICBzaWdu
YWwgNCAgICAgICArDQp0ZXN0OiAgICAgICAtICAgICAgIC0gICAgICAgICAr
ICAgICAgICAgICAgICsNCnRlc3Q6ICAgICAgcHJpbyA0ICBwcmlvIDMgICAg
cHJpbyAyICAgICAgIHByaW8gMQ0KICAgICAgICAgICAgIA0K
--202006529-731287918-1140906311=:20024
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="pi.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44L0.0602252325111.20024@lifa02.phys.au.dk>
Content-Description: 
Content-Disposition: attachment; filename="pi.patch"

LS0tIGxpbnV4LTIuNi4xNS1ydDE3L2tlcm5lbC9ydC5jLm9yaWcJMjAwNi0w
Mi0yMiAxNjo1Mzo0NC4wMDAwMDAwMDAgKzAxMDANCisrKyBsaW51eC0yLjYu
MTUtcnQxNy9rZXJuZWwvcnQuYwkyMDA2LTAyLTI1IDIzOjIwOjM0LjAwMDAw
MDAwMCArMDEwMA0KQEAgLTg3MywxMCArODczLDE5IEBAIHBpZF90IGdldF9i
bG9ja2VkX29uKHRhc2tfdCAqdGFzaykNCiAJfQ0KIA0KIAlsb2NrID0gdGFz
ay0+YmxvY2tlZF9vbi0+bG9jazsNCisJDQorCS8qIA0KKwkgKiBOb3cgd2Ug
aGF2ZSB0byB0YWtlIGxvY2stPndhaXRfbG9jayBfYmVmb3JlXyByZWxlYXNp
bmcNCisJICogdGFzay0+cGlfbG9jay4gT3RoZXJ3aXNlIGxvY2sgY2FuIGJl
IGRlYWxsb2NhdGVkIHdoaWxlIHdlIGFyZQ0KKwkgKiByZWZlcmluZyB0byBp
dCBhcyB0aGUgc3Vic3lzdGVtIGhhcyBubyB3YXkgb2Yga25vd2luZyBhYm91
dCB1cw0KKwkgKiBoYW5naW5nIGFyb3VuZCBpbiBoZXJlLg0KKwkgKi8NCisJ
aWYgKCFfcmF3X3NwaW5fdHJ5bG9jaygmbG9jay0+d2FpdF9sb2NrKSkgew0K
KwkJX3Jhd19zcGluX3VubG9jaygmdGFzay0+cGlfbG9jayk7DQorCQlnb3Rv
IHRyeV9hZ2FpbjsNCisgICAgICAgIH0NCiAJX3Jhd19zcGluX3VubG9jaygm
dGFzay0+cGlfbG9jayk7DQogDQotCWlmICghX3Jhd19zcGluX3RyeWxvY2so
JmxvY2stPndhaXRfbG9jaykpDQotCQlnb3RvIHRyeV9hZ2FpbjsNCiANCiAJ
b3duZXIgPSBsb2NrX293bmVyKGxvY2spOw0KIAlpZiAob3duZXIpDQpAQCAt
OTY0LDE0ICs5NzMsNTIgQEAgc3RhdGljIGlubGluZSBpbnQgY2FsY19waV9w
cmlvKHRhc2tfdCAqdA0KIH0NCiANCiAvKg0KLSAqIEFkanVzdCBwcmlvcml0
eSBvZiBhIHRhc2sNCisgKiBBZGp1c3QgcHJpb3JpdHkgb2YgYSB0YXNrLiAN
CiAgKi8NCi1zdGF0aWMgdm9pZCBhZGp1c3RfcHJpbyh0YXNrX3QgKnRhc2sp
DQorc3RhdGljIHZvaWQgYWRqdXN0X3ByaW9fbm9fd2FrZXVwKHRhc2tfdCAq
dGFzaykNCiB7DQogCWludCBwcmlvID0gY2FsY19waV9wcmlvKHRhc2spOw0K
IA0KLQlpZiAodGFzay0+cHJpbyAhPSBwcmlvKQ0KKwlpZiAodGFzay0+cHJp
byAhPSBwcmlvKSB7DQorCQltdXRleF9zZXRwcmlvKHRhc2ssIHByaW8pOw0K
Kwl9DQorfQ0KKw0KKy8qDQorICogQWRqdXN0IHByaW9yaXR5IG9mIGEgdGFz
ayBhbmQgd2FrZSBpdCB1cCBpZiB0aGUgcHJpbyBpcyBjaGFuZ2VkIA0KKyAq
IGFuZCBpdCBpcyBibG9ja2VkIG9uIGEgbXV0ZXgNCisgKi8NCitzdGF0aWMg
dm9pZCBhZGp1c3RfcHJpb193YWtldXAodGFza190ICp0YXNrKQ0KK3sNCisJ
aW50IHByaW8gPSBjYWxjX3BpX3ByaW8odGFzayk7DQorCQ0KKwlpZiAodGFz
ay0+cHJpbyA8IHByaW8pIHsNCisJCWlmICh0YXNrLT5ibG9ja2VkX29uKSB7
DQorICAgICAgICAgICAgICAgICAgICAgICAgLyoNCisJCQkgKiBUaGUgb3du
ZXIgd2lsbCBoYXZlIHRoZSBibG9ja2VkIGZpZWxkIHNldCBpZiBpdCBpcw0K
KwkJCSAqIGJsb2NrZWQgb24gYSBsb2NrLiBTbyBpbiB0aGlzIGNhc2Ugd2Ug
d2FudCB0byB3YWtlDQorCQkJICogdGhlIG93bmVyIHVwIHNvIGl0IGNhbiBi
b29zdCB3aG8gaXQgaXMgYmxvY2tlZCBvbi4NCisJCQkgKg0KKwkJCSAqIFdl
IGhhdmUgdG8gd2FpdCB3aXRoIGxvd2VyaW5nIGl0J3MgcHJpb3JpdHkgdW50
aWwgdGhpcyBpcyBkb25lDQorCQkJICogb3Igd2UgcmlzayBsZXR0aW5nIG90
aGVyIGhpZ2ggcHJpb3JpdHkgdGFzayBoYW5nIGFyb3VuZC4NCisJCQkgKi8N
CisJCQl3YWtlX3VwX3Byb2Nlc3NfbXV0ZXgodGFzayk7DQorCQl9DQorCQll
bHNlIHsNCisJCQltdXRleF9zZXRwcmlvKHRhc2ssIHByaW8pOw0KKwkJfQ0K
Kwl9DQorCWVsc2UgIGlmICh0YXNrLT5wcmlvID4gcHJpbykgew0KIAkJbXV0
ZXhfc2V0cHJpbyh0YXNrLCBwcmlvKTsNCisJCWlmICh0YXNrLT5ibG9ja2Vk
X29uKSB7DQorICAgICAgICAgICAgICAgICAgICAgICAgLyoNCisJCQkgKiBU
aGUgb3duZXIgd2lsbCBoYXZlIHRoZSBibG9ja2VkIGZpZWxkIHNldCBpZiBp
dCBpcw0KKwkJCSAqIGJsb2NrZWQgb24gYSBsb2NrLiBTbyBpbiB0aGlzIGNh
c2Ugd2Ugd2FudCB0byB3YWtlDQorCQkJICogdGhlIG93bmVyIHVwIHNvIGl0
IGNhbiBib29zdCB3aG8gaXQgaXMgYmxvY2tlZCBvbi4NCisJCQkgKi8NCisJ
CQl3YWtlX3VwX3Byb2Nlc3NfbXV0ZXgodGFzayk7DQorCQl9DQorCX0NCiB9
DQogDQogLyoNCkBAIC0xMDAxLDYgKzEwNDgsNyBAQCBzdGF0aWMgbG9uZyB0
YXNrX2Jsb2Nrc19vbl9sb2NrKHN0cnVjdCByDQogDQogCS8qIEVucXVldWUg
dGhlIHRhc2sgaW50byB0aGUgbG9jayB3YWl0ZXIgbGlzdCAqLw0KIAlfcmF3
X3NwaW5fbG9jaygmY3VycmVudC0+cGlfbG9jayk7DQorCWFkanVzdF9wcmlv
X25vX3dha2V1cChjdXJyZW50KTsNCiAJY3VycmVudC0+YmxvY2tlZF9vbiA9
IHdhaXRlcjsNCiAJd2FpdGVyLT5sb2NrID0gbG9jazsNCiAJd2FpdGVyLT50
YXNrID0gY3VycmVudDsNCkBAIC0xMDM0LDE2ICsxMDgyLDcgQEAgc3RhdGlj
IGxvbmcgdGFza19ibG9ja3Nfb25fbG9jayhzdHJ1Y3Qgcg0KIA0KIAkvKiBB
ZGQgdGhlIG5ldyB0b3AgcHJpb3JpdHkgd2FpdGVyIHRvIHRoZSBvd25lcnMg
d2FpdGVyIGxpc3QgKi8NCiAJcGxpc3RfYWRkKCZ3YWl0ZXItPnBpX2xpc3Qs
ICZvd25lci0+cGlfd2FpdGVycyk7DQotCWFkanVzdF9wcmlvKG93bmVyKTsN
Ci0NCi0JLyoNCi0JICogVGhlIG93bmVyIHdpbGwgaGF2ZSB0aGUgYmxvY2tl
ZCBmaWVsZCBzZXQgaWYgaXQgaXMNCi0JICogYmxvY2tlZCBvbiBhIGxvY2su
IFNvIGluIHRoaXMgY2FzZSB3ZSB3YW50IHRvIHdha2UNCi0JICogdGhlIG93
bmVyIHVwIHNvIGl0IGNhbiBib29zdCB3aG8gaXQgaXMgYmxvY2tlZCBvbi4N
Ci0JICovDQotCWlmIChvd25lci0+YmxvY2tlZF9vbikNCi0JCXdha2VfdXBf
cHJvY2Vzc19tdXRleChvd25lcik7DQotDQorCWFkanVzdF9wcmlvX3dha2V1
cChvd25lcik7DQogCV9yYXdfc3Bpbl91bmxvY2soJm93bmVyLT5waV9sb2Nr
KTsNCiAJcmV0dXJuIHJldDsNCiB9DQpAQCAtMTEzOSw3ICsxMTc4LDcgQEAg
c3RhdGljIHZvaWQgcmVtb3ZlX3dhaXRlcihzdHJ1Y3QgcnRfbXV0ZQ0KIAkJ
CW5leHQgPSBsb2NrX2ZpcnN0X3dhaXRlcihsb2NrKTsNCiAJCQlwbGlzdF9h
ZGQoJm5leHQtPnBpX2xpc3QsICZvd25lci0+cGlfd2FpdGVycyk7DQogCQl9
DQotCQlhZGp1c3RfcHJpbyhvd25lcik7DQorCQlhZGp1c3RfcHJpb193YWtl
dXAob3duZXIpOw0KIAkJX3Jhd19zcGluX3VubG9jaygmb3duZXItPnBpX2xv
Y2spOw0KIAl9DQogfQ0KQEAgLTEyMDEsNyArMTI0MCw3IEBAIHN0YXRpYyB2
b2lkIHJlbGVhc2VfbG9jayhzdHJ1Y3QgcnRfbXV0ZXgNCiANCiAJLyogIFJl
YWRqdXN0IHByaW9yaXR5LCB3aGVuIG5lY2Vzc2FyeS4gKi8NCiAJX3Jhd19z
cGluX2xvY2soJmN1cnJlbnQtPnBpX2xvY2spOw0KLQlhZGp1c3RfcHJpbyhj
dXJyZW50KTsNCisJYWRqdXN0X3ByaW9fbm9fd2FrZXVwKGN1cnJlbnQpOw0K
IAlfcmF3X3NwaW5fdW5sb2NrKCZjdXJyZW50LT5waV9sb2NrKTsNCiB9DQog
DQpAQCAtMTQ1Myw3ICsxNDkyLDcgQEAgc3RhdGljIGludCBfX3NjaGVkIGRv
d25fcnRzZW0oc3RydWN0IHJ0Xw0KIAkJICogUEkgYm9vc3QgaGFzIHRvIGdv
DQogCQkgKi8NCiAJCV9yYXdfc3Bpbl9sb2NrKCZjdXJyZW50LT5waV9sb2Nr
KTsNCi0JCWFkanVzdF9wcmlvKGN1cnJlbnQpOw0KKwkJYWRqdXN0X3ByaW9f
bm9fd2FrZXVwKGN1cnJlbnQpOw0KIAkJX3Jhd19zcGluX3VubG9jaygmY3Vy
cmVudC0+cGlfbG9jayk7DQogCX0NCiAJdHJhY2VfdW5sb2NrX2lycXJlc3Rv
cmUoJnRyYWNlbG9jaywgZmxhZ3MpOw0K
--202006529-731287918-1140906311=:20024--
