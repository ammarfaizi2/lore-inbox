Return-Path: <SRS0=GIeg=ZU=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4759EC432C0
	for <io-uring@archiver.kernel.org>; Thu, 28 Nov 2019 15:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB9052084D
	for <io-uring@archiver.kernel.org>; Thu, 28 Nov 2019 15:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="LIvq1oLF";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Lt5O9Tia"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfK1PAf (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 28 Nov 2019 10:00:35 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:44224 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726715AbfK1PAf (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 28 Nov 2019 10:00:35 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id xASElZOl027833;
        Thu, 28 Nov 2019 07:00:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=oRAp2XlJOXI37qYI7waSGFwMNHGMXT66TP6jzXNe+PQ=;
 b=LIvq1oLFD1Qg3i4Ez6GVtDNlaowXuTftcnJLdmyJ2slh+SuikwWDvb6MZ0xRgTPzp0F6
 5x8EyUiSNVU9tNZGQMrqa/YXrKwZRYZ/rYXBfuL1ckliwjDtEq6Ev4YAcSFp/lbVQrbO
 Q/LM3gjsD0mtEYJTItNlGTAxBvtIHtuAeBc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 2wjfhq089v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 28 Nov 2019 07:00:31 -0800
Received: from ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) by
 ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 28 Nov 2019 07:00:31 -0800
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 28 Nov 2019 07:00:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OY+2h4MWQONRIt3WFmOVfFfz4IpPi/tCI8FJqizazGU4e6O5EGtdxF3DTBCLpXKrGkgz2Dupn9tJ1dD3/pTuKjiDy0bJgJUBJfbKve5Ug7SPkY+NXybMA/jesfGa1VldV+CjEu7kquhi4/sJpi5GtR6BNFXuNQWvLm9LRvlMPF2FAGYd9RzWIyGNg6X14whd3PMbIOWG59JBbwhZFroGpF7eoad6EPKR++ADnGqzxivvJ6FmkNM88mTQUREk8jR9SbIUyTh5DjKXMWOfcvlSFP+tOHgVVm9Qy/KR54r/oafHhErnNNyd/ViCwj/ipdiQ5NwOTbVvYzVGIIMp/56+KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRAp2XlJOXI37qYI7waSGFwMNHGMXT66TP6jzXNe+PQ=;
 b=Vm5CBSYAifGxeTMZBoA9MvYW3V4sXO5uknUOZRmI8MKnzP3B3YM3TpnNb5I77kDPrT+/SV/c4ig73NUdQTnY3B7znI4OWIYzmFhzMt07d5xX4CmV3nPkxlX2n+NxSUN8P8LUCgerw7biiPt8qAZTX4E07c/Qv7vTrBXMQrVrSMN5KXKPy+rlI10fEvMPXoob4BBClvRLvQ+EXLxAr9tWauu+i2aDlHaxycjTkYbk4CQNANkKB+h+Yv93i4DR1i34NNf1YHkF0inAud46j4Kt/taDZIBP+Q+G/8qevt8jXzS+lqP20tECZV1dpMohc6flX5ih9M1ehcVosqUd2urgew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRAp2XlJOXI37qYI7waSGFwMNHGMXT66TP6jzXNe+PQ=;
 b=Lt5O9TiaDcpcJwPrmITXcOwLezfYMjzLSgPvGa9jk4nN83/+bgwxI2rk3iJ4svkyuLCYIuWYVRhLxdAhhWyo57KMhzkvddiZwkOe3mV0VS2DiwBLKJy8uBm4A6IIYYmKr9E7mhUABKIGmrEJ6BULiHu14UU8p/7vpwKIxF8WtIY=
