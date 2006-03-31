Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751190AbWCaBiA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbWCaBiA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 20:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbWCaBh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 20:37:59 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:10444 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751182AbWCaBh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 20:37:59 -0500
Date: Thu, 30 Mar 2006 17:37:45 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Zoltan Menyhart <Zoltan.Menyhart@bull.net>,
       "Boehm, Hans" <hans.boehm@hp.com>,
       "Grundler, Grant G" <grant.grundler@hp.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: RE: Synchronizing Bit operations V2
In-Reply-To: <200603310129.k2V1TCg27391@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.64.0603301736580.2758@schroedinger.engr.sgi.com>
References: <200603310129.k2V1TCg27391@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Mar 2006, Chen, Kenneth W wrote:

> Christoph Lameter wrote on Thursday, March 30, 2006 5:13 PM
> > Then there will no barrier since clear_bit only has acquire semantics.
> > This is a  bug in bit operations since smb_mb__before_clear_bit does
> > not work as documentted.
> 
> Well, please make up your mind with:
> 
> Option (1):
> 
> #define clear_bit                     clear_bit_mode(..., RELEASE)
> #define Smp_mb__before_clear_bit      do { } while (0)
> #define Smp_mb__after_clear_bit       smp_mb()
> 
> Or option (2):
> 
> #define clear_bit                     clear_bit_mode(..., ACQUIRE)
> #define Smp_mb__before_clear_bit      smp_mb()
> #define Smp_mb__after_clear_bit       do { } while (0)
> 
> I'm fine with either one.

Neither one is correct because there will always be one combination of 
clear_bit with these macros that does not generate the required memory 
barrier.

