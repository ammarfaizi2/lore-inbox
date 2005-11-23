Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932170AbVKWSyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbVKWSyw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 13:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbVKWSyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 13:54:52 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:37221 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S932170AbVKWSyw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 13:54:52 -0500
Date: Wed, 23 Nov 2005 19:55:23 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Kumar Gala <galak@gate.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: Add support for building uImages
Message-ID: <20051123185523.GC8336@mars.ravnborg.org>
References: <Pine.LNX.4.44.0511231242510.4183-100000@gate.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0511231242510.4183-100000@gate.crashing.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 12:43:15PM -0600, Kumar Gala wrote:
> +
> +$(obj)/uImage: $(obj)/vmlinux.gz
> +	$(Q)rm -f $@
> +	$(call if_changed,uimage)
> +	@echo -n '  Image: $@ '
> +	@if [ -f $@ ]; then echo 'is ready' ; else echo 'not made'; fi

The above is suboptimal. The $(call if_changed,uimage) will execute
$(cmd_uimage) if 1) prerequisites has changed or 2) the command to execute
has changed.
In the above case 1) is always true, otherwise we would not reach the
statement. So change it to $(call cmd,uimage) is the correct way.

The 'bug' is also present in ppc/boot/images

	Sam
