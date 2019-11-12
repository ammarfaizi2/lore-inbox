Return-Path: <SRS0=vuSH=ZE=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58EAC43331
	for <io-uring@archiver.kernel.org>; Tue, 12 Nov 2019 07:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B5A22084F
	for <io-uring@archiver.kernel.org>; Tue, 12 Nov 2019 07:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=eoitek.partner.onmschina.cn header.i=@eoitek.partner.onmschina.cn header.b="r2R37BMO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725781AbfKLHhf (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 12 Nov 2019 02:37:35 -0500
Received: from mail-shaon0136.outbound.protection.partner.outlook.cn ([42.159.164.136]:64140
        "EHLO cn01-SHA-obe.outbound.protection.partner.outlook.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725283AbfKLHhe (ORCPT <rfc822;io-uring@vger.kernel.org>);
        Tue, 12 Nov 2019 02:37:34 -0500
X-Greylist: delayed 1192 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Nov 2019 02:37:31 EST
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/s/gddEfMP0S3Bpw6VXjwPtxrg8UbGDUP5ySG4YB+GnCQ2erDSmpN9o+QcOOoQlJw09tRS+JnWVNy07514NVFWnBgh+twRzowmgBLIwOASafOXot3PxIRpvFBXWG3HVFI8gCO0b+U803FyDaiEIzOZc2Xd8UzclLM0ceFgdS4SCBXtsy85NTZ5+Gbgbl2Cs7clgNu1Q/5MIm1HDBJHaInXzG9AkF/1K+q/JMphrz+ASJx4HOBZJ8EJXPko2S4dITUZt5+4yGfIlsQhcEfi4Rf2QuaguNQ2J7E+ZMqgFyjSwWTaFpC/BNkG2gsZLyyntcUWlaZLRS2Hvsvft1KSmPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iu2rXMn2elHoQQ4czHoqPGMXU66RsS16DDHzl0Xtgns=;
 b=RGfWr9soj36/9bQ/GuTl3bSmiIsyVuJtCbBG1Cos0WC1GE6Mnux6uMvQBNvE2gP6HzkHNHVWMEneXsNvXTS6jEuiad1BJtne1PWUY7hNEJl0ZeZheoJpeNXqqHf8Enat48EUoME7gLoQp4dxWtcdZdilcUAWWjrQOPvFkouanPQELkt8Sa0NVq3xfhcz6HHoMTXsTijGhdEkq6ODc4yUuYWJjCM5Gzy+ajlqXSyqsjVKJ1NLovSIicejKkcZitG4iVE0tGpa70VARGkIKeAQPcTl7A0pGkqiK6QUPsdudOksCWe4J7um2lcgvWtwU2at8nfIF0egHxLPRCVeu/6wug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eoitek.com; dmarc=pass action=none header.from=eoitek.com;
 dkim=pass header.d=eoitek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=eoitek.partner.onmschina.cn; s=selector1-eoitek-partner-onmschina-cn;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iu2rXMn2elHoQQ4czHoqPGMXU66RsS16DDHzl0Xtgns=;
 b=r2R37BMOxS5MnkvR/HMJg/NxGcxw58SzbJz7f36RryThOBAVmNdgxaeghntv2ngbMbHscFyqu5q/HWXXGOX+cjfubH0eY+KUlsK6DSEdASH1LBJh9ok0mouHdoBpPrpJ/qk6og48v79yG3d9dxcBeW0FHEo4K0FCP6OoINaM44E=
Received: from SH0PR01MB0491.CHNPR01.prod.partner.outlook.cn (10.43.108.138)
 by SH0PR01MB0635.CHNPR01.prod.partner.outlook.cn (10.43.108.206) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.24; Tue, 12 Nov
 2019 07:17:33 +0000
Received: from SH0PR01MB0491.CHNPR01.prod.partner.outlook.cn ([10.43.108.138])
 by SH0PR01MB0491.CHNPR01.prod.partner.outlook.cn ([10.43.108.138]) with mapi
 id 15.20.2430.023; Tue, 12 Nov 2019 07:17:33 +0000
From:   =?utf-8?B?Q2FydGVyIExpIOadjumAmua0sg==?= <carter.li@eoitek.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>
Subject: Re: [PATCH] io_uring: make timeout sequence == 0 mean no sequence
Thread-Topic: [PATCH] io_uring: make timeout sequence == 0 mean no sequence
Thread-Index: AQHVmSO+MZCjLoMdVEeE8KEIwxu57KeHplQA
Date:   Tue, 12 Nov 2019 07:17:33 +0000
Message-ID: <459B9C70-755F-48AD-BF2D-9758A6B83768@eoitek.com>
References: <440e683b-8ddc-ebf8-7c52-10294b79a233@kernel.dk>
In-Reply-To: <440e683b-8ddc-ebf8-7c52-10294b79a233@kernel.dk>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=carter.li@eoitek.com; 
x-originating-ip: [106.120.83.130]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 03f7b5d4-3cdf-40ee-0ba3-08d767406307
X-MS-TrafficTypeDiagnostic: SH0PR01MB0635:|SH0PR01MB0635:|SH0PR01MB0635:|SH0PR01MB0635:|SH0PR01MB0635:
x-microsoft-antispam-prvs: <SH0PR01MB063573D187B5BB6CE1F2E5E494770@SH0PR01MB0635.CHNPR01.prod.partner.outlook.cn>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 021975AE46
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39830400003)(366004)(396003)(189003)(199004)(329002)(328002)(71190400001)(71200400001)(85182001)(36756003)(2501003)(446003)(11346002)(2616005)(95416001)(66066001)(486006)(66946007)(66446008)(63696004)(64756008)(476003)(5660300002)(8936002)(110136005)(8676002)(14454004)(76176011)(33656002)(6116002)(66476007)(66556008)(81156014)(6246003)(81166006)(76116006)(316002)(2906002)(508600001)(3846002)(7736002)(305945005)(86362001)(59450400001)(229853002)(186003)(26005)(102836004);DIR:OUT;SFP:1102;SCL:1;SRVR:SH0PR01MB0635;H:SH0PR01MB0491.CHNPR01.prod.partner.outlook.cn;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: eoitek.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qwnzp0cKTPHlz+jYcXdORESXo9BBZp7H6GKV42Ln1tiMfbM73LoAV+SKzo59j7HSwxRqe6DbXKl8qiYQiD6gCak28NdEGoDS8VjO1Wrggq/ahpCgQ0xne+mtXXNPeH4eoPEqli3j0xalQ/I9BJKWXMnnNo00GDbkt4j5lnFD4ZDFeIuX3th1ef/Q/zhtBn9Ff4KyjPjJCy3V0oVpIe0xnbMiH2FO1ii7Eu9xRFnE91yn6RMUyz6+18q5kqnXx5rISbZcBK/j2IijTTCXiDoM4LTsu3WSxbyxjYC+y4izfuojFf1w7HFcW82dAsg7JAi4TitZIa5E9ue3ue6vLUR54dqgPNcJVh5A1Bkl0/J2rdkJIEWuvHwJN619JhDRKKA7LbUu9zzDJYfTpd7yIqLb+apoV4O9qlGYdwFZfV252aBIjh61TWAoVpgTkTc7bx2O
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <695FED6CEDDF73429417BA699C6FA087@CHNPR01.prod.partner.outlook.cn>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 03f7b5d4-3cdf-40ee-0ba3-08d767406307
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 07:17:33.1939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e3e4d1ca-338b-4a22-bdef-50f88bbc88d8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PONzBayVBLr2LwUH2CJwfx7/QsmIKsD+wUnMl5/ds7St2HRxvzBfRl+LOWj5CrSqUoJ+6brqG6Oc3vQLbZxM3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SH0PR01MB0635
X-OriginatorOrg: eoitek.com
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

