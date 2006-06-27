Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161210AbWF0Q7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161210AbWF0Q7L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 12:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161213AbWF0Q7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 12:59:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:3234 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161210AbWF0Q7J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 12:59:09 -0400
Date: Tue, 27 Jun 2006 12:58:19 -0400
From: Dave Jones <davej@redhat.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       alsa-devel <alsa-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: list corruption on removal of snd_seq_dummy
Message-ID: <20060627165819.GC1280@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Takashi Iwai <tiwai@suse.de>,
	Chuck Ebbert <76306.1226@compuserve.com>,
	alsa-devel <alsa-devel@lists.sourceforge.net>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <200606270808_MC3-1-C391-2F33@compuserve.com> <s5h8xniwz74.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5h8xniwz74.wl%tiwai@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2006 at 02:38:39PM +0200, Takashi Iwai wrote:
 > > > No, list_move() can't move the whole elements without loop.
 > > > 
 > > > A solution is
 > > > 
 > > >       list_add(B, A);
 > > >       list_del_init(A);
 > > > 
 > > > (although this introduces a bit more code :)
 > > 
 > > Shouldn't it be like this?
 > > 
 > >         ports_list_first = client->ports_list_head.next;
 > >         list_del_init(client->ports_list_head);
 > >         list_splice(ports_list_first, &deleted_list);
 > 
 > This requires INIT_LIST_HEAD(&deleted_list) first, so obviously
 > a longer code :)

This is hardly a speed/size critical function. I'd go for readability
over cute hacks any day.

		Dave

-- 
http://www.codemonkey.org.uk
