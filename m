Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265288AbUEUAQM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265288AbUEUAQM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 20:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265290AbUEUAQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 20:16:11 -0400
Received: from pao-nav01.pao.digeo.com ([12.47.58.24]:3848 "HELO
	pao-nav01.pao.digeo.com") by vger.kernel.org with SMTP
	id S265288AbUEUAQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 20:16:08 -0400
Date: Thu, 20 May 2004 17:17:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: davidm@hpl.hp.com
Cc: hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Spam: Re: [PATCH] fixing sendfile on 64bit architectures
Message-Id: <20040520171758.1bec1db7.akpm@osdl.org>
In-Reply-To: <16557.17112.488236.662911@napali.hpl.hp.com>
References: <26879984$108499340940abaf81679ba6.07529629@config22.schlund.de>
	<16556.19979.951743.994128@napali.hpl.hp.com>
	<20040519234106.52b6db78.davem@redhat.com>
	<16556.65456.624986.552865@napali.hpl.hp.com>
	<20040520120645.3accf048.akpm@osdl.org>
	<16557.1651.307484.282000@napali.hpl.hp.com>
	<20040520203532.A11902@infradead.org>
	<16557.4709.694265.314748@napali.hpl.hp.com>
	<20040520145658.3a7bf7df.akpm@osdl.org>
	<16557.11429.671546.228557@napali.hpl.hp.com>
	<20040520163026.64cc0421.akpm@osdl.org>
	<16557.17112.488236.662911@napali.hpl.hp.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 May 2004 00:15:17.0760 (UTC) FILETIME=[B237D000:01C43EC8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger <davidm@napali.hpl.hp.com> wrote:
>
> The attached patch should have these fixed.

That builds OK on ia32, sparc64, ppc64 and, I assume, ia64.

x86_64 has a problem in ipc/util.c:

	int ipc_parse_version (int *cmd)
	{

comes out as

	int 0x0100
	{

due to:

#if defined(__ia64__) || defined(__x86_64__) || defined(__hppa__)
  /* On IA-64, we always use the "64-bit version" of the IPC structures.  */ 
# define ipc_parse_version(cmd)	IPC_64
#else
int ipc_parse_version (int *cmd);
#endif


