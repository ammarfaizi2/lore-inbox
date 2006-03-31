Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751179AbWCaB3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbWCaB3O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 20:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbWCaB3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 20:29:14 -0500
Received: from mga01.intel.com ([192.55.52.88]:15024 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751108AbWCaB3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 20:29:13 -0500
X-IronPort-AV: i="4.03,148,1141632000"; 
   d="scan'208"; a="17991384:sNHT176792217"
Message-Id: <200603310129.k2V1TCg27391@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Christoph Lameter'" <clameter@sgi.com>
Cc: "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "Zoltan Menyhart" <Zoltan.Menyhart@bull.net>,
       "Boehm, Hans" <hans.boehm@hp.com>,
       "Grundler, Grant G" <grant.grundler@hp.com>, <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>
Subject: RE: Synchronizing Bit operations V2
Date: Thu, 30 Mar 2006 17:29:56 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcZUYEhkCViVzmVURkezJv7VEOB0fAAAc8cA
In-Reply-To: <Pine.LNX.4.64.0603301709440.2553@schroedinger.engr.sgi.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote on Thursday, March 30, 2006 5:13 PM
> Then there will no barrier since clear_bit only has acquire semantics.
> This is a  bug in bit operations since smb_mb__before_clear_bit does
> not work as documentted.

Well, please make up your mind with:

Option (1):

#define clear_bit                     clear_bit_mode(..., RELEASE)
#define Smp_mb__before_clear_bit      do { } while (0)
#define Smp_mb__after_clear_bit       smp_mb()

Or option (2):

#define clear_bit                     clear_bit_mode(..., ACQUIRE)
#define Smp_mb__before_clear_bit      smp_mb()
#define Smp_mb__after_clear_bit       do { } while (0)

I'm fine with either one.

- Ken
