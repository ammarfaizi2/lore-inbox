Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262083AbSJVDf6>; Mon, 21 Oct 2002 23:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262089AbSJVDf6>; Mon, 21 Oct 2002 23:35:58 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:53741 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262083AbSJVDf4>;
	Mon, 21 Oct 2002 23:35:56 -0400
Subject: Re: [PATCH] 2.5.44: lkcd (7/9): dump configuration
From: "Suparna Bhattacharya" <suparna@sparklet.in.ibm.com>
Date: Tue, 22 Oct 2002 14:18:14 +0530
Message-Id: <pan.2002.10.22.14.18.14.702192.1573@sparklet.in.ibm.com>
References: <200210211016.g9LAG1V21200@nakedeye.aparity.com> <20021021165240.A14993@sgi.com>
X-Comment-To: "Christoph Hellwig" <hch@sgi.com>
Pan-Reverse-Path: suparna@sparklet.in.ibm.com
Pan-Mail-To: "Christoph Hellwig" <hch@sgi.com>
Pan-Server: ibm-ltc
Organization: IBM
Pan-Attribution: On Mon, 21 Oct 2002 19:13:16 +0530, Christoph Hellwig wrote:
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2002 19:13:16 +0530, Christoph Hellwig wrote:

>> +tristate 'Crash dump support' CONFIG_CRASH_DUMP
> 
> I"m very unhappy with this beeing a tristate.  We have the following
> things depend on it either builtin or modular:
> 
> (1) build Kerntypes
> (2) do not send smp_stop_cpu
> 
> and the following goes into dump.o:
> 
> (3) dump_base.c
> (4) dump_<arch>.c
> 
> Of those (2) should be replaced by a dump_in_progress check so that we
> poweroff even with dumping enabled, but not in progress.

The problem here is that dump_in_progress is set by the dump 
execution code which is invoked a little after this, and only
stays enabled as long as that function executes. Maybe what
you meant here is not dump_in_progress but something more like
dump_okay (which is currently a static in dump drivers code), 
or a check if the dump function is set, indicating that 
things are setup so that a dump would be taken ?

Regards
Suparna

> 
> The question is whether we should make (1) unconditional either or make
> it a separate bool (CONFIG_KERNELTYPES) so that that dump.o could be
> load into any such kernel.  But imho CONFIG_CRASH_DUMP should just
> become a bool - this way dump_<arch>.c could be moved into
> arch/<arch>/kernel and a lot of exports could be remove.
> 
> It's not much code either and the actual dump drivers stay modular.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html Please read the FAQ
> at  http://www.tux.org/lkml/
