Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261732AbSJUVm3>; Mon, 21 Oct 2002 17:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261733AbSJUVm3>; Mon, 21 Oct 2002 17:42:29 -0400
Received: from tolkor.sgi.com ([198.149.18.6]:61671 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S261732AbSJUVmX>;
	Mon, 21 Oct 2002 17:42:23 -0400
Date: Tue, 22 Oct 2002 01:03:15 -0400
From: Christoph Hellwig <hch@sgi.com>
To: "Matt D. Robinson" <yakker@aparity.com>
Cc: Christoph Hellwig <hch@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.44: lkcd (7/9): dump configuration
Message-ID: <20021022010315.B18122@sgi.com>
Mail-Followup-To: Christoph Hellwig <hch@sgi.com>,
	"Matt D. Robinson" <yakker@aparity.com>,
	linux-kernel@vger.kernel.org
References: <20021021165240.A14993@sgi.com> <Pine.LNX.4.44.0210211208150.22662-100000@nakedeye.aparity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0210211208150.22662-100000@nakedeye.aparity.com>; from yakker@aparity.com on Mon, Oct 21, 2002 at 01:48:51PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2002 at 01:48:51PM -0700, Matt D. Robinson wrote:
> On Mon, 21 Oct 2002, Christoph Hellwig wrote:
> |>> +tristate 'Crash dump support' CONFIG_CRASH_DUMP
> |>
> |>I"m very unhappy with this beeing a tristate.  We have the following
> |>things depend on it either builtin or modular:
> |>
> |>(1) build Kerntypes
> |>(2) do not send smp_stop_cpu
> |>
> |>and the following goes into dump.o:
> |>
> |>(3) dump_base.c
> |>(4) dump_<arch>.c
> |>
> |>Of those (2) should be replaced by a dump_in_progress check so
> |>that we poweroff even with dumping enabled, but not in progress.
> 
> There is the concept of non-distruptive dumping, which means
> that you don't power off after a dump -- you keep running.  In
> other words, you can silence the system and then resume after
> a dump is taken.  It's a way of snapshotting the system state
> which is possible today.

I don't see the relation of that to always disabling smp_send_stop()
in panic().  You only want to disable it if doing a dump, right?

> Wow ... we spent a ton of time moving all the code _out_ of the
> arch directories as other kernel developers didn't want it there.

Hmm.  It certainbly is arch-specific..

> From one perspective, the base dump driver is needed in order to
> provide the upper level dumping capabilities as well as some of
> the architecture-specific functionality.  That said, however, if
> you make it a bool, it's either on or off -- some people don't
> want it in the kernel all the time, and shouldn't be required
> to build in.

Well, any chance you could get rid of the remaining 
CONFIG_CRASH_DUMP || CONFIG_CRASH_DUMP_MODULE ifdefs when
keeping it as tristate?  So that I can just load the module
into any kernel?

