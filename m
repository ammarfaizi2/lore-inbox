Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262233AbVDLWeD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262233AbVDLWeD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 18:34:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262155AbVDLWbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 18:31:43 -0400
Received: from fmr18.intel.com ([134.134.136.17]:57783 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S263022AbVDLW1F convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 18:27:05 -0400
x-mimeole: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: FUSYN and RT
Date: Tue, 12 Apr 2005 15:26:14 -0700
Message-ID: <F989B1573A3A644BAB3920FBECA4D25A02FD4673@orsmsx407>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: FUSYN and RT
Thread-Index: AcU/rT2DaZ3/+eVPR8C13ABUzfhBDwAAQrvQ
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: <dwalker@mvista.com>, "Esben Nielsen" <simlo@phys.au.dk>
Cc: <linux-kernel@vger.kernel.org>, <mingo@elte.hu>
X-OriginalArrivalTime: 12 Apr 2005 22:26:17.0050 (UTC) FILETIME=[A4BAEBA0:01C53FAE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Daniel Walker [mailto:dwalker@mvista.com]
>
>On Tue, 2005-04-12 at 13:29, Esben Nielsen wrote:
>
>> So no, you will not need the same API, at all :-) Fusyn manipulates
>> task->static_prio and only task->prio when no RT lock is taken. When
the
>> first RT-lock is taken/released it manipulates task->prio only. A
release
>> of a Fusyn will manipulate task->static_prio as well as task->prio.
>
>mutex_setprio() , I don't know if you could call that an API but that's
>what I was talking about.. They should both use that. I think it would
>be better if the RT mutex (and fusyn) didn't depend on a field in the
>task_struct to retain the old priority. That would make it easier ..
>
>This goes back to the assumption that the locking isn't intermingled
>once you get into the kernel . The RT mutex can safely save the owner
>priority with out a Fusyn jumping in and changing it and the other way
>around..

You should not need any of this if your user space mutexes are a
wrapper over the kernel space ones. The kernel handles everything
the same and there is no need to take care of any special cases or
variations [other than the ones imposed by the wrapping].

-- Inaky
