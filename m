Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750991AbVLGNDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbVLGNDj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 08:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751012AbVLGNDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 08:03:39 -0500
Received: from mail1.kontent.de ([81.88.34.36]:63155 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S1750982AbVLGNDi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 08:03:38 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
Subject: Re: [linux-usb-devel] Re: [PATCH 00/10] usb-serial: Switches from spin lock to atomic_t.
Date: Wed, 7 Dec 2005 14:01:25 +0100
User-Agent: KMail/1.8
Cc: linux-usb-devel@lists.sourceforge.net, zaitcev@redhat.com, gregkh@suse.de,
       linux-kernel@vger.kernel.org, ehabkost@mandriva.com
References: <20051206095610.29def5e7.lcapitulino@mandriva.com.br> <200512062336.47855.oliver@neukum.org> <20051207102540.792ee35c.lcapitulino@mandriva.com.br>
In-Reply-To: <20051207102540.792ee35c.lcapitulino@mandriva.com.br>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512071401.25934.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 7. Dezember 2005 13:25 schrieb Luiz Fernando Capitulino:
> On Tue, 6 Dec 2005 23:36:47 +0100
> Oliver Neukum <oliver@neukum.org> wrote:
> 
> | Am Dienstag, 6. Dezember 2005 22:18 schrieb Luiz Fernando Capitulino:
> | > 
> | >  Hi Pete,
> | > 
> | > On Tue, 6 Dec 2005 13:02:07 -0800
> | > Pete Zaitcev <zaitcev@redhat.com> wrote:
> | > 
> | > | On Tue, 6 Dec 2005 18:14:49 -0200, Luiz Fernando Capitulino <lcapitulino@mandriva.com.br> wrote:
> | > | 
> | > | >  The spinlock makes the code less clear, error prone, and we already a
> | > | > semaphore in the struct usb_serial_port.
> | > | > 
> | > | >  The spinlocks _seems_ useless to me.
> | > | 
> | > | Dude, semaphores are not compatible with interrupts. Surely you
> | > | understand that?
> | > 
> | >  Sure thing man, take a look at this thread:
> | > 
> | > http://marc.theaimsgroup.com/?l=linux-kernel&m=113216151918308&w=2
> | > 
> | >  My comment 'we already have a semaphore in struct usb_serial_port'
> | > was about what we've discussed in that thread, where question like
> | > 'why should we have yet another lock here?' have been made.
> | > 
> | >  And *not* 'let's use the semaphore instead'.
> | > 
> | >  If _speed_ does not make difference, the spinlock seems useless,
> | > because we could use atomic_t instead.
> | 
> | You can atomically set _one_ value using atomic_t. A spinlock allows
> | that and other more complex schemes.
> 
>  We only need to set 'write_urb_busy', nothing more.

So go hence and encapsulate that using the existent infrastructure. Thus
you get the most efficient solution.

	Regards
		Oliver
