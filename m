Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261268AbRFYESI>; Mon, 25 Jun 2001 00:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262607AbRFYERs>; Mon, 25 Jun 2001 00:17:48 -0400
Received: from [164.164.82.29] ([164.164.82.29]:43252 "EHLO subexgroup.com")
	by vger.kernel.org with ESMTP id <S261268AbRFYERj>;
	Mon, 25 Jun 2001 00:17:39 -0400
From: "Anil Kumar" <anilk@subexgroup.com>
To: "Der Herr Hofrat" <der.herr@hofr.at>, <linux-kernel@vger.kernel.org>
Subject: RE: sizeof problem in kernel modules
Date: Mon, 25 Jun 2001 10:03:38 +0530
Message-ID: <NEBBIIKAMMOCGCPMPBJOOEGGCGAA.anilk@subexgroup.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
In-Reply-To: <200106231454.f5NEsKu14812@kanga.hofr.at>
Importance: Normal
X-Return-Path: anilk@subexgroup.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

struct { short x; long y; short z; }bad_struct;
struct { long y; short x; short z; }good_struct;

I would expect both structs to be 8byte in size , or atleast the same size !
but good_struct turns out to be 8bytes and bad_struct 12 .

what am I doing wrong here ?

thx !
hofrat
///////////////////////////////////////
It's general padding performed everywhere for a 32-bit m/c. Since the short
number is considered to be of 2 bytes whereas new data should start at the
next 32 bit alignment( if the data length exceeds the padding required )
hence next 2 bytes are left as padding, so the actual struct. of your
defined structutres are as follows,

struct{
 short x; /* 2- bytes */
 /* again 2- bytes padding */
 long y;  /* 4 - bytes */
 short z; /* 2 - bytes */
 /* again 2 - bytes padding
}bad_struct;

struct{
 long y;  /* 4 - bytes */
 short x; /* 2 - bytes */
 short z; /* 2 - bytes */
}good_struct;

anil


