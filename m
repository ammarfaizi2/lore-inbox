Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936390AbWLFQ0W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936390AbWLFQ0W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 11:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936393AbWLFQ0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 11:26:22 -0500
Received: from ns1.suse.de ([195.135.220.2]:58482 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936390AbWLFQ0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 11:26:22 -0500
Date: Wed, 6 Dec 2006 17:26:20 +0100
From: Jan Blunck <jblunck@suse.de>
To: Phil Endecott <phil_arcwk_endecott@chezphil.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Subtleties of __attribute__((packed))
Message-ID: <20061206162620.GA4942@hasse.suse.de>
References: <20061206155439.GA6727@hasse.suse.de> <1165421636345@dmwebmail.belize.chezphil.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1165421636345@dmwebmail.belize.chezphil.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, Phil Endecott wrote:

> 
> To see a difference with your example structs you need to compare these two:
> 
> struct wibble1 {
>   char c;
>   struct bar1 b1;
> };
> 
> struct wibble2 {
>   char c;
>   struct bar2 b2;
> };
> 
> struct wibble1 w1 = { 1, { 2, {3,4,5} } };
> struct wibble2 w2 = { 1, { 2, {3,4,5} } };
> 
> Can you try that with your compilers?  I get:
> 

As I expected, I get:

	.file	"packed2a.c"
.globl w1
.data
	.align	2
	.type	w1, @object
	.size	w1, 14
w1:
	.byte	1
	.byte	2
	.4byte	3
	.byte	4
	.zero	3
	.4byte	5
.globl w2
	.align	2
	.type	w2, @object
	.size	w2, 14
w2:
	.byte	1
	.byte	2
	.4byte	3
	.byte	4
	.zero	3
	.4byte	5
	.ident	"GCC: (GNU) 4.1.2 20060531 (prerelease) (SUSE Linux)"
	.section	.note.GNU-stack,"",@progbits
