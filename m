Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751047AbVLGNSB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbVLGNSB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 08:18:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751050AbVLGNSB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 08:18:01 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:3525 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1751046AbVLGNSA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 08:18:00 -0500
Date: Wed, 7 Dec 2005 11:17:45 -0200
From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-usb-devel@lists.sourceforge.net, zaitcev@redhat.com, gregkh@suse.de,
       linux-kernel@vger.kernel.org, ehabkost@mandriva.com
Subject: Re: [linux-usb-devel] Re: [PATCH 00/10] usb-serial: Switches from
 spin lock to atomic_t.
Message-Id: <20051207111745.4f500007.lcapitulino@mandriva.com.br>
In-Reply-To: <200512071401.25934.oliver@neukum.org>
References: <20051206095610.29def5e7.lcapitulino@mandriva.com.br>
	<200512062336.47855.oliver@neukum.org>
	<20051207102540.792ee35c.lcapitulino@mandriva.com.br>
	<200512071401.25934.oliver@neukum.org>
Organization: Mandriva
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Dec 2005 14:01:25 +0100
Oliver Neukum <oliver@neukum.org> wrote:

| Am Mittwoch, 7. Dezember 2005 13:25 schrieb Luiz Fernando Capitulino:
| > On Tue, 6 Dec 2005 23:36:47 +0100
| > Oliver Neukum <oliver@neukum.org> wrote:
| > 
| > | Am Dienstag, 6. Dezember 2005 22:18 schrieb Luiz Fernando Capitulino:
| > | > 
| > | >  Hi Pete,
| > | > 
| > | > On Tue, 6 Dec 2005 13:02:07 -0800
| > | > Pete Zaitcev <zaitcev@redhat.com> wrote:
| > | > 
| > | > | On Tue, 6 Dec 2005 18:14:49 -0200, Luiz Fernando Capitulino <lcapitulino@mandriva.com.br> wrote:
| > | > | 
| > | > | >  The spinlock makes the code less clear, error prone, and we already a
| > | > | > semaphore in the struct usb_serial_port.
| > | > | > 
| > | > | >  The spinlocks _seems_ useless to me.
| > | > | 
| > | > | Dude, semaphores are not compatible with interrupts. Surely you
| > | > | understand that?
| > | > 
| > | >  Sure thing man, take a look at this thread:
| > | > 
| > | > http://marc.theaimsgroup.com/?l=linux-kernel&m=113216151918308&w=2
| > | > 
| > | >  My comment 'we already have a semaphore in struct usb_serial_port'
| > | > was about what we've discussed in that thread, where question like
| > | > 'why should we have yet another lock here?' have been made.
| > | > 
| > | >  And *not* 'let's use the semaphore instead'.
| > | > 
| > | >  If _speed_ does not make difference, the spinlock seems useless,
| > | > because we could use atomic_t instead.
| > | 
| > | You can atomically set _one_ value using atomic_t. A spinlock allows
| > | that and other more complex schemes.
| > 
| >  We only need to set 'write_urb_busy', nothing more.
| 
| So go hence and encapsulate that using the existent infrastructure. Thus
| you get the most efficient solution.

 Yes, I was speaking about it with Eduardo some minutes ago.

 My only question is: currently the spin lock is not acquired for unlock
operations (ie, setting 'write_urb_busy' to 0), and to check
'write_usb_busy' value. I don't know if it's safe.

  But, If I add the spin_lock()/spin_unlock() functions in my 'unlock'
and 'locked' methods, I could increase the latency for SMP systems.
 
 Suggestions? Eduardo? Greg?

-- 
Luiz Fernando N. Capitulino
