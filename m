Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265090AbUEYVXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265090AbUEYVXt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 17:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265091AbUEYVXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 17:23:49 -0400
Received: from fmr05.intel.com ([134.134.136.6]:4245 "EHLO hermes.jf.intel.com")
	by vger.kernel.org with ESMTP id S265090AbUEYVXq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 17:23:46 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Hard Hang with __alloc_pages: 0-order allocation failed (gfp=0x20/1) - Not out of memory
Date: Tue, 25 May 2004 14:20:23 -0700
Message-ID: <C6F5CF431189FA4CBAEC9E7DD5441E0103AF618C@orsmsx402.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Hard Hang with __alloc_pages: 0-order allocation failed (gfp=0x20/1) - Not out of memory
Thread-Index: AcRCi32BdSsgNeTDQEqvO0A7gK2YZAAEk+sA
From: "Feldman, Scott" <scott.feldman@intel.com>
To: "Marcelo Tosatti" <marcelo.tosatti@cyclades.com>,
       "Doug Dumitru" <doug@easyco.com>
Cc: <linux-kernel@vger.kernel.org>, "cramerj" <cramerj@intel.com>,
       "Ronciak, John" <john.ronciak@intel.com>,
       "Venkatesan, Ganesh" <ganesh.venkatesan@intel.com>, <jgarzik@pobox.com>
X-OriginalArrivalTime: 25 May 2004 21:20:24.0729 (UTC) FILETIME=[17F31890:01C4429E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:

> It seems we are calling alloc_skb(GFP_KERNEL) from inside an 
> interrupt handler. Oops. 

We're calling dev_alloc_skb() from hard interrupt context, but it uses
GFP_ATOMIC, not GFP_KERNEL, so this is OK, right?  I don't see the
problem with e1000.
 
> e1000 maintainers, can you look at this please? 

-scott
