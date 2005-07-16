Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261795AbVGPW3P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261795AbVGPW3P (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 18:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261791AbVGPW3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 18:29:15 -0400
Received: from main.gmane.org ([80.91.229.2]:42455 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261795AbVGPW2F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 18:28:05 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: RE: 2.6.9 chrdev_open: serial_core: uart_open
Date: Sun, 17 Jul 2005 00:27:32 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.07.16.22.27.29.322105@smurf.noris.de>
References: <NDBBKFNEMLJBNHKPPFILIEALCEAA.karl@petzent.com> <1121472769.23918.16.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Alan Cox wrote:

> A good rule of thumb
> is to trace the sequence of calls and assume that the last sane sequence
> is the one that occurred before the failure.

Note also that gcc does sibling optimization, i.e. it will happily
reduce the code at the end of
	int bar(a,b) { [...] return baz(x,y); }
into something like
	overwrite 'a' with 'x', and 'b' with 'y'
	pop local stack frame, if present
	jump to baz

which saves some stack space and is faster, but makes you wonder
how in hell the
	baz
	foo
stack dump you're seeing in your crash dump came about.

(2.6.13 will turn that off when debugging.)

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
There is a vast difference between putting your nose in other people's
business and putting your heart in other people's problems.


