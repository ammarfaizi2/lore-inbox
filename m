Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266023AbUANJi2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 04:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265113AbUANJfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 04:35:32 -0500
Received: from colin2.muc.de ([193.149.48.15]:44548 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S263636AbUANJfB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 04:35:01 -0500
Date: 14 Jan 2004 10:35:56 +0100
Date: Wed, 14 Jan 2004 10:35:56 +0100
From: Andi Kleen <ak@colin2.muc.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org, jh@suse.cz
Subject: Re: [PATCH] Add CONFIG for -mregparm=3
Message-ID: <20040114093556.GB19652@colin2.muc.de>
References: <20040114090603.GA1935@averell> <20040114012928.1e90af3b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040114012928.1e90af3b.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 14, 2004 at 01:29:28AM -0800, Andrew Morton wrote:
> Andi Kleen <ak@muc.de> wrote:
> >
> >  I didn't make it the default because it will break all binary only
> >  modules (although they can be fixed by adding a wrapper that 
> >  calls them with "asmlinkage"). Actually it may be a good idea to 
> >  make this default with 2.7.1 or somesuch.
> 
> yes, that is a hassle.  But for these sorts of gains, it's worth pursuing
> it a bit further.
> 
> How _much_ of a hassle it will be I can not say - I'd be looking to vendors

I think the popular modules like nvidia or ATI could be fixed 
relatively easily.  They usually consist of a glue layer with source and a 
binary blob that is only called from the glue layer. Basically all you 
have to do is the mark the prototypes for the binary blob in the glue layer
as "asmlinkage". In addition this can be done without any ifdefs
because asmlinkage does the right thing on a non regparm kernel.

Of course true binary only modules without glue layer would be more
difficult, but for those the vendors just have to recompile. Conceivable
it would be possible to write a glue layer even for them.

> to advise before merging this into mainline.

I'm not sure why vendors should care as long as it's only a CONFIG_*.

The option is clearly more aimed at "kernel self compiler operators" for
now.

-Andi
