Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964845AbWH1LxC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964845AbWH1LxC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 07:53:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964839AbWH1LxC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 07:53:02 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:24813 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964837AbWH1LxA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 07:53:00 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Organization: IBM Deutschland Entwicklung GmbH
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 04/18] [PATCH] BLOCK: Separate the bounce buffering code from the highmem code [try #4]
Date: Mon, 28 Aug 2006 13:52:57 +0200
User-Agent: KMail/1.9.1
Cc: Sam Ravnborg <sam@ravnborg.org>, axboe@kernel.dk,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20060825200455.GA2629@uranus.ravnborg.org> <20060825193707.11384.97372.stgit@warthog.cambridge.redhat.com> <22040.1156537104@warthog.cambridge.redhat.com>
In-Reply-To: <22040.1156537104@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200608281352.58281.arnd.bergmann@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 25 August 2006 22:18, David Howells wrote:
> > > +ifeq ($(CONFIG_MMU),y)
> > > +obj-y                      += bounce.o
> > > +endif
> > 
> > CONFIG_MMU is a bool so you can do this much more elegant:
> > obj-$(CONFIG_MMU) += bounce.o
> 
> In patch 18/18, this changes to:
> 
>         ifeq ($(CONFIG_MMU)$(CONFIG_BLOCK),yy)
> 
> So the elegence in the end is irrelevant.

You could write it as

bounce-$(CONFIG_MMU) += bounce.o
obj-$(CONFIG_BLOCK)  += $(bounce-y)

	Arnd <><
