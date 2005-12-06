Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932633AbVLFUPF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932633AbVLFUPF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 15:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932634AbVLFUPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 15:15:05 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:21400 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S932633AbVLFUPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 15:15:03 -0500
Date: Tue, 6 Dec 2005 18:14:49 -0200
From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       ehabkost@mandriva.com
Subject: Re: [PATCH 00/10] usb-serial: Switches from spin lock to atomic_t.
Message-Id: <20051206181449.11947f4f.lcapitulino@mandriva.com.br>
In-Reply-To: <20051206194041.GA22890@suse.de>
References: <20051206095610.29def5e7.lcapitulino@mandriva.com.br>
	<20051206194041.GA22890@suse.de>
Organization: Mandriva
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Dec 2005 11:40:41 -0800
Greg KH <gregkh@suse.de> wrote:

| On Tue, Dec 06, 2005 at 09:56:10AM -0200, Luiz Fernando Capitulino wrote:
| >  Greg,
| > 
| >  Don't get scared. :-)
| > 
| >  As showed by Eduardo Habkost some days ago, the spin lock 'lock' in the
| > struct 'usb_serial_port' is being used by some USB serial drivers to protect
| > the access to the 'write_urb_busy' member of the same struct.
| > 
| >  The spin lock however, is needless: we can change 'write_urb_busy' type
| > to be atomic_t and remove all the spin lock usage.
| 
| But if you do that, you make things slower on non-smp machines, which
| isn't very nice.  Why does the spinlock bother you?

 The spinlock makes the code less clear, error prone, and we already a
semaphore in the struct usb_serial_port.

 The spinlocks _seems_ useless to me.

-- 
Luiz Fernando N. Capitulino
