Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261528AbVFBARh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbVFBARh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 20:17:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261546AbVFBAPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 20:15:04 -0400
Received: from fmr17.intel.com ([134.134.136.16]:47752 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S261557AbVFBAK7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 20:10:59 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] Abstracted Priority Inheritance for RT
Date: Wed, 1 Jun 2005 17:10:04 -0700
Message-ID: <F989B1573A3A644BAB3920FBECA4D25A03667149@orsmsx407>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Abstracted Priority Inheritance for RT
Thread-Index: AcVnBiHyIaeIIT5YRV2+mIu6TuZoaQAAPUYA
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: <dwalker@mvista.com>, "Esben Nielsen" <simlo@phys.au.dk>
Cc: "Ingo Molnar" <mingo@elte.hu>, <linux-kernel@vger.kernel.org>,
       <sdietrich@mvista.com>, <rostedt@goodmis.org>
X-OriginalArrivalTime: 02 Jun 2005 00:10:06.0656 (UTC) FILETIME=[6E84DC00:01C56707]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From: Daniel Walker [mailto:dwalker@mvista.com]
>On Wed, 2005-06-01 at 16:07 +0200, Esben Nielsen wrote:
>
>> Do you plan to use that callback for priority inheritance?
>> If so: It would lead to an recursive algorithm. That is not very nice
in
>> the kernel with a limited call-stack. It is not so much a problem if
the
>> mechanism is used in the kernel only, but if it is used for
user-space
>> locking, which can have unlimited neesting, it is potential problem.
>
>There is an API for for priority inheritance, the call by is strictly
>for the PI mechanism to signal when it changes a waiters priority , as
>the result of PI.
>
>It's somewhat explained in linux/pi.h . Currently the rt_mutex uses
this
>callback to move the waiter depending on it's new priority.
>
>I'm not sure I see how this could become recursive, could you explain
>more?

Maybe he is referring to the case?

A owns M
B owns N and is waiting for M
A is trying to wait for N

These deadlocking cases can be tricky during PI.

-- Inaky
