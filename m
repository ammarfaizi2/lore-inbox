Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263322AbTDGIIC (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 04:08:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263324AbTDGIIC (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 04:08:02 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:64777 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263322AbTDGIHx (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 04:07:53 -0400
Date: Mon, 7 Apr 2003 09:19:23 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: Nicholas Wourms <dragon@gentoo.org>, Christoph Hellwig <hch@lst.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove kdevname() before someone starts using it again
Message-ID: <20030407091923.B28879@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Nikita Danilov <Nikita@Namesys.COM>,
	Nicholas Wourms <dragon@gentoo.org>, Christoph Hellwig <hch@lst.de>,
	linux-kernel@vger.kernel.org
References: <20030331162634.A14319@lst.de> <3E908DF6.1050004@gentoo.org> <16017.11269.576246.373826@laputa.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16017.11269.576246.373826@laputa.namesys.com>; from Nikita@Namesys.COM on Mon, Apr 07, 2003 at 11:43:01AM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 07, 2003 at 11:43:01AM +0400, Nikita Danilov wrote:
> Nicholas Wourms writes:
>  > 
>  > A quick grep shows that Intermezzo FS still uses kdevname if 
>  > you've turned on debugging (fs/intermezzo/sysctl.c).  As for 
>  > pending stuff, both Reiser4 & pktcdvd also use it.  So I 
> 
> reiser4 switched to bdevname().

Although bdevname is the simplest replacement it's usually the wrong
one.  If you refer to a filesystem with it use sb->s_id, if you refer
to a block device you normally want to use partition_name() - it gives
much nicer output.

