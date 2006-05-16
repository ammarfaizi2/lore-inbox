Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751774AbWEPK4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751774AbWEPK4A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 06:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751776AbWEPK4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 06:56:00 -0400
Received: from mail14.syd.optusnet.com.au ([211.29.132.195]:14803 "EHLO
	mail14.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751774AbWEPKz7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 06:55:59 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: [PATCH] mm: cleanup swap unused warning
Date: Tue, 16 May 2006 20:55:36 +1000
User-Agent: KMail/1.9.1
Cc: linux list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       Andrew Morton <akpm@osdl.org>
References: <200605102132.41217.kernel@kolivas.org> <Pine.LNX.4.64.0605101604330.7472@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0605101604330.7472@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200605162055.36957.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 May 2006 09:04, Christoph Lameter wrote:
> On Wed, 10 May 2006, Con Kolivas wrote:
> > Are there any users of swp_entry_t when CONFIG_SWAP is not defined?
>
> Yes, a migration entry is a form of swap entry.

mm/vmscan.c: In function ‘remove_mapping’:
mm/vmscan.c:387: warning: unused variable ‘swap’

Ok so if we fix it by making swp_entry_t __attribute__((__unused__) we break 
swap migration code?

If we make swap_free() an empty static inline function then gcc compiles in 
the variable needlessly and we won't know it.

For the moment let's continue putting up with the warning.

-- 
-ck
