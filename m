Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752168AbWCJKSz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752168AbWCJKSz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 05:18:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752191AbWCJKSy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 05:18:54 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:65226 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S1752168AbWCJKSy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 05:18:54 -0500
To: Carlos Munoz <carlos@kenati.com>
Cc: Lee Revell <rlrevell@joe-job.com>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: How can I link the kernel with libgcc ?
References: <4410D9F0.6010707@kenati.com>
	<200603100145.k2A1jMem005323@turing-police.cc.vt.edu>
	<1141956362.13319.105.camel@mindpipe> <4410EC0D.3090303@kenati.com>
	<4410F1BE.7000904@kenati.com>
From: Jes Sorensen <jes@sgi.com>
Date: 10 Mar 2006 05:18:41 -0500
In-Reply-To: <4410F1BE.7000904@kenati.com>
Message-ID: <yq0ek1a38n2.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Carlos" == Carlos Munoz <carlos@kenati.com> writes:

Carlos> I figured out how to get the driver to use floating point
Carlos> operations. I included source code (from an open source math
Carlos> library) for the log10 function in the driver. Then I added
Carlos> the following lines to the file arch/sh/kernel/sh_ksyms.c:

Bad bad bad!

You shouldn't be using floating point in the kernel at all! Most
architectures do not save the full floating point register set on
entry so if you start messing with the fp registers you may corrupt
user space applications.

You need to either write a customer user space app or use a table as
Arjan suggested.

Cheers,
Jes
