Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbTKLFTW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 00:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbTKLFTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 00:19:22 -0500
Received: from fmr06.intel.com ([134.134.136.7]:36526 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S261684AbTKLFTU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 00:19:20 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: prepare_wait / finish_wait question
Date: Tue, 11 Nov 2003 21:19:17 -0800
Message-ID: <A20D5638D741DD4DBAAB80A95012C0AED791DE@orsmsx409.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: prepare_wait / finish_wait question
Thread-Index: AcOmrnjhHos+bFp7TrycmLNvwHQfgQCLadlQ
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "Manfred Spraul" <manfred@colorfullife.com>,
       "Andrew Morton" <akpm@osdl.org>
Cc: <mingo@elte.hu>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 12 Nov 2003 05:19:18.0104 (UTC) FILETIME=[85692D80:01C3A8DC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Manfred Spraul

> Andrew Morton wrote:
> >Manfred Spraul <manfred@colorfullife.com> wrote:

> >It would be neater to remove the task from the list _before_ waking it up.
> >The current code in there is careful to only remove the task if the wakeup
> >attempt was successful, but I have a feeling that this is unnecessary - the
> >waiting task will do the right thing.  One would need to think about that a
> >bit more.
>
> Doesn't work: the woken up thread could be woken up by chance through a
> signal, and then the task structure could go out of scope while wake_up
> is still running - oops. Seen on s390 with sysv msg.

What about some safe wake up mechanism like get_task_struct()/__wake_up()/
put_task_struct()??

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own (and my fault)
