Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261151AbUJ3NIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbUJ3NIs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 09:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbUJ3NIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 09:08:48 -0400
Received: from smtp-out.hotpop.com ([38.113.3.71]:60858 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S261151AbUJ3NIq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 09:08:46 -0400
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: linux-fbdev-devel@lists.sourceforge.net,
       Arjan van de Ven <arjan@infradead.org>, adaplas@pol.net
Subject: Re: [Linux-fbdev-devel] Re: 2.6.10-rc1-mm2: intelfb/AGP unknown symbols
Date: Sat, 30 Oct 2004 21:08:32 +0800
User-Agent: KMail/1.5.4
Cc: linux-fbdev-devel@lists.sourceforge.net, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>,
       Sylvain Meyer <sylvain.meyer@worldonline.fr>,
       linux-kernel@vger.kernel.org
References: <20041029014930.21ed5b9a.akpm@osdl.org> <200410301921.34961.adaplas@hotpop.com> <1099136087.3883.0.camel@laptop.fenrus.org>
In-Reply-To: <1099136087.3883.0.camel@laptop.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410302108.32872.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 30 October 2004 19:34, Arjan van de Ven wrote:
> > What's wrong with exporting the symbols back again?
>
> if they are the right api to use; nothing. If they aren't (and what you
> describe somehow suggests they aren't) it sounds better to make the
> frontend usable for the intelfb driver instead...
>

I think the functions are the right API to use for clients within the
kernel.  The frontend is directed more for userspace clients. 

The old interface was to do an inter_module_get/put, but this is to
be deprecated. And all it does is to provide all the backend functions
to the requestor.

Either  a new interface is provided by agpgart, otherwise, not just intelfb
and i810fb will be affected, but also DRM (which currently uses
inter_module_get/put("drm_agp")).

If I remember correctly, the DRI people also have a new patch that removes
inter_module_get/put and they did it by calling the backend functions directly.

Tony