Received: from BYAPR15MB2790.namprd15.prod.outlook.com (20.179.158.31) by
 BYAPR15MB3046.namprd15.prod.outlook.com (20.178.238.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.18; Thu, 28 Nov 2019 15:00:30 +0000
Received: from BYAPR15MB2790.namprd15.prod.outlook.com
 ([fe80::1d32:6ae1:9e5d:d82a]) by BYAPR15MB2790.namprd15.prod.outlook.com
 ([fe80::1d32:6ae1:9e5d:d82a%6]) with mapi id 15.20.2495.014; Thu, 28 Nov 2019
 15:00:30 +0000
From:   Jens Axboe <axboe@fb.com>
To:     Johannes Thumshirn <jthumshirn@suse.de>
CC:     Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>
Subject: Re: [PATCH liburing] liburing: create an installation target for
 tests
Thread-Topic: [PATCH liburing] liburing: create an installation target for
 tests
Thread-Index: AQHVpdZN+8X9E8DiIU++RPKAFz2xy6egrXcA
Date:   Thu, 28 Nov 2019 15:00:29 +0000
Message-ID: <711e7644-1e65-c1d7-fb13-679e3fce7b6d@fb.com>
References: <20191128102606.26353-1-jthumshirn@suse.de>
In-Reply-To: <20191128102606.26353-1-jthumshirn@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BY5PR16CA0008.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::21) To BYAPR15MB2790.namprd15.prod.outlook.com
 (2603:10b6:a03:15a::31)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2605:e000:100e:8c61:e01d:21b7:e75a:aa82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 29100136-3586-4a56-cf68-08d77413b5ae
x-ms-traffictypediagnostic: BYAPR15MB3046:
x-microsoft-antispam-prvs: <BYAPR15MB304610E7DAB3E57A088C51BAC0470@BYAPR15MB3046.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-forefront-prvs: 0235CBE7D0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(136003)(346002)(376002)(199004)(189003)(186003)(102836004)(86362001)(36756003)(6116002)(5660300002)(6506007)(6436002)(6486002)(76176011)(52116002)(6512007)(6916009)(386003)(53546011)(4744005)(229853002)(54906003)(2906002)(66946007)(316002)(305945005)(7736002)(8936002)(66556008)(64756008)(81156014)(81166006)(66446008)(66476007)(8676002)(4326008)(14454004)(46003)(446003)(2616005)(256004)(31696002)(11346002)(25786009)(71190400001)(478600001)(99286004)(31686004)(71200400001)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3046;H:BYAPR15MB2790.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FzpbWJKtUGFU9O54wfj4kIzvMEx9KRNENu5dz5q5Gl+E55BMTOZspm4rRSvQxtYirLoiap+2IBhfuNykSIa3H7YRekZJpopdf9Kle1S3T/eL/tnEQgkRIK2+okClMxGc88WULkNw8JpLqy2nG5t/rCrPok2u7zpj1g2Oedhl7qbAQDBj+QwX3NgzDqD6Tgws+yA38mC5QxB/1iilcUrznSuaDvo8LaH4gD/9Ddg+B3S5/329TyEVWWGE3hdaElPJjN7I5OP0NqHHilsLoE3Gc28MF3SkfEzL9a4KMAkzt1fecGg2kp/EQ3fatDlrtiiUiTepMjKabpmZuxT+DL4zeWwX/TdIbAIWj+5GNZKSWnB2aljDRiD8V8dl8l3XhFAsLyzBwwhx2oOuIy+kEjeCawM+6t0D2Hdz09909aiE3+Dq3G3gI3N9NLGiQbcDCP8L
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F4C2F98AD74A0240BEA8C7C3A202CD4D@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 29100136-3586-4a56-cf68-08d77413b5ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2019 15:00:30.0166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BH5kGQzarjOohmVlw7is/COwuILshqFbVuNdNKSP+xRPRVVnU+vLT+hlNepZcXoZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3046
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-28_03:2019-11-28,2019-11-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 mlxscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 spamscore=0 clxscore=1011 mlxlogscore=977 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911280128
X-FB-Internal: deliver
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

T24gMTEvMjgvMTkgMjoyNiBBTSwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOg0KPiBDcmVhdGUg
YW4gaW5zdGFsbGF0aW9uIHRhcmdldCBmb3IgbGlidXJpbmcncyByZWdyZXNzZW4gdGVzdCBzdWl0
ZS4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5eXl5e
Xl5eXg0KcmVncmVzc2lvbiwgd2lsbCBmaXggaXQgdXAuDQoNCkFwcGxpZWQsIHRoYW5rcy4gQlRX
LCBpby11cmluZ0B2Z2VyLmtlcm5lbC5vcmcgaXMgdGhlIGlvX3VyaW5nIG1haWxpbmcNCmxpc3Qu
IFNpbmNlIGl0IGhhcyBub3RoaW5nIHRvIGRvIHdpdGggbGludXgtYmxvY2ssIEkndmUgc3RvcHBl
ZCB1c2luZw0KdGhhdCBsaXN0Lg0KDQotLSANCkplbnMgQXhib2UNCg0K
