Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263762AbTJORiZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 13:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263764AbTJORiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 13:38:25 -0400
Received: from hermes.py.intel.com ([146.152.216.3]:26033 "EHLO
	hermes.py.intel.com") by vger.kernel.org with ESMTP id S263762AbTJORiV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 13:38:21 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: Question on atomic_inc/dec
Date: Wed, 15 Oct 2003 10:38:14 -0700
Message-ID: <A20D5638D741DD4DBAAB80A95012C0AED7868F@orsmsx409.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Question on atomic_inc/dec
Thread-Index: AcOTQl+Z6iz8HABUQMaxDBG0XYUgPgAAF+kA
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "sankar" <san_madhav@hotmail.com>, "Tim Hockin" <thockin@hockin.org>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 15 Oct 2003 17:38:15.0011 (UTC) FILETIME=[1CB34B30:01C39343]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: sankar [mailto:san_madhav@hotmail.com]

>  any solution to the original problem???
> (atomic_inc() defintion not there in redhat 9.0 asm/atomic.h)

Create an atomic.h header file in your source tree with the code
below, but bear in mind that porting to other arches might be painful:

struct atomic
{
  volatile int i;
}

  /* Simple atomic increment. */

static inline
void atomic_inc (struct atomic *a)
{
    asm volatile (
      "lock; incl %0"
      : "=m" (a->i)
      : "m" (a->i));
}

  /* Simple atomic decrement. */

static inline
void atomic_dec (struct atomic *a)
{
    asm volatile (
      "lock; decl %0"
      : "=m" (a->i)
      : "m" (a->i));
}

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own (and my fault)

