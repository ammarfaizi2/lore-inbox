Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751286AbWEPP6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbWEPP6V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 11:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbWEPP6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 11:58:21 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:59273 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751286AbWEPP6U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 11:58:20 -0400
Date: Tue, 16 May 2006 08:58:11 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Con Kolivas <kernel@kolivas.org>
cc: linux list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] mm: cleanup swap unused warning
In-Reply-To: <200605162055.36957.kernel@kolivas.org>
Message-ID: <Pine.LNX.4.64.0605160853330.6065@schroedinger.engr.sgi.com>
References: <200605102132.41217.kernel@kolivas.org>
 <Pine.LNX.4.64.0605101604330.7472@schroedinger.engr.sgi.com>
 <200605162055.36957.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1700579579-186910767-1147795091=:6065"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1700579579-186910767-1147795091=:6065
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 16 May 2006, Con Kolivas wrote:

> On Thursday 11 May 2006 09:04, Christoph Lameter wrote:
> > On Wed, 10 May 2006, Con Kolivas wrote:
> > > Are there any users of swp_entry_t when CONFIG_SWAP is not defined?
> >
> > Yes, a migration entry is a form of swap entry.
>=20
> mm/vmscan.c: In function =FF=FFremove_mapping=FF=FF:
> mm/vmscan.c:387: warning: unused variable =FF=FFswap=FF=FF
>=20
> Ok so if we fix it by making swp_entry_t __attribute__((__unused__) we br=
eak=20
> swap migration code?

This will generally break page migration in mm.
=20
> If we make swap_free() an empty static inline function then gcc compiles =
in=20
> the variable needlessly and we won't know it.

PageSwapCache() returns false if CONFIG_SWAP is not set and therefore no=20
code is generated.

---1700579579-186910767-1147795091=:6065--
