Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261851AbRE2LNW>; Tue, 29 May 2001 07:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261819AbRE2LNM>; Tue, 29 May 2001 07:13:12 -0400
Received: from chiara.elte.hu ([157.181.150.200]:17418 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S261763AbRE2LNA>;
	Tue, 29 May 2001 07:13:00 -0400
Date: Tue, 29 May 2001 13:11:08 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: <linux-kernel@vger.kernel.org>
Cc: <linux-smp@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [patch] ioapic-2.4.5-A1
Message-ID: <Pine.LNX.4.33.0105291306470.3146-200000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1030739712-991134668=:3146"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-1030739712-991134668=:3146
Content-Type: TEXT/PLAIN; charset=US-ASCII


the attached ioapic-2.4.5-A1 patch includes a number of important IO-APIC
related fixes (against 2.4.5-ac3):

 - correctly handle bridged devices that are not listed in the mptable
   directly. This fixes eg. dual-port eepro100 devices on Compaq boxes
   with such PCI layout:

    -+-[0d]---0b.0
     +-[05]-+-02.0
     |      \-0b.0
     \-[00]-+-02.0
            +-03.0-[01]--+-04.0    <=== eth0
            |            \-05.0    <=== eth1
            +-0b.0
            +-0c.0
            +-0d.0
            +-0e.0
            +-0f.0
            +-14.0
            +-14.1
            +-19.0
            +-1a.0
            \-1b.0

   without the patch the eepro100 devices get misdetected as XT-PIC IRQs
   and their interrupts are stuck.

 - the srcbus entry in the mptable does not have to be translated into
   a PCI-bus value.

 - add more APIC versions to the whitelist

 - initialize mp_bus_id_to_pci_bus[] correctly, so that we can detect
   nonlisted/bridged PCI busses more accurately.

the patch should only affect systems that were not working properly
before, but it might break broken-mptable systems - we'll see.

	Ingo

--8323328-1030739712-991134668=:3146
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="ioapic-2.4.5-A1"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0105291311080.3146@localhost.localdomain>
Content-Description: 
Content-Disposition: attachment; filename="ioapic-2.4.5-A1"

LS0tIGxpbnV4L2FyY2gvaTM4Ni9rZXJuZWwvaW9fYXBpYy5jLm9yaWcJVHVl
IE1heSAyOSAxMjoxMzoxNSAyMDAxDQorKysgbGludXgvYXJjaC9pMzg2L2tl
cm5lbC9pb19hcGljLmMJVHVlIE1heSAyOSAxMjoxOTo1NSAyMDAxDQpAQCAt
MjU2LDEwICsyNTYsMTYgQEANCiAgKi8NCiBzdGF0aWMgaW50IHBpbl8yX2ly
cShpbnQgaWR4LCBpbnQgYXBpYywgaW50IHBpbik7DQogDQotaW50IElPX0FQ
SUNfZ2V0X1BDSV9pcnFfdmVjdG9yKGludCBidXMsIGludCBzbG90LCBpbnQg
cGNpX3BpbikNCitpbnQgSU9fQVBJQ19nZXRfUENJX2lycV92ZWN0b3IoaW50
IGJ1cywgaW50IHNsb3QsIGludCBwaW4pDQogew0KIAlpbnQgYXBpYywgaSwg
YmVzdF9ndWVzcyA9IC0xOw0KIA0KKwlEcHJpbnRrKCJxdWVyeWluZyBQQ0kg
LT4gSVJRIG1hcHBpbmcgYnVzOiVkLCBzbG90OiVkLCBwaW46JWQuXG4iLA0K
KwkJYnVzLCBzbG90LCBwaW4pOw0KKwlpZiAobXBfYnVzX2lkX3RvX3BjaV9i
dXNbYnVzXSA9PSAtMSkgew0KKwkJcHJpbnRrKEtFUk5fV0FSTklORyAiUENJ
IEJJT1MgcGFzc2VkIG5vbmV4aXN0ZW50IFBDSSBidXMgJWQhXG4iLCBidXMp
Ow0KKwkJcmV0dXJuIC0xOw0KKwl9DQogCWZvciAoaSA9IDA7IGkgPCBtcF9p
cnFfZW50cmllczsgaSsrKSB7DQogCQlpbnQgbGJ1cyA9IG1wX2lycXNbaV0u
bXBjX3NyY2J1czsNCiANCkBAIC0yNzAsMTQgKzI3NiwxNCBAQA0KIA0KIAkJ
aWYgKChtcF9idXNfaWRfdG9fdHlwZVtsYnVzXSA9PSBNUF9CVVNfUENJKSAm
Jg0KIAkJICAgICFtcF9pcnFzW2ldLm1wY19pcnF0eXBlICYmDQotCQkgICAg
KGJ1cyA9PSBtcF9idXNfaWRfdG9fcGNpX2J1c1ttcF9pcnFzW2ldLm1wY19z
cmNidXNdKSAmJg0KKwkJICAgIChidXMgPT0gbGJ1cykgJiYNCiAJCSAgICAo
c2xvdCA9PSAoKG1wX2lycXNbaV0ubXBjX3NyY2J1c2lycSA+PiAyKSAmIDB4
MWYpKSkgew0KIAkJCWludCBpcnEgPSBwaW5fMl9pcnEoaSxhcGljLG1wX2ly
cXNbaV0ubXBjX2RzdGlycSk7DQogDQogCQkJaWYgKCEoYXBpYyB8fCBJT19B
UElDX0lSUShpcnEpKSkNCiAJCQkJY29udGludWU7DQogDQotCQkJaWYgKHBj
aV9waW4gPT0gKG1wX2lycXNbaV0ubXBjX3NyY2J1c2lycSAmIDMpKQ0KKwkJ
CWlmIChwaW4gPT0gKG1wX2lycXNbaV0ubXBjX3NyY2J1c2lycSAmIDMpKQ0K
IAkJCQlyZXR1cm4gaXJxOw0KIAkJCS8qDQogCQkJICogVXNlIHRoZSBmaXJz
dCBhbGwtYnV0LXBpbiBtYXRjaGluZyBlbnRyeSBhcyBhDQpAQCAtNzM4LDkg
Kzc0NCwxMSBAQA0KIAlwcmludGsoS0VSTl9ERUJVRyAiLi4uLiByZWdpc3Rl
ciAjMDE6ICUwOFhcbiIsICooaW50ICopJnJlZ18wMSk7DQogCXByaW50ayhL
RVJOX0RFQlVHICIuLi4uLi4uICAgICA6IG1heCByZWRpcmVjdGlvbiBlbnRy
aWVzOiAlMDRYXG4iLCByZWdfMDEuZW50cmllcyk7DQogCWlmICgJKHJlZ18w
MS5lbnRyaWVzICE9IDB4MGYpICYmIC8qIG9sZGVyIChOZXB0dW5lKSBib2Fy
ZHMgKi8NCisJCShyZWdfMDEuZW50cmllcyAhPSAweDExKSAmJg0KIAkJKHJl
Z18wMS5lbnRyaWVzICE9IDB4MTcpICYmIC8qIHR5cGljYWwgSVNBK1BDSSBi
b2FyZHMgKi8NCiAJCShyZWdfMDEuZW50cmllcyAhPSAweDFiKSAmJiAvKiBD
b21wYXEgUHJvbGlhbnQgYm9hcmRzICovDQogCQkocmVnXzAxLmVudHJpZXMg
IT0gMHgxZikgJiYgLyogZHVhbCBYZW9uIGJvYXJkcyAqLw0KKwkJKHJlZ18w
MS5lbnRyaWVzICE9IDB4MjApICYmDQogCQkocmVnXzAxLmVudHJpZXMgIT0g
MHgyMikgJiYgLyogYmlnZ2VyIFhlb24gYm9hcmRzICovDQogCQkocmVnXzAx
LmVudHJpZXMgIT0gMHgyRSkgJiYNCiAJCShyZWdfMDEuZW50cmllcyAhPSAw
eDNGKQ0KLS0tIGxpbnV4L2FyY2gvaTM4Ni9rZXJuZWwvbXBwYXJzZS5jLm9y
aWcJVHVlIE1heSAyOSAxMjoxMzoxNSAyMDAxDQorKysgbGludXgvYXJjaC9p
Mzg2L2tlcm5lbC9tcHBhcnNlLmMJVHVlIE1heSAyOSAxMjoxMzo0NiAyMDAx
DQpAQCAtMzYsNyArMzYsNyBAQA0KICAqLw0KIGludCBhcGljX3ZlcnNpb24g
W01BWF9BUElDU107DQogaW50IG1wX2J1c19pZF90b190eXBlIFtNQVhfTVBf
QlVTU0VTXTsNCi1pbnQgbXBfYnVzX2lkX3RvX3BjaV9idXMgW01BWF9NUF9C
VVNTRVNdID0geyAtMSwgfTsNCitpbnQgbXBfYnVzX2lkX3RvX3BjaV9idXMg
W01BWF9NUF9CVVNTRVNdID0geyBbMCAuLi4gTUFYX01QX0JVU1NFUy0xXSA9
IC0xIH07DQogaW50IG1wX2N1cnJlbnRfcGNpX2lkOw0KIA0KIC8qIEkvTyBB
UElDIGVudHJpZXMgKi8NCi0tLSBsaW51eC9hcmNoL2kzODYva2VybmVsL3Bj
aS1pcnEuYy5vcmlnCVR1ZSBNYXkgMjkgMTI6MTM6MTUgMjAwMQ0KKysrIGxp
bnV4L2FyY2gvaTM4Ni9rZXJuZWwvcGNpLWlycS5jCVR1ZSBNYXkgMjkgMTI6
MTM6NDYgMjAwMQ0KQEAgLTY2MCwxMCArNjYwLDEyIEBADQogCQkJaWYgKHBp
bikgew0KIAkJCQlwaW4tLTsJCS8qIGludGVycnVwdCBwaW5zIGFyZSBudW1i
ZXJlZCBzdGFydGluZyBmcm9tIDEgKi8NCiAJCQkJaXJxID0gSU9fQVBJQ19n
ZXRfUENJX2lycV92ZWN0b3IoZGV2LT5idXMtPm51bWJlciwgUENJX1NMT1Qo
ZGV2LT5kZXZmbiksIHBpbik7DQotLyoNCi0gKiBXaWxsIGJlIHJlbW92ZWQg
Y29tcGxldGVseSBpZiB0aGluZ3Mgd29yayBvdXQgd2VsbCB3aXRoIGZ1enp5
IHBhcnNpbmcNCi0gKi8NCi0jaWYgMA0KKwkvKg0KKwkgKiBCdXNzZXMgYmVo
aW5kIGJyaWRnZXMgYXJlIHR5cGljYWxseSBub3QgbGlzdGVkIGluIHRoZSBN
UC10YWJsZS4NCisJICogSW4gdGhpcyBjYXNlIHdlIGhhdmUgdG8gbG9vayB1
cCB0aGUgSVJRIGJhc2VkIG9uIHRoZSBwYXJlbnQgYnVzLA0KKwkgKiBwYXJl
bnQgc2xvdCwgYW5kIHBpbiBudW1iZXIuIFRoZSBTTVAgY29kZSBkZXRlY3Rz
IHN1Y2ggYnJpZGdlZA0KKwkgKiBidXNzZXMgaXRzZWxmIHNvIHdlIHNob3Vs
ZCBnZXQgaW50byB0aGlzIGJyYW5jaCByZWxpYWJseS4NCisJICovDQogCQkJ
CWlmIChpcnEgPCAwICYmIGRldi0+YnVzLT5wYXJlbnQpIHsgLyogZ28gYmFj
ayB0byB0aGUgYnJpZGdlICovDQogCQkJCQlzdHJ1Y3QgcGNpX2RldiAqIGJy
aWRnZSA9IGRldi0+YnVzLT5zZWxmOw0KIA0KQEAgLTY3NCw3ICs2NzYsNiBA
QA0KIAkJCQkJCXByaW50ayhLRVJOX1dBUk5JTkcgIlBDSTogdXNpbmcgUFBC
KEIlZCxJJWQsUCVkKSB0byBnZXQgaXJxICVkXG4iLCANCiAJCQkJCQkJYnJp
ZGdlLT5idXMtPm51bWJlciwgUENJX1NMT1QoYnJpZGdlLT5kZXZmbiksIHBp
biwgaXJxKTsNCiAJCQkJfQ0KLSNlbmRpZg0KIAkJCQlpZiAoaXJxID49IDAp
IHsNCiAJCQkJCXByaW50ayhLRVJOX0lORk8gIlBDSS0+QVBJQyBJUlEgdHJh
bnNmb3JtOiAoQiVkLEklZCxQJWQpIC0+ICVkXG4iLA0KIAkJCQkJCWRldi0+
YnVzLT5udW1iZXIsIFBDSV9TTE9UKGRldi0+ZGV2Zm4pLCBwaW4sIGlycSk7
DQo=
--8323328-1030739712-991134668=:3146--
