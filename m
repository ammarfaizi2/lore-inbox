Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030615AbWF0D1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030615AbWF0D1y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 23:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933343AbWF0D1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 23:27:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:10155 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S933331AbWF0D1x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 23:27:53 -0400
Date: Mon, 26 Jun 2006 23:27:38 -0400
From: Dave Jones <davej@redhat.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: list corruption on removal of snd_seq_dummy
Message-ID: <20060627032738.GA26575@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060623031526.GB19461@redhat.com> <s5hzmg49mi5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hzmg49mi5.wl%tiwai@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2006 at 12:47:46PM +0200, Takashi Iwai wrote:
 
 > > The code in question is doing..
 > > 
 > >         __list_add(&deleted_list,
 > >                client->ports_list_head.prev,
 > >                client->ports_list_head.next);
 > > 
 > > which looks fishy, as those two elements aren't going to be consecutive,
 > > as __list_add expects.
 > 
 > I think the code behaves correctly but probably misusing __list_add().
 > It movies the whole entries from an existing list_head A
 > (clients->ports_list_head) to a new list_head B (deleted_list).
 > The above is exapnded:
 > 
 > 	A->next->prev = B;
 > 	B->next = A->next;
 > 	B->prev = A->prev;
 > 	A->prev->next = B;
 > 
 > Any better way to achieve it using standard macros?

Why can't you just list_move() the elements ?

		Dave

-- 
http://www.codemonkey.org.uk
