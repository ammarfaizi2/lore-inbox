Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261578AbSJUSXh>; Mon, 21 Oct 2002 14:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261582AbSJUSXh>; Mon, 21 Oct 2002 14:23:37 -0400
Received: from d12lmsgate-2.de.ibm.com ([194.196.100.235]:43991 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id <S261578AbSJUSXe>; Mon, 21 Oct 2002 14:23:34 -0400
Importance: Normal
Sensitivity: 
Subject: RE: [PATCH] fixes for building kernel using Intel compiler
To: jun.nakajima@intel.com
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF7A6C8AED.84179E79-ONC1256C59.0063A90F@de.ibm.com>
From: "Ulrich Weigand" <Ulrich.Weigand@de.ibm.com>
Date: Mon, 21 Oct 2002 20:28:56 +0200
X-MIMETrack: Serialize by Router on D12ML028/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 21/10/2002 20:29:31
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jun Nakajima wrote:

>Having said that, one occasion where people might be surprised by gcc (this
>might be a known issue, though) is: typedef + __attribute__; it ignores
>__attribute__. For example,
>#include <stdio.h>
>
>struct foo_16 {
>        char xxx[3];
>        short yyy;
>} __attribute__ ((aligned (16)));
>
>typedef struct bar_16 {
>        char xxx[3];
>        short yyy;
>} bar_16_t __attribute__ ((aligned (16)));

This is a user error (sort of); you're supposed to write:

typedef struct bar_16 {
        char xxx[3];
        short yyy;
} __attribute__ ((aligned (16))) bar_16_t;

[The attribute modifies the original struct type, which gets then
assigned the typedef name.  This is similar to the case where a
variable definition follows:

struct { ... } __attribute__() var;
vs.
struct { ... ] var __attribute__();

In the first case, the attribute modifies the struct type itself,
while in the second case the attribute applies only to the one
instance var.]

A warning would still be nice; we got bitten by that one a couple
of times ...

>In the kernel, there are several device drivers (ftape-bsm.h, e100.h, for
>example) are doing this kind of thing (i.e. typedef + attribute).

Well, I guess in those files the attribute((packed)) is a no-op
anyway as the structs are already packed according to the default
rules, so it doesn't really matter.  It should probably still be
fixed ...


Mit freundlichen Gruessen / Best Regards

Ulrich Weigand

--
  Dr. Ulrich Weigand
  Linux for S/390 Design & Development
  IBM Deutschland Entwicklung GmbH, Schoenaicher Str. 220, 71032 Boeblingen
  Phone: +49-7031/16-3727   ---   Email: Ulrich.Weigand@de.ibm.com

