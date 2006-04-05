Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751038AbWDEA2w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbWDEA2w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 20:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751040AbWDEA2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 20:28:52 -0400
Received: from mail.gondor.com ([212.117.64.182]:41225 "EHLO moria.gondor.com")
	by vger.kernel.org with ESMTP id S1751036AbWDEA2w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 20:28:52 -0400
Date: Wed, 5 Apr 2006 02:28:47 +0200
From: Jan Niehusmann <jan@gondor.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Ken Moffat <zarniwhoop@ntlworld.com>, linux-kernel@vger.kernel.org,
       alsa-devel@alsa-project.org
Subject: Re: [Alsa-devel] Slab corruptions & Re: 2.6.17-rc1: Oops in sound applications
Message-ID: <20060405002846.GA5201@knautsch.gondor.com>
References: <Pine.LNX.4.63.0604032155220.17605@deepthought.mydomain> <20060404133814.GA11741@knautsch.gondor.com> <s5hlkul72rv.wl%tiwai@suse.de> <20060404190631.GA4895@knautsch.gondor.com> <s5h7j656tpp.wl%tiwai@suse.de> <20060404231911.GA4862@knautsch.gondor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060404231911.GA4862@knautsch.gondor.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2006 at 01:19:11AM +0200, Jan Niehusmann wrote:
> ...which happens to be the commit which contains the bug you already
> mentioned. I wonder if there is a second one hidden somewhere in that
> commit, or if git-bisect led me to that bug while the second one is
> hidden in a different commit...

Well, I did some additional debugging on that, working on git version
3bf75f9b90c981f18f27a0d35a44f488ab68c8ea:

In snd_pcm_oss_release() I added 
snd_assert(substream != NULL, return -ENXIO); 
in front of the first access to substream->pcm, which leads to

Apr  5 02:13:13 knautsch kernel: [17180638.784000] BUG? (substream != ((void *)0))

when opening /dev/dsp for write.

If I now add the patch you suggested, correcting the check in
snd_pcm_oss_open_file(), accessing /dev/dsp instead leads to EINVAL.

So I guess git bisect really lead me to this already known bug.

Jan

