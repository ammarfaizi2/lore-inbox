Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265033AbUELLoh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265033AbUELLoh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 07:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265028AbUELLog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 07:44:36 -0400
Received: from fmr99.intel.com ([192.55.52.32]:2760 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S265031AbUELLoe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 07:44:34 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: Who owns those locks ?
Date: Wed, 12 May 2004 04:43:59 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F013CCAF0@scsmsx401.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Who owns those locks ?
Thread-Index: AcQ4ERoKd1Ag1DAZTvmHPQ4WzXMm4wABIz5g
From: "Luck, Tony" <tony.luck@intel.com>
To: <Zoltan.Menyhart@bull.net>
Cc: <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 12 May 2004 11:44:00.0083 (UTC) FILETIME=[6A862A30:01C43816]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>The first reason to use a shift of 12 bits is:
>you can see easily what the address of the owner's task structure is.
>In addition, with page size of 16 Kbytes, you've got only 16 Tbytes
>in the identity mapped kernel address space any way.
>Should we move to a page size of 64 Kbytes, you can use a shift of
>16 bits and you keep the address human readable ;-)

Human readable is nice.

The identity mapped kernel space is not limited by the pagesize.
Mappings in region 7[*] are provided by the Alt-dtlb miss handler,
which just inserts a kernel granule sized mapping into the TLB
to cover any TLB miss.

-Tony

[*] except for the percpu area in the top 64k of region 7 which is
mapped by a locked entry in a DTR register.
