Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261291AbSJUNbn>; Mon, 21 Oct 2002 09:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261293AbSJUNbn>; Mon, 21 Oct 2002 09:31:43 -0400
Received: from tolkor.sgi.com ([198.149.18.6]:9650 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S261291AbSJUNbn>;
	Mon, 21 Oct 2002 09:31:43 -0400
Date: Mon, 21 Oct 2002 16:52:40 -0400
From: Christoph Hellwig <hch@sgi.com>
To: "Matt D. Robinson" <yakker@aparity.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.44: lkcd (7/9): dump configuration
Message-ID: <20021021165240.A14993@sgi.com>
Mail-Followup-To: Christoph Hellwig <hch@sgi.com>,
	"Matt D. Robinson" <yakker@aparity.com>,
	linux-kernel@vger.kernel.org
References: <200210211016.g9LAG1V21200@nakedeye.aparity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200210211016.g9LAG1V21200@nakedeye.aparity.com>; from yakker@aparity.com on Mon, Oct 21, 2002 at 03:16:01AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +tristate 'Crash dump support' CONFIG_CRASH_DUMP

I"m very unhappy with this beeing a tristate.  We have the following
things depend on it either builtin or modular:

(1) build Kerntypes
(2) do not send smp_stop_cpu

and the following goes into dump.o:

(3) dump_base.c
(4) dump_<arch>.c

Of those (2) should be replaced by a dump_in_progress check so
that we poweroff even with dumping enabled, but not in progress.

The question is whether we should make (1) unconditional either
or make it a separate bool (CONFIG_KERNELTYPES) so that that dump.o
could be load into any such kernel.  But imho CONFIG_CRASH_DUMP
should just become a bool - this way dump_<arch>.c could be moved
into arch/<arch>/kernel and a lot of exports could be remove.

It's not much code either and the actual dump drivers stay modular.

