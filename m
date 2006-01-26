Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964801AbWAZS5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801AbWAZS5y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 13:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964786AbWAZS5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 13:57:54 -0500
Received: from mx.pathscale.com ([64.160.42.68]:15596 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S964797AbWAZS5w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 13:57:52 -0500
Subject: Re: [PATCH 8/12] generic hweight{32,16,8}()
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Akinobu Mita <mita@miraclelinux.com>
Cc: Grant Grundler <iod00d@hp.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org
In-Reply-To: <20060126033613.GG11138@miraclelinux.com>
References: <20060125112625.GA18584@miraclelinux.com>
	 <20060125113206.GD18584@miraclelinux.com>
	 <20060125200250.GA26443@flint.arm.linux.org.uk>
	 <20060125205907.GF9995@esmail.cup.hp.com>
	 <20060126032713.GA9984@miraclelinux.com>
	 <20060126033613.GG11138@miraclelinux.com>
Content-Type: text/plain
Date: Thu, 26 Jan 2006 10:57:47 -0800
Message-Id: <1138301867.12632.71.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-26 at 12:36 +0900, Akinobu Mita wrote:

> HAVE_ARCH_HWEIGHT_BITOPS is defined when the architecture has its own
> version of these functions.

All of this HAVE_ARCH_xxx stuff gave Linus heartburn a few weeks ago,
and you're massively increasing its proliferation.

How about putting each class of bitop into its own header file in
asm-generic, and getting the arches that need each one to include the
specific files it needs in its own bitops.h header?

For example, the hweight stuff would go into
asm-generic/bitops-hweight.h, and then asm-foo/bitops.h would just use

#include <asm-generic/bitops-hweight.h>

or else define its own if it didn't need the generic versions.

	<b

