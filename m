Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267686AbUJHE6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267686AbUJHE6z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 00:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267689AbUJHE6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 00:58:54 -0400
Received: from fw.osdl.org ([65.172.181.6]:10397 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267686AbUJHE6x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 00:58:53 -0400
Date: Thu, 7 Oct 2004 21:57:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: piggin@cyberone.com.au, chrisw@osdl.org, linux-kernel@vger.kernel.org,
       davej@codemonkey.org.uk
Subject: Re: kswapd in tight loop 2.6.9-rc3-bk-recent
Message-Id: <20041007215702.7a20ba27.akpm@osdl.org>
In-Reply-To: <41661C30.6070102@yahoo.com.au>
References: <20041007142019.D2441@build.pdx.osdl.net>
	<20041007164044.23bac609.akpm@osdl.org>
	<4165E0A7.7080305@yahoo.com.au>
	<20041007174242.3dd6facd.akpm@osdl.org>
	<20041007184134.S2357@build.pdx.osdl.net>
	<20041007185131.T2357@build.pdx.osdl.net>
	<20041007185352.60e07b2f.akpm@osdl.org>
	<4165FF7B.1070302@cyberone.com.au>
	<20041007200109.57ce24ae.akpm@osdl.org>
	<416605CC.2080204@cyberone.com.au>
	<20041007203048.298029ab.akpm@osdl.org>
	<41660F64.3090802@cyberone.com.au>
	<41661C30.6070102@yahoo.com.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> -				if (zone->free_pages <= zone->pages_high) {
>  +				if (zone->free_pages < zone->pages_high) {

This is too subtle.  An open-coded test for non-zero ->present_pages is far
more readable and maintainable.

