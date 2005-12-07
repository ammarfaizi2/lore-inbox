Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750924AbVLGMYf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750924AbVLGMYf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 07:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750922AbVLGMYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 07:24:35 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:63639 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1750723AbVLGMYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 07:24:34 -0500
Date: Wed, 7 Dec 2005 10:24:19 -0200
From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-usb-devel@lists.sourceforge.net, ehabkost@mandriva.com,
       gregkh@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [PATCH 00/10] usb-serial: Switches from
 spin lock to atomic_t.
Message-Id: <20051207102419.1f395664.lcapitulino@mandriva.com.br>
In-Reply-To: <200512062348.14349.oliver@neukum.org>
References: <20051206095610.29def5e7.lcapitulino@mandriva.com.br>
	<20051206194041.GA22890@suse.de>
	<20051206201340.GB20451@duckman.conectiva>
	<200512062348.14349.oliver@neukum.org>
Organization: Mandriva
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Dec 2005 23:48:14 +0100
Oliver Neukum <oliver@neukum.org> wrote:

| Am Dienstag, 6. Dezember 2005 21:13 schrieb Eduardo Pereira Habkost:
| > Anyway, I don't see yet why the atomic_t would make the code slower on
| > non-smp. Is atomic_add_unless(v, 1, 1) supposed to be slower than
| > 'if (!v) v = 1;' ?
| 
| spin_lock() can be dropped on UP. atomic_XXX must either use an operation
| on main memory, meaning less efficient code generation, or must disable
| interrupts even on UP.

 Hmmm, I didn't know about the possibility to disable interrupts.

 In the OOPS thread:

http://marc.theaimsgroup.com/?l=linux-usb-devel&m=113269682409774&w=2

 *IIUC*, Greg told us that we could think about the possibility to drop
the spin lock and use the semaphore instead, because URB writes are slow.

 We (me and Eduardo) didn't like it because we would be using the same
lock for two different problems, so we suggested the atomic_t, and Greg
agreed (IIRC).

 Isn't it right? Is the URB write so fast that switching to atomic_t
doesn't pay-off?

-- 
Luiz Fernando N. Capitulino
