Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263380AbUEKTDU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263380AbUEKTDU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 15:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263389AbUEKTDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 15:03:19 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28140 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263380AbUEKTA6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 15:00:58 -0400
Date: Tue, 11 May 2004 11:59:34 -0700
From: "David S. Miller" <davem@redhat.com>
To: dan.dickey@savvis.net
Cc: m.c.p@kernel.linux-systeme.com, linux-kernel@vger.kernel.org,
       kuznet@ms2.inr.ac.ru
Subject: Re: Sock leak in net/ipv4/af_inet.c - 2.4.26
Message-Id: <20040511115934.0c591667.davem@redhat.com>
In-Reply-To: <200405111225.38072.dan.dickey@savvis.net>
References: <200405111843.50048@WOLK>
	<200405111225.38072.dan.dickey@savvis.net>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The sk_free() should occur when the final sock_put() call brings the count
down to zero, then the socket destroy function is called and the eventual
sk_free() occurs there.
