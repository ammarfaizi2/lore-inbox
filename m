Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbUC1M7H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 07:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbUC1M7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 07:59:07 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:522 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261704AbUC1M7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 07:59:05 -0500
Date: Sun, 28 Mar 2004 14:58:52 +0200
From: Willy TARREAU <willy@w.ods.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, chas@cmf.nrl.navy.mil
Subject: [PATCH-2.4.26] ATM cleanup
Message-ID: <20040328125852.GH24421@pcw.home.local>
References: <20040328042608.GA17969@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040328042608.GA17969@logos.cnet>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo, Chas,

Compiling ATM from 2.4.26-rc1 on alpha says :

mpoa_proc.c: In function `proc_mpc_read':
mpoa_proc.c:117: warning: passing arg 2 of `atm_mpoa_disp_qos' from incompatible pointer type

117:    atm_mpoa_disp_qos((char *)page, &length); 

it is because length is declared ssize_t (the function's return type),
while atm_mpoa_disp_qos() expects an int. Changing length type to int
clears the warning.

Please apply,
Willy

--- ./net/atm/mpoa_proc.c.orig	Sun Mar 28 14:52:17 2004
+++ ./net/atm/mpoa_proc.c	Sun Mar 28 14:52:34 2004
@@ -102,7 +102,7 @@
 			     size_t count, loff_t *pos){
         unsigned long page = 0;
 	unsigned char *temp;
-        ssize_t length  = 0;
+        int length  = 0;
 	int i = 0;
 	struct mpoa_client *mpc = mpcs;
 	in_cache_entry *in_entry;

