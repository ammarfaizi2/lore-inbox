Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263204AbSLTRgu>; Fri, 20 Dec 2002 12:36:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263215AbSLTRgu>; Fri, 20 Dec 2002 12:36:50 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:56580 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263204AbSLTRgt>; Fri, 20 Dec 2002 12:36:49 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: PTRACE_GET_THREAD_AREA
Date: Fri, 20 Dec 2002 17:42:36 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <atvkqc$6kr$1@penguin.transmeta.com>
References: <200212200832.gBK8Wfg29816@magilla.sf.frob.com>
X-Trace: palladium.transmeta.com 1040406263 31818 127.0.0.1 (20 Dec 2002 17:44:23 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 20 Dec 2002 17:44:23 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200212200832.gBK8Wfg29816@magilla.sf.frob.com>,
Roland McGrath  <roland@redhat.com> wrote:
>This patch vs 2.5.51 (should apply fine to 2.5.52) adds two new ptrace
>requests for i386, PTRACE_GET_THREAD_AREA and PTRACE_SET_THREAD_AREA.
>These let another process using ptrace do the equivalent of performing
>get_thread_area and set_thread_area system calls for another thread.

Looks fine, except I'd ask you to split up the get/set logic as separate
functions, instead of making that case-statement thing horribly big.

Big functions are bad.

So please make it look something like

	case PTRACE_GET_THREAD_AREA:
		ret = ptrace_get_area(addr, (struct user_desc *) data);
		break;

	case PTRACE_SET_THREAD_AREA:
		ret = ptrace_set_area(addr, (struct user_desc *) data);
		break;

instead, ok?

		Linus
