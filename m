Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbVLGPHX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbVLGPHX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 10:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbVLGPHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 10:07:23 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:60133 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751131AbVLGPHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 10:07:19 -0500
Date: Wed, 7 Dec 2005 10:07:15 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Oliver Neukum <oliver@neukum.org>
cc: linux-usb-devel@lists.sourceforge.net,
       Eduardo Pereira Habkost <ehabkost@mandriva.com>,
       Greg KH <gregkh@suse.de>,
       Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] Re: [PATCH 00/10] usb-serial: Switches from
 spin lock to atomic_t.
In-Reply-To: <200512062348.14349.oliver@neukum.org>
Message-ID: <Pine.LNX.4.44L0.0512071000120.21143-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Dec 2005, Oliver Neukum wrote:

> Am Dienstag, 6. Dezember 2005 21:13 schrieb Eduardo Pereira Habkost:
> > Anyway, I don't see yet why the atomic_t would make the code slower on
> > non-smp. Is atomic_add_unless(v, 1, 1) supposed to be slower than
> > 'if (!v) v = 1;' ?
> 
> spin_lock() can be dropped on UP. atomic_XXX must either use an operation
> on main memory, meaning less efficient code generation, or must disable
> interrupts even on UP.

atomic_add_unless is sort of a special case.  It doesn't have a clean 
simple implementation, unlike most of the other atomic_t operations.  If 
an equivalent result could be obtained using, e.g., atomic_inc_and_test, 
that would be a better approach.

On the other hand, Oliver needs to be careful about claiming too much.  In 
general atomic_t operations _are_ superior to the spinlock approach.  If 
they weren't, atomic_t wouldn't belong in the kernel at all.

Alan Stern

