Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932676AbWBTG5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932676AbWBTG5y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 01:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932675AbWBTG5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 01:57:54 -0500
Received: from mail1.kontent.de ([81.88.34.36]:23021 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S932674AbWBTG5y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 01:57:54 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Flames over -- Re: Which is simpler?
Date: Mon, 20 Feb 2006 07:55:57 +0100
User-Agent: KMail/1.8
Cc: stern@rowland.harvard.edu, psusi@cfl.rr.com, pavel@suse.cz,
       torvalds@osdl.org, mrmacman_g4@mac.com, alon.barlev@gmail.com,
       linux-kernel@vger.kernel.org, linux-pm@lists.osdl.org
References: <43F89F55.5070808@cfl.rr.com> <200602192144.57748.oliver@neukum.org> <20060219130243.52af0782.akpm@osdl.org>
In-Reply-To: <20060219130243.52af0782.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200602200755.57699.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 19. Februar 2006 22:02 schrieb Andrew Morton:
> Oliver Neukum <oliver@neukum.org> wrote:
> >
> > Am Sonntag, 19. Februar 2006 21:02 schrieb Andrew Morton:
> > > For a), the current kernel behaviour is what we want - make the thing
> > > appear at a new place in the namespace and in the hierarchy.  Then
> > > userspace can do whatever needs to be done to identify the device, and
> > > apply some sort of policy decision to the result.
> > 
> > How? If you have a running user space the connection to the open files
> > is already severed, as any access in that time window must fail.
> 
> That's a separate issue, which we haven't discussed yet.  We have a device
> which has gone away and which might come back later on.  Presently we will
> return an I/O error if I/O is attempted in that window.  Obviously we'll
> need to do something different, such as block reads and block or defer writes.

But how do you handle memory management?
If you simply block writes, the system will stall random tasks laundering
pages, including those needed to make progress. Even syncing before
suspend won't help you, as a running user space may dirty pages.
And what about the rootfs?

	Oliver