R3JlYXQgcGF0Y2ghIGlvX3VyaW5nIGlzIGJlY29taW5nIG1vcmUgYW5kIG1vcmUgdXNlciBmcmll
bmRseS4NCg0KUmV2aWV3ZWQtYnk6IOadjumAmua0siA8Y2FydGVyLmxpQGVvaXRlay5jb20+DQoN
Ci0tDQpDYXJ0ZXIsDQoNCu+7v+WcqCAyMDE5LzExLzEyIOS4i+WNiDI6MzjvvIzigJxKZW5zIEF4
Ym9l4oCdPGF4Ym9lQGtlcm5lbC5kaz4g5YaZ5YWlOg0KDQogICAgQ3VycmVudGx5IHdlIG1ha2Ug
c2VxdWVuY2UgPT0gMCBiZSB0aGUgc2FtZSBhcyBzZXF1ZW5jZSA9PSAxLCBidXQgdGhhdCdzDQog
ICAgbm90IHN1cGVyIHVzZWZ1bCBpZiB0aGUgaW50ZW50IGlzIHJlYWxseSB0byBoYXZlIGEgdGlt
ZW91dCB0aGF0J3MganVzdA0KICAgIGEgcHVyZSB0aW1lb3V0Lg0KICAgIA0KICAgIElmIHRoZSB1
c2VyIHBhc3NlcyBpbiBzcWUtPm9mZiA9PSAwLCB0aGVuIGRvbid0IGFwcGx5IGFueSBzZXF1ZW5j
ZSBsb2dpYw0KICAgIHRvIHRoZSByZXF1ZXN0LCBsZXQgaXQgcHVyZWx5IGJlIGRyaXZlbiBieSB0
aGUgdGltZW91dCBzcGVjaWZpZWQuDQogICAgDQogICAgUmVwb3J0ZWQtYnk6IOadjumAmua0siA8
Y2FydGVyLmxpQGVvaXRlay5jb20+DQogICAgU2lnbmVkLW9mZi1ieTogSmVucyBBeGJvZSA8YXhi
b2VAa2VybmVsLmRrPg0KICAgIA0KICAgIC0tLQ0KICAgIA0KICAgIENhcnRlciBicmluZ3MgdXAg
YSB2YWxpZCBwb2ludCB0aGF0IHdlIHNob3VsZCBiZSBhYmxlIHRvIHN1cHBvcnQgcHVyZQ0KICAg
IHRpbWVvdXRzLCB0aGF0IGRvbid0IGZhY3RvciBpbiB0aGUgc2VxdWVuY2UgYXQgYWxsLiBTaW5j
ZSB0aW1lb3V0cyB3ZXJlDQogICAgaW50cm9kdWNlZCBpbiB0aGlzIG1lcmdlIHdpbmRvdywgbm93
J3MgdGhlIHRpbWUgdG8gbWFrZSB0aGUgY29ycmVjdGlvbi4NCiAgICANCiAgICBkaWZmIC0tZ2l0
IGEvZnMvaW9fdXJpbmcuYyBiL2ZzL2lvX3VyaW5nLmMNCiAgICBpbmRleCBmOWEzODk5OGYyZmMu
Ljg3YmVjYTQzNzdmNyAxMDA2NDQNCiAgICAtLS0gYS9mcy9pb191cmluZy5jDQogICAgKysrIGIv
ZnMvaW9fdXJpbmcuYw0KICAgIEBAIC0zMjYsNiArMzI2LDcgQEAgc3RydWN0IGlvX2tpb2NiIHsN
CiAgICAgI2RlZmluZSBSRVFfRl9USU1FT1VUCQkxMDI0CS8qIHRpbWVvdXQgcmVxdWVzdCAqLw0K
ICAgICAjZGVmaW5lIFJFUV9GX0lTUkVHCQkyMDQ4CS8qIHJlZ3VsYXIgZmlsZSAqLw0KICAgICAj
ZGVmaW5lIFJFUV9GX01VU1RfUFVOVAkJNDA5NgkvKiBtdXN0IGJlIHB1bnRlZCBldmVuIGZvciBO
T05CTE9DSyAqLw0KICAgICsjZGVmaW5lIFJFUV9GX1RJTUVPVVRfTk9TRVEJODE5MgkvKiBubyB0
aW1lb3V0IHNlcXVlbmNlICovDQogICAgIAl1NjQJCQl1c2VyX2RhdGE7DQogICAgIAl1MzIJCQly
ZXN1bHQ7DQogICAgIAl1MzIJCQlzZXF1ZW5jZTsNCiAgICBAQCAtNDUzLDkgKzQ1NCwxMyBAQCBz
dGF0aWMgc3RydWN0IGlvX2tpb2NiICppb19nZXRfdGltZW91dF9yZXEoc3RydWN0IGlvX3Jpbmdf
Y3R4ICpjdHgpDQogICAgIAlzdHJ1Y3QgaW9fa2lvY2IgKnJlcTsNCiAgICAgDQogICAgIAlyZXEg
PSBsaXN0X2ZpcnN0X2VudHJ5X29yX251bGwoJmN0eC0+dGltZW91dF9saXN0LCBzdHJ1Y3QgaW9f
a2lvY2IsIGxpc3QpOw0KICAgIC0JaWYgKHJlcSAmJiAhX19pb19zZXF1ZW5jZV9kZWZlcihjdHgs
IHJlcSkpIHsNCiAgICAtCQlsaXN0X2RlbF9pbml0KCZyZXEtPmxpc3QpOw0KICAgIC0JCXJldHVy
biByZXE7DQogICAgKwlpZiAocmVxKSB7DQogICAgKwkJaWYgKHJlcS0+ZmxhZ3MgJiBSRVFfRl9U
SU1FT1VUX05PU0VRKQ0KICAgICsJCQlyZXR1cm4gTlVMTDsNCiAgICArCQlpZiAoIV9faW9fc2Vx
dWVuY2VfZGVmZXIoY3R4LCByZXEpKSB7DQogICAgKwkJCWxpc3RfZGVsX2luaXQoJnJlcS0+bGlz
dCk7DQogICAgKwkJCXJldHVybiByZXE7DQogICAgKwkJfQ0KICAgICAJfQ0KICAgICANCiAgICAg
CXJldHVybiBOVUxMOw0KICAgIEBAIC0xOTQxLDE4ICsxOTQ2LDI0IEBAIHN0YXRpYyBpbnQgaW9f
dGltZW91dChzdHJ1Y3QgaW9fa2lvY2IgKnJlcSwgY29uc3Qgc3RydWN0IGlvX3VyaW5nX3NxZSAq
c3FlKQ0KICAgICAJaWYgKGdldF90aW1lc3BlYzY0KCZ0cywgdTY0X3RvX3VzZXJfcHRyKHNxZS0+
YWRkcikpKQ0KICAgICAJCXJldHVybiAtRUZBVUxUOw0KICAgICANCiAgICArCXJlcS0+ZmxhZ3Mg
fD0gUkVRX0ZfVElNRU9VVDsNCiAgICArDQogICAgIAkvKg0KICAgICAJICogc3FlLT5vZmYgaG9s
ZHMgaG93IG1hbnkgZXZlbnRzIHRoYXQgbmVlZCB0byBvY2N1ciBmb3IgdGhpcw0KICAgIC0JICog
dGltZW91dCBldmVudCB0byBiZSBzYXRpc2ZpZWQuDQogICAgKwkgKiB0aW1lb3V0IGV2ZW50IHRv
IGJlIHNhdGlzZmllZC4gSWYgaXQgaXNuJ3Qgc2V0LCB0aGVuIHRoaXMgaXMNCiAgICArCSAqIGEg
cHVyZSB0aW1lb3V0IHJlcXVlc3QsIHNlcXVlbmNlIGlzbid0IHVzZWQuDQogICAgIAkgKi8NCiAg
ICAgCWNvdW50ID0gUkVBRF9PTkNFKHNxZS0+b2ZmKTsNCiAgICAtCWlmICghY291bnQpDQogICAg
LQkJY291bnQgPSAxOw0KICAgICsJaWYgKCFjb3VudCkgew0KICAgICsJCXJlcS0+ZmxhZ3MgfD0g
UkVRX0ZfVElNRU9VVF9OT1NFUTsNCiAgICArCQlzcGluX2xvY2tfaXJxKCZjdHgtPmNvbXBsZXRp
b25fbG9jayk7DQogICAgKwkJZW50cnkgPSBjdHgtPnRpbWVvdXRfbGlzdC5wcmV2Ow0KICAgICsJ
CWdvdG8gYWRkOw0KICAgICsJfQ0KICAgICANCiAgICAgCXJlcS0+c2VxdWVuY2UgPSBjdHgtPmNh
Y2hlZF9zcV9oZWFkICsgY291bnQgLSAxOw0KICAgICAJLyogcmV1c2UgaXQgdG8gc3RvcmUgdGhl
IGNvdW50ICovDQogICAgIAlyZXEtPnN1Ym1pdC5zZXF1ZW5jZSA9IGNvdW50Ow0KICAgIC0JcmVx
LT5mbGFncyB8PSBSRVFfRl9USU1FT1VUOw0KICAgICANCiAgICAgCS8qDQogICAgIAkgKiBJbnNl
cnRpb24gc29ydCwgZW5zdXJpbmcgdGhlIGZpcnN0IGVudHJ5IGluIHRoZSBsaXN0IGlzIGFsd2F5
cw0KICAgIEBAIC0xOTY0LDYgKzE5NzUsOSBAQCBzdGF0aWMgaW50IGlvX3RpbWVvdXQoc3RydWN0
IGlvX2tpb2NiICpyZXEsIGNvbnN0IHN0cnVjdCBpb191cmluZ19zcWUgKnNxZSkNCiAgICAgCQl1
bnNpZ25lZCBueHRfc3FfaGVhZDsNCiAgICAgCQlsb25nIGxvbmcgdG1wLCB0bXBfbnh0Ow0KICAg
ICANCiAgICArCQlpZiAobnh0LT5mbGFncyAmIFJFUV9GX1RJTUVPVVRfTk9TRVEpDQogICAgKwkJ
CWNvbnRpbnVlOw0KICAgICsNCiAgICAgCQkvKg0KICAgICAJCSAqIFNpbmNlIGNhY2hlZF9zcV9o
ZWFkICsgY291bnQgLSAxIGNhbiBvdmVyZmxvdywgdXNlIHR5cGUgbG9uZw0KICAgICAJCSAqIGxv
bmcgdG8gc3RvcmUgaXQuDQogICAgQEAgLTE5OTAsNiArMjAwNCw3IEBAIHN0YXRpYyBpbnQgaW9f
dGltZW91dChzdHJ1Y3QgaW9fa2lvY2IgKnJlcSwgY29uc3Qgc3RydWN0IGlvX3VyaW5nX3NxZSAq
c3FlKQ0KICAgICAJCW54dC0+c2VxdWVuY2UrKzsNCiAgICAgCX0NCiAgICAgCXJlcS0+c2VxdWVu
Y2UgLT0gc3BhbjsNCiAgICArYWRkOg0KICAgICAJbGlzdF9hZGQoJnJlcS0+bGlzdCwgZW50cnkp
Ow0KICAgICAJc3Bpbl91bmxvY2tfaXJxKCZjdHgtPmNvbXBsZXRpb25fbG9jayk7DQogICAgIA0K
ICAgIC0tIA0KICAgIEplbnMgQXhib2UNCiAgICANCiAgICANCg0K
