Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276193AbRI1RjK>; Fri, 28 Sep 2001 13:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276197AbRI1RjA>; Fri, 28 Sep 2001 13:39:00 -0400
Received: from mueller.uncooperative.org ([216.254.102.19]:49157 "EHLO
	mueller.datastacks.com") by vger.kernel.org with ESMTP
	id <S276200AbRI1Riq>; Fri, 28 Sep 2001 13:38:46 -0400
Date: Fri, 28 Sep 2001 11:58:52 -0400
From: Crutcher Dunnavant <crutcher@datastacks.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] link failur in Linux 2.4.9-ac16 around apm.o and sysrq.o
Message-ID: <20010928115852.A31612@mueller.datastacks.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010927185107.A17861@lightning.swansea.linux.org.uk> <7v8zezki0b.fsf@siamese.dhis.twinsun.com> <7v1ykrkgt2.fsf@siamese.dhis.twinsun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <7v1ykrkgt2.fsf@siamese.dhis.twinsun.com>; from junio@siamese.dhis.twinsun.com on Thu, Sep 27, 2001 at 10:47:21PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

++ 27/09/01 22:47 -0700 - junio@siamese.dhis.twinsun.com:
> >>>>> "JNH" == junio  <junio@siamese.dhis.twinsun.com> writes:
> 
> JNH> 2.4.9-ac16 fails to link with CONFIG_APM=y and
> JNH> CONFIG_MAGIC_SYSRQ=n.  This is because apm.c unconditionally
> JNH> makes calls to functions (__sysrq_lock_table and friends)
> JNH> defined in sysrq.c.
> 
> JNH> I can think of a couple of different approaches to work this
> JNH> around, but is there an established proper way to resolve this
> JNH> kind of dependency in the kernel code?
> 
> The approaches I listed as (1) and (3) in my previous message
> are non solutions, since it will result in a kernel where apm.o
> makes calls into sysrq functions, whose proper operations would
> depend on sysrq.o to have been properly initialized by other
> parts of the kernel, which still think CONFIG_MAGIC_SYSRQ is not
> defined.

This all became an issue when a patch was requested, and created
where people DIDN't want to #ifdef in their modules. I think that
My approach there was hosed, and that we need to go back to the 
stubs in sysrq.h method, but for all exposed symbols. If every
module which wants to use sysrq has to #ifdef things, code gets ugly.

-- 
Crutcher        <crutcher@datastacks.com>
GCS d--- s+:>+:- a-- C++++$ UL++++$ L+++$>++++ !E PS+++ PE Y+ PGP+>++++
    R-(+++) !tv(+++) b+(++++) G+ e>++++ h+>++ r* y+>*$
