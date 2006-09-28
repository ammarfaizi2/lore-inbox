Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965395AbWI1LjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965395AbWI1LjK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 07:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965403AbWI1LjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 07:39:09 -0400
Received: from web26504.mail.ukl.yahoo.com ([217.146.176.41]:61808 "HELO
	web26504.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1161087AbWI1LjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 07:39:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=UINzf3Flc6+GX4EGAvLpu3gvV4bR2n7NXWJZO+lRvCaXfov42PDUaXt6rD7lFaVGjuI5VKoa8ShN1dHQH6HKNicrfUyb4NCwnHaWtYipS1XaIf5oS7kOAd6HxjakQnzuamCEdwwvZ9vu5DHNQVm96IhaU/6w3rlYMw8aWubRryk=  ;
Message-ID: <20060928113906.20550.qmail@web26504.mail.ukl.yahoo.com>
Date: Thu, 28 Sep 2006 13:39:06 +0200 (CEST)
From: karsten wiese <annabellesgarden@yahoo.de>
Subject: Re: [PATCH] Reset file->f_op in snd_card_file_remove()
To: Takashi Iwai <tiwai@suse.de>
Cc: mingo@elte.hu, alsa-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <s5h4puspal8.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Takashi Iwai <tiwai@suse.de> schrieb:

> At Wed, 27 Sep 2006 21:27:51 +0200,
> Karsten Wiese wrote:
> > 
> > Hi
> > 
> > This patch helps prevent an oops on 2.6.18-rt3,
> > when my usb usx2y soundcard disconnects.
> > Physically disconnects or "rmmod uhci_hc" both oops 1in7.
> > 
> > With this patch still no oops after > 1000 disconnects.
> > 
> > Please apply/comment.
> > 
> >       thanks,
> >       Karsten
> > 
> > ===
> > 
> > Reset file->f_op in snd_card_file_remove()
> > 
> > When passing here in response to an usb disconnect,
> > file->f_op has been replaced with a kmalloc()ed version,
> > that would only allow releases.
> > 
> > It will be free()ed later on in snd_card_free().
> > Here it happened sometimes, that the free()ed, not NULLed file->f_op
> > caused an oops in module_put() called by fops_put() still later on.
> > 
> > Signed-off-by: Karsten Wiese <annabellesgarden@yahoo.de>
> 
> snd_card_file_remove() is not a right place to do that, IMO.
> 
you are right, patch is wrong: it causes snd_hwdep's use count corruption.

> Could you check whether this problem still happens on post-2.6.18?
> There are a lot of fixes in this area after 2.6.18.
> 
i'm now running 2.6.18-rt3 + alsa-driver-1.0.13rc1 and problem seams to be gone.

      Karsten


	

	
		
___________________________________________________________ 
Der frühe Vogel fängt den Wurm. Hier gelangen Sie zum neuen Yahoo! Mail: http://mail.yahoo.de
